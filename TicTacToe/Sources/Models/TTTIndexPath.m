//
//  TTTIndexPath.m
//  
//
//  Created by Anatoly Tukhtarov on 8/4/15.
//
//

#import "TTTIndexPath.h"

@implementation TTTIndexPath
+ (instancetype)indexPathWithRow:(NSInteger)row inColumn:(NSInteger)column {
    return [[TTTIndexPath alloc] initWithRow:row inColumn:column];
}

- (instancetype)initWithRow:(NSInteger)row inColumn:(NSInteger)column {
    if (self = [super init]) {
        _row = row;
        _column = column;
    }
    
    return self;
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    return [[[self class] alloc] initWithRow:_row inColumn:_column];
}

#pragma mark - Hashing
- (NSUInteger)hash {
    NSUInteger prime = 31;
    NSUInteger result = 1;
    
    result = prime * result + _column;
    result = prime * result + _row;
    
    return result;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    TTTIndexPath *other = object;
    return ((_column == other->_column) && (_row == other->_row));
}

@end
