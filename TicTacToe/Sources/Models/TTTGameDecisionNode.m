//
//  TTTGameDecisionNode.m
//  
//
//  Created by Anatoly Tukhtarov on 8/5/15.
//
//

#import "TTTGameDecisionNode.h"
#import "TTTBoardTileValue.h"
#import "TTTBoardTile.h"
#import "TTTBoard.h"
#import "TTTRowsWinningCondition.h"
#import "TTTColumnsWinningCondition.h"
#import "TTTDiagonalsWinningCondition.h"

@implementation TTTGameDecisionNode
- (instancetype)initWithParent:(TTTGameDecisionNode *)parent {
    if (self = [super init]) {
        _parent = parent;
        _depth = parent.depth + 1;
        _maximizingPlayerNode = !parent.isMaximizingPlayerNode;
    }
    
    return self;
}

- (void)generateChildsWithDepth:(NSInteger)depth {
    NSSet *emptyTiles = [[self board] emptyTiles];
    if (emptyTiles.count && depth) {
        NSMutableSet *childs = [NSMutableSet setWithCapacity:emptyTiles.count];
        for (TTTBoardTile *tile in emptyTiles) {
            @autoreleasepool {
                TTTBoard *board = [[self board] copy];
                
                TTTGameDecisionNode *node = [[TTTGameDecisionNode alloc] initWithParent:self];
                
                TTTBoardTileValue *value = [[TTTBoardTileValue alloc] initForMaximazingPlayerValue:node.isMaximizingPlayerNode];
                [board occupyTileWithValue:value atIndexPath:tile.indexPath];
                node.board = board;
                node->_decision = [board tileAtIndexPath:tile.indexPath];
                
                [node generateChildsWithDepth:depth - 1];
                [childs addObject:node];
            }
        }
        
        _childs = [childs copy];
    }
}

- (NSInteger)score {
    NSArray *conditions = @[[TTTRowsWinningCondition new], [TTTColumnsWinningCondition new], [TTTDiagonalsWinningCondition new]];
    BOOL winner = self.isMaximizingPlayerNode;
    if ([self.board hasWinnerWithConditions:conditions isMaximizerWinner:&winner]) {
        return winner ? (10 - self.depth) : (self.depth - 10);
    }
    
    return 0;
}
@end
