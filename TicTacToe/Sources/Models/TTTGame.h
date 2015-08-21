//
//  TTTGame.h
//  
//
//  Created by Anatoly Tukhtarov on 8/7/15.
//
//

@import Foundation;

@class TTTBoard, TTTPlayer;

@protocol TTTGameDelegate;

@interface TTTGame : NSObject
/**
 *  The board object currently used by the receiver. (read-only)
 */
@property (nonatomic, strong, readonly) TTTBoard *board;
/**
 *  The array of players participating in the game
 */
@property (nonatomic, copy, readonly) NSArray *players;
/**
 *  The player whose turn is to act next
 */
@property (nonatomic, strong, readonly) TTTPlayer *currentPlayer;
/**
 *  The object that acts like game's delegate
 */
@property (nonatomic, weak) id<TTTGameDelegate> delegate;

/**
 *  Initializes and returns a newly allocated game object with the specified board.
 *
 *  @param board    The board object to use for tracking progress. The game stores a strong reference to the specified object. Must not be nil.
 *
 *  @return new request object with given since date in parameters
 */
- (instancetype)initWithBoard:(TTTBoard *)board;
/**
 *  Adds the given player to the players array. If player is the first one it is marked as maximizng.
 *
 *  @param player    the player who's about to participate in the game. Must not be nil.
 */
- (void)acceptInviteFromPlayer:(TTTPlayer *)player;
/**
 *  Ends turn for current player and notifies delegate; starts turn for the given player.
 *
 *  @param player    the player who's turn is about to start. Must not be nil.
 */
- (void)endTurnWithNextPlayer:(TTTPlayer *)player;
/**
 *  Ends game, releases the players and invalidates the board
 */
- (void)endGame;
/**
 *  Returns a Boolean value that indicates whether a given game has a winner
 *
 *  @param winner   a pointer to Boolean value that indicates whether the winner is maximizing player or not
 *
 *  @return YES if board has some winning configuration, NO otherwise
 */
- (BOOL)hasWinner:(BOOL *)winner;
@end

@protocol TTTGameDelegate <NSObject>
@optional
/**
 *  Tells the delegate that specified player did end turn in game
 *
 *  @param game    the game object informing the delegate about turn end
 *  @param player  the player whose turn has just ended
 */
- (void)game:(TTTGame *)game playerDidEndTurn:(TTTPlayer *)player;
@end