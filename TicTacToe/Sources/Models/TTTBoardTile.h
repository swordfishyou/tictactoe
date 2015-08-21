//
//  TTTBoardTile.h
//  
//
//  Created by Anatoly Tukhtarov on 8/4/15.
//
//

@import Foundation;

@class TTTBoard, TTTBoardTileValue, TTTIndexPath;

@interface TTTBoardTile : NSObject
/**
 *  The tile value assigned to the receiver
 */
@property (nonatomic, copy) TTTBoardTileValue *value;
/**
 *  The board object where the receiver is placed. (read-only)
 */
@property (nonatomic, weak, readonly) TTTBoard *board;
/**
 *  The index path of the receiver on the board. (read-only)
 */
@property (nonatomic, copy, readonly) TTTIndexPath *indexPath;

/**
 *  Initializes and returns a newly allocated board tile object on the specified board with given index path.
 *
 *  @param board        The board object for tile. The tile stores a weak reference to the specified object. Must not be nil.
 *  @param indexPath    The index path of the tile on the board. The tile copies the specified object. Must not be nil.
 *
 *  @return new board tile object with given board at given index path
 */
- (instancetype)initWithBoard:(TTTBoard *)board atIndexPath:(TTTIndexPath *)indexPath;
/**
 *  @result YES if the tile has a value, NO otherwise
 */
- (BOOL)isEmpty;
@end
