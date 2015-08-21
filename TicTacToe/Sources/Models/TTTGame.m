//
//  TTTGame.m
//  
//
//  Created by Anatoly Tukhtarov on 8/7/15.
//
//

#import "TTTGame.h"
#import "TTTBoard.h"
#import "TTTPlayer.h"
#import "TTTRowsWinningCondition.h"
#import "TTTColumnsWinningCondition.h"
#import "TTTDiagonalsWinningCondition.h"

@implementation TTTGame
- (instancetype)initWithBoard:(TTTBoard *)board {
    if (self = [super init]) {
        _board = board;
        _players = [NSArray array];
    }
    
    return self;
}

- (void)acceptInviteFromPlayer:(TTTPlayer *)player {
    player.maximizingPlayer = NO;
    
    if (self.players.count == 0) {
        _currentPlayer = player;
        player.maximizingPlayer = YES;
        [player startTurnOnBoard:self.board];
    }
    
    NSMutableArray *players = [self.players mutableCopy];
    [players addObject:player];
    _players = [players copy];
}

- (void)endTurnWithNextPlayer:(TTTPlayer *)player {
    if ([self.delegate respondsToSelector:@selector(game:playerDidEndTurn:)]) {
        [self.delegate game:self playerDidEndTurn:self.currentPlayer];
    }
    _currentPlayer = player;
    [player startTurnOnBoard:self.board];
}

- (BOOL)hasWinner:(BOOL *)winner {
    NSArray *conditions = @[[TTTRowsWinningCondition new], [TTTColumnsWinningCondition new], [TTTDiagonalsWinningCondition new]];
    return [self.board hasWinnerWithConditions:conditions isMaximizerWinner:winner];
}

- (void)endGame {
    _players = [NSArray array];
    [self.board invalidateBoard];
}
@end
