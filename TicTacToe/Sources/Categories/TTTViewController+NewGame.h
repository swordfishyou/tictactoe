//
//  TTTViewController+NewGame.h
//  
//
//  Created by Anatoly Tukhtarov on 8/8/15.
//
//

#import "TTTViewController_Internal.h"

extern NSString * const TTTGameOptionsActionSheetTitle;
extern NSString * const TTTGameOptionsActionSheetComputerFirstOption;
extern NSString * const TTTGameOptionsActionSheetHumanFirstOption;
extern NSString * const TTTGameOptionsActionSheetCancelOption;

@interface TTTViewController (NewGame) <UIActionSheetDelegate>
- (void)showGameOptionsActionSheet;
@end
