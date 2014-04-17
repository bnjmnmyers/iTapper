//
//  Score.h
//  TapCounter
//
//  Created by Benjamin Myers on 4/2/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchRequest *fetchRequest;
@property (strong, nonatomic) NSEntityDescription *entity;
@property (strong, nonatomic) NSMutableArray *sort;
@property (strong, nonatomic) NSArray *sortDescriptors;
@property (strong, nonatomic) NSPredicate *predicate;
@property (strong, nonatomic) NSArray *scoresArray;

- (void)checkScores:(int)currentScore withGameType:(NSString *)gameType;
- (NSString *)getHighScoreWithGameType:(NSString *)gameType;
- (NSArray *)queryDataWithPredicate:(NSString *)predicate;
@end
