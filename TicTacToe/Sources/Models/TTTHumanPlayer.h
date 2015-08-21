//
//  TTTHumanPlayer.h
//  
//
//  Created by Anatoly Tukhtarov on 8/8/15.
//
//

#import "TTTPlayer.h"

@interface TTTHumanPlayer : TTTPlayer
/**
 *  Makes the receiver's decision with given index path object
 *
 *  @param indexPath    The collection view's index path used to map into board index path. Must not be nil.
 */
- (void)makeDecisionWithIndexPath:(NSIndexPath *)indexPath;
@end
