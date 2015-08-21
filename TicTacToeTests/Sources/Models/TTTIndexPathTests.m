//
//  TTTIndexPathTests.m
//  
//
//  Created by Anatoly Tukhtarov on 8/8/15.
//
//

@import XCTest;
#import "TTTIndexPath.h"

@interface TTTIndexPathTests : XCTestCase
@property (nonatomic, strong) TTTIndexPath *sut;
@end

@implementation TTTIndexPathTests

- (void)setUp {
    [super setUp];
    _sut = [TTTIndexPath indexPathWithRow:0 inColumn:1];
}

- (void)tearDown {
    _sut = nil;
    [super tearDown];
}

- (void)testThatInitializationAssignsRowAndColumn {
    XCTAssertEqual(_sut.row, 0);
    XCTAssertEqual(_sut.column, 1);
}

- (void)testThatReceiversCopyIsEqualToReceiver {
    TTTIndexPath *copy = [self.sut copy];
    XCTAssertEqualObjects(copy, self.sut);
}

@end
