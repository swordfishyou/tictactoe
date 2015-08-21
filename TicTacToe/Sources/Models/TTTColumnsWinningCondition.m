//
//  TTTColumnsWinningCondition.m
//  
//
//  Created by Anatoly Tukhtarov on 8/6/15.
//
//

#import "TTTColumnsWinningCondition.h"
#import "TTTBoard.h"
#import "TTTIndexPath.h"
#import "TTTBoardTile.h"
#import "TTTBoardTileValue.h"

@implementation TTTColumnsWinningCondition
- (BOOL)hasWinnerOnBoard:(TTTBoard *)board isMaximizerWinner:(BOOL *)winner {
    __block BOOL result = YES;
    
    NSArray *indexPaths = [[board tilesByIndexPath] allKeys];
    NSArray *sortedIndexPaths = [indexPaths sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"column" ascending:YES]]];
    
    __block TTTBoardTileValue *previousValue = nil;
    for (NSInteger idx = 0; idx < sortedIndexPaths.count; ++idx) {
        if (idx != 0 && result && idx % board.boardSize.columns == 0) {
            return YES;
        }
        
        TTTIndexPath *obj = sortedIndexPaths[idx];
        TTTBoardTile *tile = [board tileAtIndexPath:obj];
        
        if ([tile isEmpty]) {
            result = NO;
            previousValue = tile.value;
            continue;
        }
        
        if (idx % board.boardSize.columns == 0) {
            result = YES;
            previousValue = tile.value;
            continue;
        }
        
        result &= [previousValue isEqual:tile.value];
        previousValue = tile.value;
    }
    
    if (result && winner) {
        *winner = previousValue.isMaximizingPlayerValue;
    }
    
    return result;
}
@end
