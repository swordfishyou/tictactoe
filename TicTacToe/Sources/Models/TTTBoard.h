//
//  TTTBoard.h
//  
//
//  Created by Anatoly Tukhtarov on 8/4/15.
//
//

@import Foundation;

@class TTTBoardTile, TTTIndexPath, TTTBoardTileValue;

typedef struct {
    NSInteger rows;
    NSInteger columns;
} TTTBoardSize;

extern TTTBoardSize TTTBoardSizeMake(NSInteger rows, NSInteger columns);

extern NSString * const TTTBoardException;
extern NSString * const TTTBoardInvalidIndexPathExceptionReasonFormat;

@interface TTTBoard : NSObject <NSCopying>
/**
 *  The dictionary containing the tiles of the receiver. (read-only)
 */
@property (nonatomic, copy, readonly) NSDictionary *tilesByIndexPath;
/**
 *  The size of the receiver. (read-only)
 */
@property (nonatomic, assign, readonly) TTTBoardSize boardSize;

/**
 *  Initializes and returns a newly allocated board object with the specified size.
 *
 *  @param boardSize    the structure that descrubes board's number of rows and columns
 *
 *  @return new board object with given size
 */
- (instancetype)initWithBoardSize:(TTTBoardSize)boardSize;
/**
 *  The set of empty tiles on the board
 */
- (NSSet *)emptyTiles;
/**
 *  Returns tile object at given index path
 *
 *  @param indexPath    the index path object to look tile for. If index path's row or column value is out of board's size throws the TTTBoardException exception
 *
 *  @return the tile at given index path
 */
- (TTTBoardTile *)tileAtIndexPath:(TTTIndexPath *)indexPath;
/**
 *  Determines whether one can occupy a tile at given index path
 *
 *  @param indexPath    the index path object to look tile for. If index path's row or column value is out of board's size throws the TTTBoardException exception
 *
 * @return YES if tile at index path is empty, NO otherwise
 */
- (BOOL)canOccupyTileAtIndexPath:(TTTIndexPath *)indexPath;
/**
 *  Occupies a tile at given index path with given value
 *
 *  @param indexPath    the index path object to look tile for. If index path's row or column value is out of board's size throws the TTTBoardException exception
 *
 *  @param value        the value to assign to the empty tile
 */
- (void)occupyTileWithValue:(TTTBoardTileValue *)value atIndexPath:(TTTIndexPath *)indexPath;
/**
 *  Checks whether the receiver has a winner with given conditions
 *
 *  @param conditions   the array of TTTGameWinningCondition objects to check
 *  @param winner       a pointer to return Boolean value indicating whether maximizing player is the winner
 */
- (BOOL)hasWinnerWithConditions:(NSArray *)conditions isMaximizerWinner:(BOOL *)winner;
/**
 *  Invalidates the receiver's tiles and sets them empty
 */
- (void)invalidateBoard;
@end