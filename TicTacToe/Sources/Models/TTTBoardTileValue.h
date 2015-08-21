//
//  TTTBoardTileValue.h
//  
//
//  Created by Anatoly Tukhtarov on 8/4/15.
//
//

@import Foundation;

typedef NS_ENUM(NSInteger, TTTBoardTileToken) {
    TTTBoardTileCrossToken = 0,
    TTTBoardTileNilToken
};

@interface TTTBoardTileValue : NSObject <NSCopying>
/**
 *  Boolean value indicating wheter value is describing maximizing player move
 */
@property (nonatomic, assign, getter=isMaximizingPlayerValue) BOOL maximizingPlayerValue;
/**
 *  A symbol used to represent value. (read-only)
 */
@property (nonatomic, assign, readonly) TTTBoardTileToken token;

/**
 *  Initializes and returns a newly allocated tile value object for given player.
 *
 *  @param maximizingPlayerValue    the player to initialize value for.
 *
 *  @return new board tile value object with given player
 */
- (instancetype)initForMaximazingPlayerValue:(BOOL)maximizingPlayerValue;
@end
