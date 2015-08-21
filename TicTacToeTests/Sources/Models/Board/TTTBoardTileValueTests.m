//
//  TTTBoardTileValueTests.m
//  
//
//  Created by Anatoly Tukhtarov on 8/8/15.
//
//

@import XCTest;
#import "TTTBoardTileValue.h"

@interface TTTBoardTileValueTests : XCTestCase

@end

@implementation TTTBoardTileValueTests

- (void)testThatValueForMinizingPlayerHasNilToken {
    TTTBoardTileValue *sut = [[TTTBoardTileValue alloc] initForMaximazingPlayerValue:NO];
    XCTAssertFalse(sut.isMaximizingPlayerValue);
    XCTAssertEqual(sut.token, TTTBoardTileNilToken);
}

- (void)testThatValueForMinizingPlayerHasCrossToken {
    TTTBoardTileValue *sut = [[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES];
    XCTAssert(sut.isMaximizingPlayerValue);
    XCTAssertEqual(sut.token, TTTBoardTileCrossToken);
}

@end
