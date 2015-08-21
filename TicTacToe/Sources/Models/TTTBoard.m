//
//  TTTBoard.m
//  
//
//  Created by Anatoly Tukhtarov on 8/4/15.
//
//

#import "TTTBoard.h"
#import "TTTBoardTile.h"
#import "TTTIndexPath.h"
#import "TTTBoardTileValue.h"
#import "TTTGameWinningCondition.h"

NSString * const TTTBoardException = @"Index path is beyond the board's size";
NSString * const TTTBoardInvalidIndexPathExceptionReasonFormat = @"Index path's row %li or (and) column %li is out of the border's size (%li, %li)";

TTTBoardSize TTTBoardSizeMake(NSInteger rows, NSInteger columns) {
    TTTBoardSize size;
    size.rows = rows;
    size.columns = columns;
    return size;
};

@implementation TTTBoard
@synthesize tilesByIndexPath = _tilesByIndexPath;

- (instancetype)initWithBoardSize:(TTTBoardSize)boardSize {
    if (self = [super init]) {
        _boardSize = boardSize;
    }
    
    return self;
}

- (void)invalidateBoard {
    _tilesByIndexPath = nil;
}

- (TTTBoardTile *)tileAtIndexPath:(TTTIndexPath *)indexPath {
    if (indexPath.row >= self.boardSize.rows || indexPath.column >= self.boardSize.columns) {
        NSString *reason = [NSString stringWithFormat:TTTBoardInvalidIndexPathExceptionReasonFormat,
                            (long)indexPath.row, (long)indexPath.column, (long)self.boardSize.rows, (long)self.boardSize.columns];
        NSException *exception = [NSException exceptionWithName:TTTBoardException
                                                         reason:reason
                                                       userInfo:nil];
        @throw exception;
    }
    return self.tilesByIndexPath[indexPath];
}

- (NSSet *)emptyTiles {
    NSMutableSet *tiles = [NSMutableSet set];
    [self.tilesByIndexPath enumerateKeysAndObjectsUsingBlock:^(id key, TTTBoardTile *tile, BOOL *stop) {
        if ([tile isEmpty]) {
            [tiles addObject:tile];
        }
    }];
    
    return [tiles copy];
}

- (BOOL)canOccupyTileAtIndexPath:(TTTIndexPath *)indexPath {
    TTTBoardTile *tile = [self tileAtIndexPath:indexPath];
    return [tile isEmpty];
}

- (void)occupyTileWithValue:(TTTBoardTileValue *)value atIndexPath:(TTTIndexPath *)indexPath {
    TTTBoardTile *tile = [self tileAtIndexPath:indexPath];
    tile.value = value;
}

- (NSDictionary *)tilesByIndexPath {
    if (_tilesByIndexPath) {
        return _tilesByIndexPath;
    }
    
    NSUInteger numberOfTiles = (self.boardSize.rows * self.boardSize.columns);
    NSMutableDictionary *map = [NSMutableDictionary dictionaryWithCapacity:numberOfTiles];
    for (NSUInteger column = 0; column < self.boardSize.columns; ++column) {
        for (NSUInteger row = 0; row < self.boardSize.rows; ++row) {
            TTTIndexPath *indexPath = [TTTIndexPath indexPathWithRow:row inColumn:column];
            TTTBoardTile *tile = [[TTTBoardTile alloc] initWithBoard:self atIndexPath:indexPath];
            map[indexPath] = tile;
        }
    }
    
    _tilesByIndexPath = [map copy];
    return _tilesByIndexPath;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithString:@"\n"];
    
    for (NSUInteger column = 0; column < self.boardSize.columns; ++column) {
        for (NSUInteger row = 0; row < self.boardSize.rows; ++row) {
            TTTIndexPath *indexPath = [TTTIndexPath indexPathWithRow:row inColumn:column];
            TTTBoardTile *tile = self.tilesByIndexPath[indexPath];
            NSString *token = @"_";
            if (![tile isEmpty]) {
                token = tile.value.token == TTTBoardTileCrossToken ? @"X" : @"O";
            }
            [description appendString:token];
        }
        [description appendString:@"\n"];
    }
    
    return [description copy];
}

- (BOOL)hasWinnerWithConditions:(NSArray *)conditions isMaximizerWinner:(BOOL *)winner {
    for (id<TTTGameWinningCondition> condition in conditions) {
        if ([condition hasWinnerOnBoard:self isMaximizerWinner:winner]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    typeof(self) copy = [[[self class] allocWithZone:zone] initWithBoardSize:_boardSize];
    NSMutableDictionary *tilesCopy = [NSMutableDictionary dictionaryWithCapacity:self.tilesByIndexPath.count];
    [self.tilesByIndexPath enumerateKeysAndObjectsUsingBlock:^(TTTIndexPath *key, TTTBoardTile *obj, BOOL *stop) {
        TTTBoardTile *tile = [[TTTBoardTile alloc] initWithBoard:copy atIndexPath:key];
        tile.value = [obj.value copy];
        tilesCopy[key] = tile;
    }];
    copy->_tilesByIndexPath = [tilesCopy copy];
    return copy;
}
@end
