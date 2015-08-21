//
//  TTTPlayer.h
//  
//
//  Created by Anatoly Tukhtarov on 8/7/15.
//
//

@import Foundation;

@class TTTBoardTile, TTTBoard;

@interface TTTPlayer : NSObject
/**
 *  Boolean value indicating whether the receiver is maximizing player. Maximizing player goes first
 */
@property (nonatomic, assign, getter=isMaximizingPlayer) BOOL maximizingPlayer;
/**
 *  The board tile object calculated to be player's game decision
 */
@property (nonatomic, strong) TTTBoardTile *decision;
/**
 *  Localized description of the player's status
 */
@property (nonatomic, copy) NSString *localizedStatusDescription;

/**
 *  Begins a player's turn calculation on the given board object
 *
 *  @param board    The board object to make a decision
 */
- (void)startTurnOnBoard:(TTTBoard *)board;
@end
