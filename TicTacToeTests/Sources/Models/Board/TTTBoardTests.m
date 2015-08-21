//
//  TTTBoardTests.m
//  
//
//  Created by Anatoly Tukhtarov on 8/8/15.
//
//

@import XCTest;
#import "TTTBoard.h"
#import "TTTIndexPath.h"
#import "TTTBoardTileValue.h"

@interface TTTBoardTests : XCTestCase
@property (nonatomic, strong) TTTBoard *sut;
@end

@implementation TTTBoardTests

- (void)setUp {
    [super setUp];
    _sut = [[TTTBoard alloc] initWithBoardSize:TTTBoardSizeMake(3, 3)];
}

- (void)tearDown {
    _sut = nil;
    [super tearDown];
}

- (void)testThatNewlyInitialiedBoardTilesAreEmpty {
    XCTAssertEqual(self.sut.emptyTiles.count, self.sut.tilesByIndexPath.count);
}

- (void)testThatOneCanOccupyEmptyTileOnBoard {
    XCTAssert([self.sut canOccupyTileAtIndexPath:[TTTIndexPath indexPathWithRow:0 inColumn:0]]);
}

- (void)testThatOneCantOccupyTileWithValueOnBoard {
    TTTIndexPath *ip = [TTTIndexPath indexPathWithRow:0 inColumn:0];
    [self.sut occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES] atIndexPath:ip];
    XCTAssertFalse([self.sut canOccupyTileAtIndexPath:ip]);
}

- (void)testThatEmptyTilesCalculationIsCorrect {
    TTTIndexPath *ip = [TTTIndexPath indexPathWithRow:0 inColumn:0];
    [self.sut occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES] atIndexPath:ip];
    
    ip = [TTTIndexPath indexPathWithRow:0 inColumn:1];
    [self.sut occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES] atIndexPath:ip];
    
    XCTAssertEqual(self.sut.emptyTiles.count, self.sut.tilesByIndexPath.count - 2);
}

- (void)testThatInvalidateBoardClearsTiles {
    TTTIndexPath *ip = [TTTIndexPath indexPathWithRow:0 inColumn:0];
    [self.sut occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES] atIndexPath:ip];
    
    ip = [TTTIndexPath indexPathWithRow:0 inColumn:1];
    [self.sut occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES] atIndexPath:ip];
    
    NSInteger numberOfEmptyTilesBefore = self.sut.emptyTiles.count;
    [self.sut invalidateBoard];
    XCTAssertNotEqual(numberOfEmptyTilesBefore, self.sut.emptyTiles.count);
}
@end
