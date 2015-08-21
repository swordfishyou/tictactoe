//
//  TTTViewController_Internal.h
//  
//
//  Created by Anatoly Tukhtarov on 8/8/15.
//
//

#import "TTTViewController.h"
#import "TTTBoard.h"
#import "TTTGame.h"
#import "TTTBoardTile.h"
#import "TTTHumanPlayer.h"
#import "TTTComputerPlayer.h"
#import "TTTGameBoardDataSource.h"

static void * TTTComputerPlayerDecisionContext = &TTTComputerPlayerDecisionContext;
static void * TTTComputerPlayerStatusChangeContext = &TTTComputerPlayerStatusChangeContext;

@interface TTTViewController () <UICollectionViewDelegate, TTTGameDelegate>
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UILabel *gameStatusLabel;
@property (nonatomic, strong) TTTGameBoardDataSource *dataSource;
@property (nonatomic, strong) TTTGame *game;
@property (nonatomic, strong) TTTComputerPlayer *computerPlayer;
@property (nonatomic, strong) TTTHumanPlayer *humanPlayer;

- (IBAction)newGameButtonDidTap;
@end