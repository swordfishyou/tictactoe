//
//  TTTHumanPlayer.m
//  
//
//  Created by Anatoly Tukhtarov on 8/8/15.
//
//

@import UIKit.UICollectionView;
@import UIKit.UITableView;

#import "TTTHumanPlayer.h"
#import "TTTIndexPath.h"
#import "TTTBoardTile.h"
#import "TTTBoardTileValue.h"

@implementation TTTHumanPlayer
- (void)makeDecisionWithIndexPath:(NSIndexPath *)indexPath {
    TTTIndexPath *boardIndexPath = [TTTIndexPath indexPathWithRow:indexPath.section inColumn:indexPath.item];
    TTTBoardTile *tile = [[TTTBoardTile alloc] initWithBoard:nil atIndexPath:boardIndexPath];
    tile.value = [[TTTBoardTileValue alloc] initForMaximazingPlayerValue:self.isMaximizingPlayer];
    self.decision = tile;
}
@end
