//
//  Score.m
//  TapCounter
//
//  Created by Benjamin Myers on 4/2/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import "Score.h"
#import "HighScore.h"

@interface Score ()

@property (assign) NSString *highScore;
@property (assign) NSNumber *lowestScoreNum;
@property (strong, nonatomic) HighScore *lowestScore;

@end

@implementation Score

- (void)checkScores:(int)currentScore withGameType:(NSString *)gameType
{
    [self queryDataWithPredicate:gameType];
	[self saveScore:currentScore withGameType:gameType];
}

- (void)saveScore:(int)currentScore withGameType:(NSString *)gameType;
{
	id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
	
	NSNumber *currentScoreNum = [NSNumber numberWithInt:currentScore];
    NSLocale *currentLocale = [NSLocale currentLocale];  // get the current locale.
    NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
    
	if ([_scoresArray count] >= 10) {
		_lowestScore = [_scoresArray objectAtIndex:9];
		_lowestScoreNum = _lowestScore.score;
	}
	
	// If fewer than 10 scores add the score regardless
	if ([_scoresArray count] < 10) {
		HighScore *newScore = [NSEntityDescription insertNewObjectForEntityForName:@"HighScore" inManagedObjectContext:[self managedObjectContext]];
		
		newScore.username = @"Bizawesome";
		newScore.score = [NSNumber numberWithInt:currentScore];
        newScore.gameType = gameType;
        newScore.country = countryCode;
	}
	
	// If thew new score is higher than a previous score then replace the lowest score with the current score
	else if ([_scoresArray count] >= 10 && currentScoreNum > _lowestScoreNum){
		HighScore *newTop10Score = [_scoresArray objectAtIndex:9];
		
//		for (int x = 0; x < [_scoresArray count] - 1; x++) {
//			HighScore *score = [_scoresArray objectAtIndex:x];
//			NSLog(@"%@", score.score);
//		}
		
		newTop10Score.username = @"Bizawesome";
		newTop10Score.score = currentScoreNum;
	}
	
	[self.managedObjectContext save:nil];
}

- (NSString *)getHighScoreWithGameType:(NSString *)gameType
{
	[self queryDataWithPredicate:gameType];
	if ([_scoresArray count] > 0) {
		HighScore *highScoreObj = [_scoresArray objectAtIndex:0];
		_highScore = [NSString stringWithFormat:@"%@", highScoreObj.score];
		
	} else {
		_highScore = @"0";
	}
	
	return _highScore;
}

- (NSArray *)queryData
{
	id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
	
	_fetchRequest = [[NSFetchRequest alloc] init];
	_entity = [NSEntityDescription entityForName:@"HighScore" inManagedObjectContext:[self managedObjectContext]];
	_sort = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO];
	_sortDescriptors = [[NSArray alloc]initWithObjects:_sort, nil];
	
	[_fetchRequest setEntity:_entity];
	[_fetchRequest setSortDescriptors:_sortDescriptors];
	
	NSError *error = nil;
	
	_scoresArray = [[self managedObjectContext] executeFetchRequest:_fetchRequest error:&error];
	
	return _scoresArray;
}


- (NSArray *)queryDataWithPredicate:(NSString *)predicate
{
	id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
	
	_fetchRequest = [[NSFetchRequest alloc] init];
	_entity = [NSEntityDescription entityForName:@"HighScore" inManagedObjectContext:[self managedObjectContext]];
	_sort = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO];
	_sortDescriptors = [[NSArray alloc]initWithObjects:_sort, nil];
    _predicate = [NSPredicate predicateWithFormat:@"gameType = %@", predicate];
	
	[_fetchRequest setEntity:_entity];
	[_fetchRequest setSortDescriptors:_sortDescriptors];
    [_fetchRequest setPredicate:_predicate];
	
	NSError *error = nil;
	
	_scoresArray = [[self managedObjectContext] executeFetchRequest:_fetchRequest error:&error];
	
	return _scoresArray;
}


@end
