//
//  ViewController.m
//  TapCounter
//
//  Created by Benjamin Myers on 4/1/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import "FastTapperViewController.h"
#import "Score.h"
#import "CurrentUserModel.h"
#import <AVFoundation/AVFoundation.h>

@interface FastTapperViewController ()

@property (strong, nonatomic) Score *scoreInstance;
@property (strong, nonatomic) CurrentUserModel *currentUserModelInstance;

@end

@implementation FastTapperViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	id delegate = [[UIApplication sharedApplication] delegate];
	self.managedObjectContext = [delegate managedObjectContext];
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenHeight = screenSize.height;
    
    // If user's device is a 3.5" device adjust size and position of UI elements
    if (screenHeight < 568) {
        _btnTap.frame = CGRectMake(60, 236, 200, 200);
        _btnStart.frame = CGRectMake(52, 280, 213, 109);
        _lblHighScoreTitle.frame = CGRectMake(20, 440, 113, 21);
        _lblHighScore.frame = CGRectMake(133, 440, 52, 21);
        _vwGameModeCont.frame = CGRectMake(20, 155, 280, 170);
        _vwResultsCont.frame = CGRectMake(20, 155, 280, 170);
        _bannerView.frame = CGRectMake(0, 430, 320, 50);
    }
    
    
	_scoreInstance = [[Score alloc]init];
    _currentUserModelInstance = [[CurrentUserModel alloc]init];
	_tapCount = 0;
	_clock = 10;
    _gameLength = 10;
    _gameType = @"Sprint";
	_lblHighScore.text = [_scoreInstance getHighScoreWithGameType:_gameType];
    [self setFonts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
	return YES;
}

- (IBAction)playerTap:(id)sender
{
	if (_isTimerStarted) {
		_tapCount++;
		_lblCounter.text = [NSString stringWithFormat:@"%d", _tapCount];
	}
}

- (IBAction)changeGameType:(id)sender
{
    // Game mode buttons have a tag assigned to them that is equivalent to the amount of time for the game
    // Set the clock and game length equal to the tag associated with the game mode button.
    _clock = [sender tag];
    _gameLength = [sender tag];
    _lblTimer.text = [NSString stringWithFormat:@"%ld", (long)[sender tag]];
    
    // Set flag to reset clock if a new game mode is chosen.
    _isTimerInvalidateSet = true;
    
    // Start the countdown
    [self countdown:_countdownTimer];
    
    _isTimerInvalidateSet = false;
    
    // Hide the start button and show the tap button
    _btnStart.hidden = NO;
    _btnTap.hidden = YES;
    
    // Pass in the game mode and send to Scores Model to get the high score for the current gameType
    // Set the high score accordingly
    switch ([sender tag]) {
        case 10:
            _gameType = @"Sprint";
            _lblHighScore.text = [_scoreInstance getHighScoreWithGameType:_gameType];
            break;
        case 30:
            _gameType = @"Half-Marathon";
            _lblHighScore.text = [_scoreInstance getHighScoreWithGameType:_gameType];
            break;
        case 60:
            _gameType = @"Marathon";
            _lblHighScore.text = [_scoreInstance getHighScoreWithGameType:_gameType];
            break;
            
        default:
            break;
    }
}

- (IBAction)toggleSettingsView:(id)sender
{
    if ([sender tag] == 100) {
        _vwSettings.hidden = NO;
    } else {
        _vwSettings.hidden = YES;
    }
}

- (void)setFonts
{
    _lblCounterTitle.font = [UIFont fontWithName:@"Museo-300" size:20];
    _lblHighScoreTitle.font = [UIFont fontWithName:@"Museo-300" size:20];
    _lblViewControllerTitle.font = [UIFont fontWithName:@"Museo-700" size:20];
    _lblCounter.font = [UIFont fontWithName:@"Museo-700" size:20];
    _lblHighScore.font = [UIFont fontWithName:@"Museo-700" size:20];
    _lblTimerTitle.font = [UIFont fontWithName:@"Museo-700" size:24];
    _lblTapsPerSecond.font = [UIFont fontWithName:@"Museo-500" size:20];
    _lblScore.font = [UIFont fontWithName:@"Museo-700" size:40];
    _lblTimer.font = [UIFont fontWithName:@"Museo-700" size:100];
    
    _btnClose.titleLabel.font = [UIFont fontWithName:@"Museo-500" size:16];
    _btnCloseGameMode.titleLabel.font = [UIFont fontWithName:@"Museo-500" size:16];
    _btnSave.titleLabel.font = [UIFont fontWithName:@"Museo-500" size:16];
    _btnMenu.titleLabel.font = [UIFont fontWithName:@"Museo-500" size:18];
;
}

- (IBAction)startTimer:(id)sender
{
    _bannerView.hidden = NO;
    if (![_username isEqualToString:@" "]) {
        _tfUsername.text = _username;
    }
    
    // Set up new game
    _clock = _gameLength;
	_tapCount = 0;
	_lblCounter.text = @"0";
	_lblTimer.text = [NSString stringWithFormat:@"%lu", (unsigned long)_clock];
	_isTimerStarted = YES;
	_btnStart.hidden = YES;
    _btnTap.hidden = NO;
	
    _countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown:) userInfo:nil repeats:YES];
}

- (void)countdown:(NSTimer *)timer
{
    // Invalidate timer if going back to menu
    if(_isTimerInvalidateSet)
    {
        [timer invalidate];
        return;
    }
    
    // Refresh the timer label as time ticks off
	[self setClock:(_clock -1)];
	_lblTimer.text = [NSString stringWithFormat:@"%lu", (unsigned long)_clock];
    
    // Signal user that the game is ending soon
    if (_clock <= 3) {
        [self playAudio];
    }
    
    // Game ended
	if (_clock <= 0) {
		[timer invalidate];
        _tfUsername.text = [_currentUserModelInstance getCurrentUser];
        _tapsPerSecond = (float)_tapCount / _gameLength;
		_isTimerStarted = NO;
		_lblScore.text = [NSString stringWithFormat:@"%d", _tapCount];
        _lblTapsPerSecond.text = [NSString stringWithFormat:@"%0.1f taps/sec", _tapsPerSecond];
        _btnTap.hidden = YES;
		_vwScore.hidden = NO;
	}
}

- (IBAction)gotoMenu:(id)sender {
    _isTimerInvalidateSet = true;
    
    [self countdown:_countdownTimer];
    
    _isTimerInvalidateSet = false;
}

- (IBAction)closeResultsView:(id)sender
{
    _vwScore.hidden = YES;
    _btnStart.hidden = NO;
    [_tfUsername resignFirstResponder];
}

- (IBAction)hideKeyboard:(id)sender
{
    [self resignFirstResponder];
}

- (IBAction)saveScore:(id)sender
{
    // Save the most recently entered username in order to prepopulate the username field later
    [_currentUserModelInstance saveCurrentUser:_tfUsername.text];
    _username = _tfUsername.text;
	
    // Send the score, gameType and username of finished game to Score Model
    [_scoreInstance checkScores:_tapCount withGameType:_gameType andUsername:_username];
	
    // Display score screen
    _vwScore.hidden = YES;
    _btnStart.hidden = NO;
	
    // Update high score label if a new record has been set.
    _lblHighScore.text = [_scoreInstance getHighScoreWithGameType:_gameType];
    [_tfUsername resignFirstResponder];
}

- (void)playAudio {
    [self playSound:@"beep-07" :@"mp3"];
}

- (void)playSound :(NSString *)fName :(NSString *) ext{
    SystemSoundID audioEffect;
    NSString *path = [[NSBundle mainBundle] pathForResource : fName ofType :ext];
    if ([[NSFileManager defaultManager] fileExistsAtPath : path]) {
        NSURL *pathURL = [NSURL fileURLWithPath: path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
        AudioServicesPlaySystemSound(audioEffect);
    }
    else {
        NSLog(@"error, file not found: %@", path);
    }
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    _bannerView.hidden = YES;
}


@end
