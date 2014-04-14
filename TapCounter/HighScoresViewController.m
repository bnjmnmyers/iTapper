//
//  HighScoresViewController.m
//  iTapper
//
//  Created by Benjamin Myers on 4/14/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import "HighScoresViewController.h"

@interface HighScoresViewController ()

@end

@implementation HighScoresViewController

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
    [self setFonts];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)setFonts
{
    _btnHalfMarathonScores.titleLabel.font = [UIFont fontWithName:@"Museo-500" size:14];
    _btnMarathonScores.titleLabel.font = [UIFont fontWithName:@"Museo-500" size:14];
    _btnSprintScores.titleLabel.font = [UIFont fontWithName:@"Museo-500" size:14];
    _btnMenu.titleLabel.font = [UIFont fontWithName:@"Museo-700" size:16];
    _lblScoresTitle.font = [UIFont fontWithName:@"Museo-700" size:19];
    _lblViewControllerTitle.font = [UIFont fontWithName:@"Museo-700" size:20];
    
}

- (void)setScoreLableWithGameType:(NSString *)gameType
{
    _lblScoresTitle.text = [NSString stringWithFormat:@"Top 10 %@ Score", gameType];
}

@end
