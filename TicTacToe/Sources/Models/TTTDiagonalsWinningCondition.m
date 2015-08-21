//
//  TTTDiagonalsWinningCondition.m
//  
//
//  Created by Anatoly Tukhtarov on 8/6/15.
//
//

#import "TTTDiagonalsWinningCondition.h"
#import "TTTBoard.h"
#import "TTTIndexPath.h"
#import "TTTBoardTile.h"
#import "TTTBoardTileValue.h"

@implementation TTTDiagonalsWinningCondition
- (BOOL)hasWinnerOnBoard:(TTTBoard *)board isMaximizerWinner:(BOOL *)winner {
    __block BOOL result = YES;
    
    NSArray *indexPaths = [[board tilesByIndexPath] allKeys];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %K", @"row", @"column"];
    NSArray *mainDiagonalIndexPaths = [indexPaths filteredArrayUsingPredicate:predicate];
    
    __block TTTBoardTileValue *previousValue = nil;
    for (NSInteger idx = 0; idx < mainDiagonalIndexPaths.count; ++idx) {
        TTTIndexPath *obj = mainDiagonalIndexPaths[idx];
        TTTBoardTile *tile = [board tileAtIndexPath:obj];
        
        if ([tile isEmpty]) {
            result = NO;
            break;
        }
        
        if (idx == 0) {
            previousValue = tile.value;
            continue;
        }
        
        result &= [previousValue isEqual:tile.value];
        previousValue = tile.value;
    }
    
    if (result) {
        if (winner) {
            *winner = previousValue.isMaximizingPlayerValue;
        }
        return result;
    }
    
    predicate = [NSPredicate predicateWithFormat:@"(%K + %K) == %i", @"row", @"column", board.boardSize.columns - 1];
    NSArray *secondaryDiagonalIndexPaths = [indexPaths filteredArrayUsingPredicate:predicate];
    for (NSInteger idx = 0; idx < secondaryDiagonalIndexPaths.count; ++idx) {
        TTTIndexPath *obj = secondaryDiagonalIndexPaths[idx];
        TTTBoardTile *tile = [board tileAtIndexPath:obj];
        
        if ([tile isEmpty]) {
            result = NO;
            break;
        }
        
        if (idx == 0) {
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
