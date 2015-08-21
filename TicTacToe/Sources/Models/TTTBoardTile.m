//
//  TTTBoardTile.m
//  
//
//  Created by Anatoly Tukhtarov on 8/4/15.
//
//

#import "TTTBoardTile.h"
#import "TTTIndexPath.h"

@implementation TTTBoardTile
- (instancetype)initWithBoard:(TTTBoard *)board atIndexPath:(TTTIndexPath *)indexPath {
    if (self = [super init]) {
        _board = board;
        _indexPath = [indexPath copy];
    }
    
    return self;
}

- (BOOL)isEmpty {
    return (self.value == nil);
}

@end
