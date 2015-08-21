//
//  TTTBoardTileTests.m
//  
//
//  Created by Anatoly Tukhtarov on 8/8/15.
//
//

@import XCTest;
#import "TTTBoardTile.h"
#import "TTTBoard.h"
#import "TTTBoardTileValue.h"
#import "TTTIndexPath.h"

@interface TTTBoardTileTests : XCTestCase
@property (nonatomic, strong) TTTBoardTile *sut;
@property (nonatomic, strong) TTTBoard *board;
@end

@implementation TTTBoardTileTests

- (void)setUp {
    [super setUp];
    _board = [[TTTBoard alloc] initWithBoardSize:TTTBoardSizeMake(3, 3)];
    TTTIndexPath *ip = [TTTIndexPath indexPathWithRow:0 inColumn:0];
    _sut = [[TTTBoardTile alloc] initWithBoard:_board atIndexPath:ip];
}

- (void)tearDown {
    _sut = nil;
    _board = nil;
    [super tearDown];
}

- (void)testThatReceiverIsCorrectlyInitialized {
    XCTAssertNotNil(self.sut.board);
    XCTAssertNotNil(self.sut.indexPath);
}

- (void)testThatReceiverIsEmptyByDefault {
    XCTAssert([self.sut isEmpty]);
}

- (void)testThatReceiverWithValueIsNotEmpty {
    TTTBoardTileValue *value = [[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES];
    self.sut.value = value;
    XCTAssertEqualObjects(value, self.sut.value);
    XCTAssertFalse([self.sut isEmpty]);
}
@end
