//
//  Score.m
//  TapCounter
//
//  Created by Benjamin Myers on 4/2/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import "Score.h"
#import "HighScore.h"
#import "Reachability.h"
#import <GameKit/GameKit.h>
#import "GameKitHelper.h"

#define webServiceSaveScore @"http://www.appguys.biz/JSON/iTapperJSON.php?key=weBeTappin"

@interface Score ()
{
    Reachability *internetReachable;
}

@property (assign) NSString *highScore;
@property (assign) NSNumber *lowestScoreNum;
@property (strong, nonatomic) HighScore *lowestScore;
@property (strong, nonatomic) GameKitHelper *gameKitHelperInstance;

@end

@implementation Score

- (void)checkScores:(int)currentScore withGameType:(NSString *)gameType andUsername:(NSString *)username
{
    [self queryDataWithPredicate:gameType];
	[self saveScore:currentScore withGameType:gameType andUsername:username];
}

- (void)saveScore:(int)currentScore withGameType:(NSString *)gameType andUsername:(NSString *)username
{
	id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
	NSNumber *currentScoreNum = [NSNumber numberWithInt:currentScore];
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
    // If 10 scores have been saved then grab the lowest score for comparison with the most recent score
	if ([_scoresArray count] >= 10) {
		_lowestScore = [_scoresArray objectAtIndex:9];
		_lowestScoreNum = _lowestScore.score;
	}
	
	// If fewer than 10 scores add the score regardless
	if ([_scoresArray count] < 10) {
		HighScore *newScore = [NSEntityDescription insertNewObjectForEntityForName:@"HighScore" inManagedObjectContext:[self managedObjectContext]];
		
		newScore.username = username;
		newScore.score = [NSNumber numberWithInt:currentScore];
        newScore.gameType = gameType;
        newScore.country = countryCode;
	}
	// If thew new score is higher than a previous score then replace the lowest score with the current score
	else if ([_scoresArray count] >= 10 && currentScoreNum > _lowestScoreNum){
		HighScore *newTop10Score = [_scoresArray objectAtIndex:9];
		
		newTop10Score.username = username;
		newTop10Score.score = currentScoreNum;
	}
    
    // If the user is connected to the interet save their score to AppGuys:iTapper database.
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWiFi || [[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWWAN) {
        NSString *urlString = [NSString stringWithFormat:@"%@&username=%@&score=%d&gameType=%@&country=%@", webServiceSaveScore, username, currentScore, gameType, countryCode];
        NSLog(@"%@", urlString);
        NSURL *url = [[NSURL alloc]initWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSData *data = [NSData dataWithContentsOfURL:url];
    }else{
        NSLog(@"Not Connected");
    }
	
    // Save scores to CoreData
	[self.managedObjectContext save:nil];
}

- (NSString *)getHighScoreWithGameType:(NSString *)gameType
{
    // Grab the scores for the current gameType
	[self queryDataWithPredicate:gameType];
    
    // If the number of saved scores is greater than 0 get the highest score
	if ([_scoresArray count] > 0) {
		HighScore *highScoreObj = [_scoresArray objectAtIndex:0];
		_highScore = [NSString stringWithFormat:@"%@", highScoreObj.score];
        int highScoreInt = [_highScore intValue];
        
        // If the user is connected save the score to GameCenter
        if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWiFi || [[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWWAN) {
            _gameKitHelperInstance = [[GameKitHelper alloc] init];
            [_gameKitHelperInstance saveHighScoreToGameCenter:highScoreInt byGameType:gameType];
        }
		
	} else {
		_highScore = @"0";
	}
	
    // Return the highest saved score for to be displayed on the UI
	return _highScore;
}

- (NSArray *)queryDataWithPredicate:(NSString *)predicate
{
	id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
	
    // Get the higest score based on gameType
	_fetchRequest = [[NSFetchRequest alloc] init];
	_entity = [NSEntityDescription entityForName:@"HighScore" inManagedObjectContext:[self managedObjectContext]];
	_sort = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO];
	_sortDescriptors = [[NSArray alloc]initWithObjects:_sort, nil];
    _predicate = [NSPredicate predicateWithFormat:@"gameType = %@", predicate];
	
	[_fetchRequest setEntity:_entity];
	[_fetchRequest setSortDescriptors:_sortDescriptors];
    [_fetchRequest setPredicate:_predicate];
	
	NSError *error = nil;
	// Place scores into an array
	_scoresArray = [[self managedObjectContext] executeFetchRequest:_fetchRequest error:&error];
	
	return _scoresArray;
}

@end
