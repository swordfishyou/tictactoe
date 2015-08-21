//
//  TTTIndexPath.h
//  
//
//  Created by Anatoly Tukhtarov on 8/4/15.
//
//

@import Foundation;

@interface TTTIndexPath : NSIndexPath
@property (nonatomic, assign, readonly) NSInteger row;
@property (nonatomic, assign, readonly) NSInteger column;

+ (instancetype)indexPathWithRow:(NSInteger)row inColumn:(NSInteger)column;
- (instancetype)initWithRow:(NSInteger)row inColumn:(NSInteger)column;
@end
