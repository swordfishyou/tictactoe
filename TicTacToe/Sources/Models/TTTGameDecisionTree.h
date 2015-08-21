//
//  TTTGameDecisionTree.h
//  
//
//  Created by Anatoly Tukhtarov on 8/5/15.
//
//

@import Foundation;

@class TTTGameDecisionNode, TTTBoard, TTTBoardTile;

@interface TTTGameDecisionTree : NSObject
/**
 *  The root node of a tree. (read-only)
 */
@property (nonatomic, copy, readonly) TTTGameDecisionNode *root;
/**
 *  Boolean value indicating whether the tree is build for maximizing player. (read-only)
 */
@property (nonatomic, assign, readonly) BOOL isMaximizingPlayerTree;

/**
 *  Initializes and returns a newly allocated tree object for a player with the specified board.
 *
 *  @param board                The board object to use for calculating moves. The tree copies the specified object. Must not be nil.
 *  @param maximizingPlayerTree Boolean value indicating to build a tree for maximizing player or not
 *
 *  @return new tree object with given board
 */
- (instancetype)initWithBoard:(TTTBoard *)board maximizingPlayerTree:(BOOL)maximizingPlayerTree;
/**
 *  Generates moves for a given number of turns ahead
 *
 *  @param depth    the number of turns to look ahead
 */
- (void)generateTreeWithDepth:(NSInteger)depth;
/**
 *  Calculates and returns the optimal move on the receiver's board
 *
 *  @return the board tile object thar is optimal for the tree's board
 */
- (TTTBoardTile *)nextMove;
@end
