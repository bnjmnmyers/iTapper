//
//  TapOffViewController.h
//  TapCounter
//
//  Created by Benjamin Myers on 4/3/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface TapOffViewController : UIViewController <ADBannerViewDelegate>

// UI Properties
@property (strong, nonatomic) IBOutlet ADBannerView *bannerView;
@property (strong, nonatomic) IBOutlet UILabel *lblPlayer1Score;
@property (strong, nonatomic) IBOutlet UILabel *lblPlayer2Score;
@property (strong, nonatomic) IBOutlet UIButton *btnCloseResults;
@property (strong, nonatomic) IBOutlet UIButton *btnPlayer1Tap;
@property (strong, nonatomic) IBOutlet UIButton *btnPlayer2Tap;
@property (strong, nonatomic) IBOutlet UILabel *lblPlayer1Timer;
@property (strong, nonatomic) IBOutlet UILabel *lblPlayer2Timer;
@property (strong, nonatomic) IBOutlet UILabel *lblPlayer1Indicator;
@property (strong, nonatomic) IBOutlet UILabel *lblPlayer2Indicator;
@property (strong, nonatomic) IBOutlet UILabel *lblVictor;
@property (strong, nonatomic) IBOutlet UILabel *lblFinalScore;
@property (strong, nonatomic) IBOutlet UIButton *btnStartTimer;
@property (strong, nonatomic) IBOutlet UIButton *btnMenu;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIView *vwResults;
@property (strong, nonatomic) IBOutlet UIView *vwResultsCont;

// Variable Properties
@property (assign) int player1TapCount;
@property (assign) int player2TapCount;
@property (assign) NSUInteger clock;
@property (assign) BOOL isTimerStarted;
@property (assign) BOOL isTimerInvalidateSet;
@property (assign) UIFont *museoFont;
@property (strong, nonatomic) NSTimer *countdownTimer;

// Actions
- (IBAction)playerTap:(id)sender;
- (IBAction)startTimer:(id)sender;
- (IBAction)closeResults:(id)sender;
- (IBAction)gotoMenu:(id)sender;

@end
