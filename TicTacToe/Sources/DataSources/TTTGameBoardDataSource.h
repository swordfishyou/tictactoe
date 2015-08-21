//
//  TTTGameBoardDataSource.h
//  
//
//  Created by Anatoly Tukhtarov on 8/8/15.
//
//

@import UIKit;

@class TTTBoard;

@interface TTTGameBoardDataSource : NSObject <UICollectionViewDataSource>
/**
 *  The board object currently used by the receiver. (read-only)
 */
@property (nonatomic, strong, readonly) TTTBoard *board;

/**
 *  Initializes and returns a newly allocated data source object with the specified board.
 *
 *  @param board    The board object to use for organizing items. The data source stores a strong reference to the specified object. Must not be nil.
 *
 *  @return new data source object with given board
 */
- (instancetype)initWithGameBoard:(TTTBoard *)board;
@end
