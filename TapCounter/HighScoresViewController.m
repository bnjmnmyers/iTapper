//
//  HighScoresViewController.m
//  iTapper
//
//  Created by Benjamin Myers on 4/14/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import "HighScoresViewController.h"
#import "Score.h"
#import "HighScore.h"

@interface HighScoresViewController ()

@property (strong, nonatomic) Score *scoreInstance;

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
    _scoreInstance = [[Score alloc]init];
	// Do any additional setup after loading the view.
    [self setFonts];
    [self getSprintScores:0];
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
    _lblScoresTitle.text = [NSString stringWithFormat:@"Top 10 %@ Scores", gameType];
}

- (IBAction)getSprintScores:(id)sender
{
    _scoresArray = [_scoreInstance queryDataWithPredicate:@"Sprint"];
    [self setScoreLableWithGameType:@"Sprint"];
    [self getScores];
}

- (IBAction)getHalfMarathonScores:(id)sender
{
    _scoresArray = [_scoreInstance queryDataWithPredicate:@"Half-Marathon"];
    [self setScoreLableWithGameType:@"Half-Marathon"];
    [self getScores];
}

- (IBAction)getMarathonScores:(id)sender
{
    _scoresArray = [_scoreInstance queryDataWithPredicate:@"Marathon"];
    [self setScoreLableWithGameType:@"Marathon"];
    [self getScores];
}

- (void)getScores
{
    // Reset Labels
    for (int i = 1; i < 11; i++) {
        [self setValue:[UIFont fontWithName:@"Museo-500" size:14] forKeyPath:[NSString stringWithFormat:@"_lbl%iPlace.font", i]];
        [self setValue:[UIFont fontWithName:@"Museo-500" size:14] forKeyPath:[NSString stringWithFormat:@"_lbl%iPlaceScore.font", i]];
        [self setValue:[NSString stringWithFormat:@"-"] forKeyPath:[NSString stringWithFormat:@"_lbl%iPlace.text", i]];
        [self setValue:[NSString stringWithFormat:@"-"] forKeyPath:[NSString stringWithFormat:@"_lbl%iPlaceScore.text", i]];
    }
    
    if ([_scoresArray count] > 0) {
        for (int i = 0; i < [_scoresArray count]; i++) {
            int scorePlace = i+1;
            HighScore *highScoreObj = [_scoresArray objectAtIndex:i];
            NSLog(@"%@", highScoreObj.score);
            [self setValue:[NSString stringWithFormat:@"%@", highScoreObj.username] forKeyPath:[NSString stringWithFormat:@"_lbl%iPlace.text", scorePlace]];
            [self setValue:[NSString stringWithFormat:@"%@", highScoreObj.score] forKeyPath:[NSString stringWithFormat:@"_lbl%iPlaceScore.text", scorePlace]];
        }
    }
    else{
        for (int i = 1; i < 11; i++) {
            [self setValue:[NSString stringWithFormat:@"-"] forKeyPath:[NSString stringWithFormat:@"_lbl%iPlace.text", i]];
            [self setValue:[NSString stringWithFormat:@"-"] forKeyPath:[NSString stringWithFormat:@"_lbl%iPlaceScore.text", i]];
        }
    }
}

@end
