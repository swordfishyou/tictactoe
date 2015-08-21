//
//  TTTAIPlayer.m
//  
//
//  Created by Anatoly Tukhtarov on 8/7/15.
//
//

#import "TTTComputerPlayer.h"
#import "TTTGameDecisionTree.h"
#import "TTTRowsWinningCondition.h"
#import "TTTColumnsWinningCondition.h"
#import "TTTDiagonalsWinningCondition.h"
#import "TTTBoard.h"

@implementation TTTComputerPlayer
- (void)startTurnOnBoard:(TTTBoard *)board {
    NSArray *conditions = @[[TTTRowsWinningCondition new], [TTTColumnsWinningCondition new], [TTTDiagonalsWinningCondition new]];
    BOOL winner = self.isMaximizingPlayer;
    if (![board hasWinnerWithConditions:conditions isMaximizerWinner:&winner]) {
        self.localizedStatusDescription = NSLocalizedString(@"Hmm, let me think...", nil);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            TTTGameDecisionTree *tree = [[TTTGameDecisionTree alloc] initWithBoard:board maximizingPlayerTree:self.isMaximizingPlayer];
            [tree generateTreeWithDepth:6];
            self.localizedStatusDescription = NSLocalizedString(@"Oh, this way!", nil);
            self.decision = [tree nextMove];
        });
    } else {
        if (winner == self.isMaximizingPlayer) {
            self.localizedStatusDescription = NSLocalizedString(@"Next time, partner!", nil);
        } else {
            self.localizedStatusDescription = NSLocalizedString(@"Good job, partner!", nil);
        }
    }
}
@end
