//
//  TTTGameWinningCondition.h
//  
//
//  Created by Anatoly Tukhtarov on 8/6/15.
//
//

@import Foundation;

@class TTTBoard;

@protocol TTTGameWinningCondition <NSObject>
@required
/**
 *  Returns a Boolean value that indicates whether a given board satisfies the condition
 *
 *  @param board    the board for which to test the receiver
 *  @param winner   a pointer to Boolean value that indicates whether the winner is maximizing player or not
 *
 *  @return YES if board has winning configuration described by the receiver, NO otherwise
 */
- (BOOL)hasWinnerOnBoard:(TTTBoard *)board isMaximizerWinner:(BOOL *)winner;
@end
