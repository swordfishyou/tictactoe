//
//  ViewController.m
//  TicTacToe
//
//  Created by Anatoly Tukhtarov on 8/4/15.
//  Copyright (c) 2015 Anatoly Tukhtarov. All rights reserved.
//

#import "TTTViewController+NewGame.h"

@implementation TTTViewController
- (void)dealloc {
    [self.computerPlayer removeObserver:self
                             forKeyPath:@"decision"
                                context:TTTComputerPlayerDecisionContext];
    [self.computerPlayer removeObserver:self
                             forKeyPath:@"localizedStatusDescription"
                                context:TTTComputerPlayerStatusChangeContext];
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    TTTBoard *board = [[TTTBoard alloc] initWithBoardSize:TTTBoardSizeMake(3, 3)];
    
    self.dataSource = [[TTTGameBoardDataSource alloc] initWithGameBoard:board];
    self.collectionView.dataSource = self.dataSource;
    
    self.game = [[TTTGame alloc] initWithBoard:board];
    self.game.delegate = self;
    
    self.computerPlayer = [TTTComputerPlayer new];
    self.humanPlayer = [TTTHumanPlayer new];
    
    [self.computerPlayer addObserver:self
                          forKeyPath:@"decision"
                             options:NSKeyValueObservingOptionNew
                             context:TTTComputerPlayerDecisionContext];
    [self.computerPlayer addObserver:self
                          forKeyPath:@"localizedStatusDescription"
                             options:NSKeyValueObservingOptionNew
                             context:TTTComputerPlayerStatusChangeContext];
    
    [self.collectionView reloadData];
}

#pragma mark - Actions
- (void)newGameButtonDidTap {
    [self showGameOptionsActionSheet];
}

#pragma mark - Collection view delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.game.currentPlayer == self.humanPlayer) {
        [self.humanPlayer makeDecisionWithIndexPath:indexPath];
        [self.game endTurnWithNextPlayer:self.computerPlayer];
    }
}

#pragma mark - Game delegate
- (void)game:(TTTGame *)game playerDidEndTurn:(TTTPlayer *)player {
    TTTBoardTile *tile = player.decision;
    
    if ([self.game.board canOccupyTileAtIndexPath:tile.indexPath]) {
        [self.game.board occupyTileWithValue:tile.value atIndexPath:tile.indexPath];
    }
    
    BOOL winner = player.isMaximizingPlayer;
    if ([game hasWinner:&winner]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (winner == self.computerPlayer.isMaximizingPlayer) {
                self.gameStatusLabel.text = @"Next time, partner!";
            } else {
                self.gameStatusLabel.text = @"Good job, partner!";
            }
            self.collectionView.userInteractionEnabled = NO;
        });
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

#pragma mark - Key-value observing
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == TTTComputerPlayerDecisionContext) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.gameStatusLabel.text = NSLocalizedString(@"Your turn!", nil);
        });
        [self.game endTurnWithNextPlayer:self.humanPlayer];
    } else if (context == TTTComputerPlayerStatusChangeContext) {
        NSString *text = change[NSKeyValueChangeNewKey];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.gameStatusLabel.text = text;
        });
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
@end