//
//  ViewController.h
//  TicTacToe
//
//  Created by Anatoly Tukhtarov on 8/4/15.
//  Copyright (c) 2015 Anatoly Tukhtarov. All rights reserved.
//

@import UIKit;

@class TTTGame;

@interface TTTViewController : UIViewController
/**
 *  The collection view used by the receiver to display game status
 */
@property (nonatomic, weak, readonly) UICollectionView *collectionView;
/**
 *  The game object running by the receiver
 */
@property (nonatomic, strong, readonly) TTTGame *game;
@end

