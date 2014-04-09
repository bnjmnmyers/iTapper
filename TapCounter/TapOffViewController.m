//
//  TapOffViewController.m
//  TapCounter
//
//  Created by Benjamin Myers on 4/3/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import "TapOffViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface TapOffViewController ()

@end

@implementation TapOffViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _museoFont = [UIFont fontWithName:@"Museo-500" size:16];
    _lblPlayer1Score.font = _museoFont;
    _lblPlayer2Score.font = _museoFont;
    _lblPlayer1Timer.font = _museoFont;
    _lblPlayer2Timer.font = _museoFont;
    _btnMenu.titleLabel.font = _museoFont;
    _btnStartTimer.titleLabel.font = _museoFont;
	_lblPlayer2Score.transform = CGAffineTransformMakeRotation(- M_PI_2/.5);
	_lblPlayer2Timer.transform = CGAffineTransformMakeRotation(- M_PI_2/.5);
	_btnPlayer2Tap.transform = CGAffineTransformMakeRotation(- M_PI_2/.5);
	_btnPlayer1Tap.enabled = NO;
	_btnPlayer2Tap.enabled = NO;
    for (NSString* s in [UIFont familyNames])
        NSLog(@"%@: %@", s, [UIFont fontNamesForFamilyName:s]);
    NSLog(@"%@",[UIFont familyNames]);
}

- (BOOL)prefersStatusBarHidden{
	return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)playerTap:(id)sender
{
	if (_isTimerStarted) {
		if ([sender tag] == 2) {
			_player1TapCount++;
			_lblPlayer1Score.text = [NSString stringWithFormat:@"%d", _player1TapCount];
		} else {
			_player2TapCount++;
			_lblPlayer2Score.text = [NSString stringWithFormat:@"%d", _player2TapCount];
		}
	}
	
}

- (IBAction)startTimer:(id)sender
{
	_player1TapCount = 0;
	_player2TapCount = 0;
	_clock = 10;
	_lblPlayer1Score.text = @"0";
	_lblPlayer2Score.text = @"0";
	_lblPlayer1Timer.text = [NSString stringWithFormat:@"%d", _clock];
	_lblPlayer2Timer.text = [NSString stringWithFormat:@"%d", _clock];
	_isTimerStarted = YES;
	_btnPlayer1Tap.enabled = YES;
	_btnPlayer2Tap.enabled = YES;
	_btnStartTimer.enabled = NO;
	
	
    NSTimer *countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown:) userInfo:nil repeats:YES];
	NSLog(@"%@", countdownTimer);
}

- (void)countdown:(NSTimer *)timer
{
	[self setClock:(_clock -1)];
	_lblPlayer1Timer.text = [NSString stringWithFormat:@"%d", _clock];
	_lblPlayer2Timer.text = [NSString stringWithFormat:@"%d", _clock];
    if (_clock <= 3) {
        [self playAudio];
    }
	if (_clock <= 0) {
		[timer invalidate];
		_isTimerStarted = NO;
		_btnPlayer1Tap.enabled = NO;
		_btnPlayer2Tap.enabled = NO;
		_btnStartTimer.enabled = YES;
	}
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

@end
