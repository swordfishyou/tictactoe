//
//  TTTBoardTileValue.m
//  
//
//  Created by Anatoly Tukhtarov on 8/4/15.
//
//

#import "TTTBoardTileValue.h"

@implementation TTTBoardTileValue
- (instancetype)initForMaximazingPlayerValue:(BOOL)maximizingPlayerValue {
    if (self = [super init]) {
        _maximizingPlayerValue = maximizingPlayerValue;
        _token = maximizingPlayerValue ? TTTBoardTileCrossToken : TTTBoardTileNilToken;
    }
    
    return self;
}

- (NSUInteger)hash {
    NSUInteger prime = 31;
    NSUInteger result = 1;
    
    result = prime * result + _maximizingPlayerValue;
    result = prime * result + _token;
    
    return result;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    TTTBoardTileValue *other = object;
    return ((_token == other->_token) && (_maximizingPlayerValue == other->_maximizingPlayerValue));
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone {
    return [[[self class] allocWithZone:zone] initForMaximazingPlayerValue:_maximizingPlayerValue];
}
@end
