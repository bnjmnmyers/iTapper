//
//  ViewController.h
//  TapCounter
//
//  Created by Benjamin Myers on 4/1/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface FastTapperViewController : UIViewController <ADBannerViewDelegate>

// CoreData Properties
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchRequest *fetchRequest;
@property (strong, nonatomic) NSEntityDescription *entity;
@property (strong, nonatomic) NSMutableArray *sort;
@property (strong, nonatomic) NSArray *sortDescriptors;
@property (strong, nonatomic) NSPredicate *predicate;
@property (strong, nonatomic) NSArray *scoresArray;

// UI Properties
@property (strong, nonatomic) IBOutlet UIButton *btnStart;
@property (strong, nonatomic) IBOutlet UIButton *btnTap;
@property (strong, nonatomic) IBOutlet UIButton *btnMenu;
@property (strong, nonatomic) IBOutlet UIButton *btnSave;
@property (strong, nonatomic) IBOutlet UIButton *btnClose;
@property (strong, nonatomic) IBOutlet UIButton *btnCloseGameMode;
@property (strong, nonatomic) IBOutlet ADBannerView *bannerView;

@property (strong, nonatomic) IBOutlet UILabel *lblCounter;
@property (strong, nonatomic) IBOutlet UILabel *lblCounterTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblHighScore;
@property (strong, nonatomic) IBOutlet UILabel *lblHighScoreTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblScore;
@property (strong, nonatomic) IBOutlet UILabel *lblTimerTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblTimer;
@property (strong, nonatomic) IBOutlet UILabel *lblTapsPerSecond;
@property (strong, nonatomic) IBOutlet UILabel *lblViewControllerTitle;
@property (strong, nonatomic) IBOutlet UITextField *tfUsername;
@property (strong, nonatomic) IBOutlet UIView *vwScore;
@property (strong, nonatomic) IBOutlet UIView *vwSettings;

// Variable Properties
@property (assign) int clock;
@property (assign) int gameLength;
@property (assign) int tapCount;
@property (assign) float tapsPerSecond;
@property (assign) BOOL isTimerStarted;
@property (assign) BOOL isTimerInvalidateSet;
@property (strong, nonatomic) NSString *gameType;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSTimer *countdownTimer;

// Actions
- (IBAction)startTimer:(id)sender;
- (IBAction)saveScore:(id)sender;
- (IBAction)playerTap:(id)sender;
- (IBAction)changeGameType:(id)sender;
- (IBAction)toggleSettingsView:(id)sender;
- (IBAction)gotoMenu:(id)sender;
- (IBAction)closeResultsView:(id)sender;
- (IBAction)hideKeyboard:(id)sender;



@end
