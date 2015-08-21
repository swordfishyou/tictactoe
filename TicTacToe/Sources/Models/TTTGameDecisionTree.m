//
//  TTTGameDecisionTree.m
//  
//
//  Created by Anatoly Tukhtarov on 8/5/15.
//
//

#import "TTTGameDecisionTree.h"
#import "TTTGameDecisionNode.h"
#import "TTTBoardTile.h"
#import "TTTBoardTileValue.h"
#import "TTTBoard.h"

@implementation TTTGameDecisionTree
- (instancetype)initWithBoard:(TTTBoard *)board maximizingPlayerTree:(BOOL)maximizingPlayerTree {
    if (self = [super init]) {
        _root = [[TTTGameDecisionNode alloc] init];
        _root.board = board;
        _root.maximizingPlayerNode = !maximizingPlayerTree;
    }
    
    return self;
}

- (void)generateTreeWithDepth:(NSInteger)depth {
    [self.root generateChildsWithDepth:depth];
}

- (TTTBoardTile *)nextMove {
    TTTGameDecisionNode *node = [self nextMoveForNode:self.root
                                                alpha:INT16_MIN
                                                 beta:INT16_MAX
                                   isMaximizingPlayer:!self.root.maximizingPlayerNode];
    while (node.parent.parent) {
        node = node.parent;
    }
    return node.decision;
}

- (TTTGameDecisionNode *)nextMoveForNode:(TTTGameDecisionNode *)node
                                   alpha:(NSInteger)alpha
                                    beta:(NSInteger)beta
                      isMaximizingPlayer:(BOOL)maximizing {
    
    if (node.childs == nil || [node score]) {
        return node;
    }
    
    TTTGameDecisionNode *prevResult = nil;
    
    if (maximizing) {
        NSInteger v = INT16_MIN;
        for (TTTGameDecisionNode *child in node.childs) {
            TTTGameDecisionNode *result = [self nextMoveForNode:child alpha:alpha beta:beta isMaximizingPlayer:NO];
            v = MAX([result score], v);
            if (alpha < v) {
                prevResult = result;
            }
            alpha = MAX(alpha, v);
            if (alpha >= beta) {
                break;
            }
        }
        return prevResult;
    } else {
        NSInteger v = INT16_MAX;
        for (TTTGameDecisionNode *child in node.childs) {
            TTTGameDecisionNode *result = [self nextMoveForNode:child alpha:alpha beta:beta isMaximizingPlayer:YES];
            v = MIN([result score], v);
            if (beta > v) {
                prevResult = result;
            }
            beta = MIN(beta, v);
            
            if (alpha >= beta) {
                break;
            }
        }
        return prevResult;
    }
    
    return nil;
}
@end
