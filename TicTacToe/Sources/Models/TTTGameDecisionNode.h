//
//  TTTGameDecisionNode.h
//  
//
//  Created by Anatoly Tukhtarov on 8/5/15.
//
//

@import Foundation;

@class TTTBoard, TTTBoardTile;

@interface TTTGameDecisionNode : NSObject
/**
 *  The parent node of the receiver. (read-only)
 */
@property (nonatomic, weak, readonly) TTTGameDecisionNode *parent;
/**
 *  The set of child nodes. If nil, the receiver is leaf of a node. (read-only)
 */
@property (nonatomic, copy, readonly) NSSet *childs;
/**
 *  The depth level of the receiver. If 0 the receiver pretends to be the root. (read-only)
 */
@property (nonatomic, assign, readonly) NSInteger depth;
/**
 *  Boolean value indicating whether the receiver describes maximazing player move
 */
@property (nonatomic, assign, getter=isMaximizingPlayerNode) BOOL maximizingPlayerNode;
/**
 *  The board object currently used by the receiver. The receiver copies value on set. Must not be nil.
 */
@property (nonatomic, copy) TTTBoard *board;
/**
 *  The board's tile chosen as a decision by the receiver. (read-only)
 */
@property (nonatomic, copy, readonly) TTTBoardTile *decision;

/**
 *  Initializes and returns a newly allocated node object with the specified parent.
 *
 *  @param board    The node object to use for calculating receiver's attributes. The node stores a weak reference to the specified object
 *
 *  @return new node object with given parent
 */
- (instancetype)initWithParent:(TTTGameDecisionNode *)parent;
/**
 *  Generates the decisions tree of given depth for the receiver
 *
 *  @param depth    the number of generations to look ahead
 */
- (void)generateChildsWithDepth:(NSInteger)depth;
/**
 *  The score of the game at given depth and calculated decision. This value is greater than 0 for maximizing player, equals to zero if game is a draw, less than 0 for minimizing player
 */
- (NSInteger)score;
@end
