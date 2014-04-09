//
//  ViewController.m
//  TapCounter
//
//  Created by Benjamin Myers on 4/1/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import "FastTapperViewController.h"
#import "Score.h"
#import <AVFoundation/AVFoundation.h>
@interface FastTapperViewController ()

@property (strong, nonatomic) Score *scoreInstance;

@end

@implementation FastTapperViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	id delegate = [[UIApplication sharedApplication] delegate];
	self.managedObjectContext = [delegate managedObjectContext];
	
	_scoreInstance = [[Score alloc]init];
	_tapCount = 0;
	_lblHighScore.text = [_scoreInstance getHighScore];
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

//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//}
- (IBAction)playerTap:(id)sender
{
	if (_isTimerStarted) {
		_tapCount++;
		_lblCounter.text = [NSString stringWithFormat:@"%d", _tapCount];
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
    _lblTimer.font = [UIFont fontWithName:@"Museo-700" size:100];
    _btnMenu.titleLabel.font = [UIFont fontWithName:@"Museo-500" size:16];
;
}

- (IBAction)startTimer:(id)sender
{
	_tapCount = 0;
	_clock = 10;
	_lblCounter.text = @"0";
	_lblTimer.text = [NSString stringWithFormat:@"%d", _clock];
	_isTimerStarted = YES;
	_btnStart.hidden = YES;
    _btnTap.hidden = NO;
	
    NSTimer *countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown:) userInfo:nil repeats:YES];
	NSLog(@"%@", countdownTimer);
}

- (void)countdown:(NSTimer *)timer
{
	[self setClock:(_clock -1)];
	_lblTimer.text = [NSString stringWithFormat:@"%d", _clock];
    if (_clock <= 3) {
        [self playAudio];
    }
	if (_clock <= 0) {
		[timer invalidate];
        _tapsPerSecond = (float)_tapCount / 10;
		_isTimerStarted = NO;
		_lblScore.text = [NSString stringWithFormat:@"%d", _tapCount];
        _lblTapsPerSecond.text = [NSString stringWithFormat:@"%0.1f taps/sec", _tapsPerSecond];
        _btnTap.hidden = YES;
		_vwScore.hidden = NO;
	}
}

- (IBAction)saveScore:(id)sender {
	[_scoreInstance checkScores:_tapCount];
	_vwScore.hidden = YES;
	_lblHighScore.text = [_scoreInstance getHighScore];
    _btnStart.hidden = NO;
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
