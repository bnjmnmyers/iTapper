//
//  LaunchViewController.m
//  TapCounter
//
//  Created by Benjamin Myers on 4/5/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

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
	// Do any additional setup after loading the view.
    NSTimer *countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdown:) userInfo:nil repeats:YES];
	_timeTillSegue = 2;
}

- (void)countdown:(NSTimer *)timer
{
	[self setTimeTillSegue:(_timeTillSegue -1)];
	NSLog(@"%d", _timeTillSegue);
	if (_timeTillSegue <= 0) {
		[timer invalidate];
		[self performSegueWithIdentifier:@"segueFromLaunchViewtoDevView" sender:self];
	}
}

- (BOOL)prefersStatusBarHidden
{
	return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
