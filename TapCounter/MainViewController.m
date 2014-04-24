//
//  MainViewController.m
//  TapCounter
//
//  Created by Benjamin Myers on 4/1/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)prefersStatusBarHidden
{
	return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	NSTimer *countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown:) userInfo:nil repeats:YES];
	_timeTillSegue = 2;
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenHeight = screenSize.height;
    
    if (screenHeight < 568) {
        _backgroundImageView.frame = CGRectMake(0, 0, 320, 480);
        _backgroundImageView.image = [UIImage imageNamed:@"developerScreen640x960"];
    }
}

- (void)countdown:(NSTimer *)timer
{
	[self setTimeTillSegue:(_timeTillSegue -1)];
	NSLog(@"%d", _timeTillSegue);
	if (_timeTillSegue <= 0) {
		[timer invalidate];
		[self performSegueWithIdentifier:@"segueFromDevToMenu" sender:self];
	}
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

@end
