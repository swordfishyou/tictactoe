//
//  TTTGameBoardDataSource.m
//  
//
//  Created by Anatoly Tukhtarov on 8/8/15.
//
//

#import "TTTGameBoardDataSource.h"
#import "TTTBoard.h"
#import "TTTBoardTile.h"
#import "TTTBoardTileValue.h"
#import "TTTIndexPath.h"

@implementation TTTGameBoardDataSource
- (instancetype)initWithGameBoard:(TTTBoard *)board {
    if (self = [super init]) {
        _board = board;
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.board.boardSize.rows;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.board.boardSize.columns;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])
                                                                           forIndexPath:indexPath];
    TTTIndexPath *boardIndexPath = [TTTIndexPath indexPathWithRow:indexPath.section inColumn:indexPath.item];
    TTTBoardTile *tile = [self.board tileAtIndexPath:boardIndexPath];
    cell.backgroundColor = [UIColor whiteColor];
    if (![tile isEmpty]) {
        cell.backgroundColor = tile.value.isMaximizingPlayerValue ? [UIColor redColor] : [UIColor greenColor];
    }
    return cell;
}
@end
