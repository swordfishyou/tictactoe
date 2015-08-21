//
//  TTTViewController+NewGame.m
//  
//
//  Created by Anatoly Tukhtarov on 8/8/15.
//
//

#import "TTTViewController+NewGame.h"

NSString * const TTTGameOptionsActionSheetTitle = @"Versus AI";
NSString * const TTTGameOptionsActionSheetComputerFirstOption = @"AI goes first";
NSString * const TTTGameOptionsActionSheetHumanFirstOption = @"Human goes first";
NSString * const TTTGameOptionsActionSheetCancelOption = @"Cancel";

@implementation TTTViewController (NewGame)
- (void)showGameOptionsActionSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(TTTGameOptionsActionSheetTitle, nil)
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(TTTGameOptionsActionSheetCancelOption, nil)
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(TTTGameOptionsActionSheetComputerFirstOption, nil), NSLocalizedString(TTTGameOptionsActionSheetHumanFirstOption, nil), nil];
    [actionSheet showInView:self.view];
}

#pragma mark - Action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
    if (self.game.players.count != 0) {
        [self.game endGame];
        [self.collectionView reloadData];
    }
    
    self.collectionView.userInteractionEnabled = YES;
    
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:NSLocalizedString(TTTGameOptionsActionSheetComputerFirstOption, nil)]) {
        [self.game acceptInviteFromPlayer:self.computerPlayer];
        [self.game acceptInviteFromPlayer:self.humanPlayer];
    } else {
        [self.game acceptInviteFromPlayer:self.humanPlayer];
        [self.game acceptInviteFromPlayer:self.computerPlayer];
    }
}
@end
