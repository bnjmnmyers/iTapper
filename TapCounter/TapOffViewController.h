//
//  TapOffViewController.h
//  TapCounter
//
//  Created by Benjamin Myers on 4/3/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TapOffViewController : UIViewController

// UI Properties
@property (strong, nonatomic) IBOutlet UILabel *lblPlayer1Score;
@property (strong, nonatomic) IBOutlet UILabel *lblPlayer2Score;
@property (strong, nonatomic) IBOutlet UIButton *btnPlayer1Tap;
@property (strong, nonatomic) IBOutlet UIButton *btnPlayer2Tap;
@property (strong, nonatomic) IBOutlet UILabel *lblPlayer1Timer;
@property (strong, nonatomic) IBOutlet UILabel *lblPlayer2Timer;
@property (strong, nonatomic) IBOutlet UIButton *btnStartTimer;
@property (strong, nonatomic) IBOutlet UIButton *btnMenu;

// Variable Properties
@property (assign) int player1TapCount;
@property (assign) int player2TapCount;
@property (assign) int clock;
@property (assign) BOOL isTimerStarted;
@property (assign) UIFont *museoFont;

// Actions
- (IBAction)playerTap:(id)sender;
- (IBAction)startTimer:(id)sender;

@end
