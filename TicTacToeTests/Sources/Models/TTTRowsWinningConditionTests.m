//
//  TTTRowsWinningConditionTests.m
//  
//
//  Created by Anatoly Tukhtarov on 8/8/15.
//
//

@import XCTest;
#import "TTTRowsWinningCondition.h"
#import "TTTBoard.h"
#import "TTTBoardTileValue.h"
#import "TTTIndexPath.h"

@interface TTTRowsWinningConditionTests : XCTestCase
@property (nonatomic, strong) TTTRowsWinningCondition *sut;
@end

@implementation TTTRowsWinningConditionTests

- (void)setUp {
    [super setUp];
    _sut = [TTTRowsWinningCondition new];
}

- (void)tearDown {
    _sut = nil;
    [super tearDown];
}

- (void)testThatReceiverCorrectlyCalculatesBoardWithoutRowWins {
    TTTBoard *board = [[TTTBoard alloc] initWithBoardSize:TTTBoardSizeMake(3, 3)];
    [board occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES]
                   atIndexPath:[TTTIndexPath indexPathWithRow:0 inColumn:0]];
    [board occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES]
                   atIndexPath:[TTTIndexPath indexPathWithRow:0 inColumn:1]];
    [board occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:NO]
                   atIndexPath:[TTTIndexPath indexPathWithRow:1 inColumn:0]];
    [board occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:NO]
                   atIndexPath:[TTTIndexPath indexPathWithRow:1 inColumn:1]];
    
    TTTBoard *boardWithColumnsWin = [[TTTBoard alloc] initWithBoardSize:TTTBoardSizeMake(3, 3)];
    [boardWithColumnsWin occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES]
                   atIndexPath:[TTTIndexPath indexPathWithRow:0 inColumn:0]];
    [boardWithColumnsWin occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES]
                   atIndexPath:[TTTIndexPath indexPathWithRow:1 inColumn:0]];
    [boardWithColumnsWin occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES]
                   atIndexPath:[TTTIndexPath indexPathWithRow:2 inColumn:0]];
    [boardWithColumnsWin occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:NO]
                   atIndexPath:[TTTIndexPath indexPathWithRow:1 inColumn:1]];
    [boardWithColumnsWin occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:NO]
                   atIndexPath:[TTTIndexPath indexPathWithRow:2 inColumn:2]];
    
    TTTBoard *boardWithDiagonalWin = [[TTTBoard alloc] initWithBoardSize:TTTBoardSizeMake(3, 3)];
    [boardWithDiagonalWin occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES]
                                 atIndexPath:[TTTIndexPath indexPathWithRow:0 inColumn:0]];
    [boardWithDiagonalWin occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES]
                                 atIndexPath:[TTTIndexPath indexPathWithRow:1 inColumn:1]];
    [boardWithDiagonalWin occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES]
                                 atIndexPath:[TTTIndexPath indexPathWithRow:2 inColumn:2]];
    [boardWithDiagonalWin occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:NO]
                                 atIndexPath:[TTTIndexPath indexPathWithRow:1 inColumn:2]];
    [boardWithDiagonalWin occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:NO]
                                 atIndexPath:[TTTIndexPath indexPathWithRow:2 inColumn:0]];
    
    XCTAssertFalse([self.sut hasWinnerOnBoard:board isMaximizerWinner:NULL]);
    XCTAssertFalse([self.sut hasWinnerOnBoard:boardWithColumnsWin isMaximizerWinner:NULL]);
    XCTAssertFalse([self.sut hasWinnerOnBoard:boardWithDiagonalWin isMaximizerWinner:NULL]);
}

- (void)testThatReceiverCorrectlyCalculatesBoardWithRowWins {
    TTTBoard *board = [[TTTBoard alloc] initWithBoardSize:TTTBoardSizeMake(3, 3)];
    [board occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES]
                   atIndexPath:[TTTIndexPath indexPathWithRow:0 inColumn:0]];
    [board occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES]
                   atIndexPath:[TTTIndexPath indexPathWithRow:0 inColumn:1]];
    [board occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES]
                   atIndexPath:[TTTIndexPath indexPathWithRow:0 inColumn:2]];
    [board occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:NO]
                   atIndexPath:[TTTIndexPath indexPathWithRow:1 inColumn:1]];
    [board occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:NO]
                   atIndexPath:[TTTIndexPath indexPathWithRow:2 inColumn:1]];
    
    TTTBoard *minimizingWinner = [[TTTBoard alloc] initWithBoardSize:TTTBoardSizeMake(3, 3)];
    [minimizingWinner occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:NO]
                                 atIndexPath:[TTTIndexPath indexPathWithRow:1 inColumn:0]];
    [minimizingWinner occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:NO]
                                 atIndexPath:[TTTIndexPath indexPathWithRow:1 inColumn:1]];
    [minimizingWinner occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:NO]
                                 atIndexPath:[TTTIndexPath indexPathWithRow:1 inColumn:2]];
    [minimizingWinner occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES]
                                 atIndexPath:[TTTIndexPath indexPathWithRow:0 inColumn:0]];
    [minimizingWinner occupyTileWithValue:[[TTTBoardTileValue alloc] initForMaximazingPlayerValue:YES]
                                 atIndexPath:[TTTIndexPath indexPathWithRow:2 inColumn:2]];

    XCTAssert([self.sut hasWinnerOnBoard:board isMaximizerWinner:NULL]);
    XCTAssert([self.sut hasWinnerOnBoard:minimizingWinner isMaximizerWinner:NULL]);
}

@end
