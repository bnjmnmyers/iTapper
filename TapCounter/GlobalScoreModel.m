//
//  GlobalScoreModel.m
//  iTapper
//
//  Created by Benjamin Myers on 4/19/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import "GlobalScoreModel.h"
#import "GlobalScore.h"

#define webServiceGetGlobalScores @"http://www.appguys.biz/JSON/iTapperJSON.php?key=weBeTappin&method=getGlobalScores"

@implementation GlobalScoreModel

- (void)downloadGlobalScores
{
	id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
    [self clearEntity:@"GlobalScore"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@", webServiceGetGlobalScores];
	NSURL *url = [NSURL URLWithString:urlString];
	NSData *webData = [NSData dataWithContentsOfURL:url];
	
	NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:kNilOptions error:nil];
	NSDictionary *feed = [allDataDictionary objectForKey:@"feed"];
	NSDictionary *globalScoresDictionary = [feed objectForKey:@"globalScores"];
    NSDictionary *globalSprintScoresDictionary = [globalScoresDictionary objectForKey:@"sprint"];
    NSDictionary *globalHalfMarathonScoresDictionary = [globalScoresDictionary objectForKey:@"half-marathon "];
    NSDictionary *globalMarathonScoresDictionary = [globalScoresDictionary objectForKey:@"marathon"];
    
    for (NSDictionary *diction in globalSprintScoresDictionary) {
		GlobalScore *newGlobalScore = (GlobalScore *)[NSEntityDescription insertNewObjectForEntityForName:@"GlobalScore" inManagedObjectContext:_managedObjectContext];
		newGlobalScore.username = NSLocalizedString([diction objectForKey:@"username"], nil);
		newGlobalScore.gameType = NSLocalizedString([diction objectForKey:@"gameType"], nil);
		newGlobalScore.country = NSLocalizedString([diction objectForKey:@"country"], nil);
		newGlobalScore.score = [NSNumber numberWithInt:[NSLocalizedString([diction objectForKey:@"score"], nil) intValue]];
	}
    for (NSDictionary *diction in globalHalfMarathonScoresDictionary) {
		GlobalScore *newGlobalScore = (GlobalScore *)[NSEntityDescription insertNewObjectForEntityForName:@"GlobalScore" inManagedObjectContext:_managedObjectContext];
		newGlobalScore.username = NSLocalizedString([diction objectForKey:@"username"], nil);
		newGlobalScore.gameType = NSLocalizedString([diction objectForKey:@"gameType"], nil);
		newGlobalScore.country = NSLocalizedString([diction objectForKey:@"country"], nil);
		newGlobalScore.score = [NSNumber numberWithInt:[NSLocalizedString([diction objectForKey:@"score"], nil) intValue]];
	}
    for (NSDictionary *diction in globalMarathonScoresDictionary) {
		GlobalScore *newGlobalScore = (GlobalScore *)[NSEntityDescription insertNewObjectForEntityForName:@"GlobalScore" inManagedObjectContext:_managedObjectContext];
		newGlobalScore.username = NSLocalizedString([diction objectForKey:@"username"], nil);
		newGlobalScore.gameType = NSLocalizedString([diction objectForKey:@"gameType"], nil);
		newGlobalScore.country = NSLocalizedString([diction objectForKey:@"country"], nil);
		newGlobalScore.score = [NSNumber numberWithInt:[NSLocalizedString([diction objectForKey:@"score"], nil) intValue]];
	}
    
	[_managedObjectContext save:nil];
}

- (NSArray *)getTop10ScoresByGameType:(NSString *)gameType
{
    return _globalScoresArray;
}

- (void)clearEntity:(NSString *)entityName
{
	id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
	_fetchRequest = [[NSFetchRequest alloc]init];
	_entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self managedObjectContext]];
	
	[_fetchRequest setEntity:_entity];
	
	NSError *error = nil;
	NSArray* result = [[self managedObjectContext] executeFetchRequest:_fetchRequest error:&error];
	
	for (NSManagedObject *object in result) {
		[[self managedObjectContext] deleteObject:object];
	}
	
	NSError *saveError = nil;
	if (![[self managedObjectContext] save:&saveError]) {
		NSLog(@"An error has occurred: %@", saveError);
	}
}

@end
