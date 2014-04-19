//
//  GlobalScoreModel.h
//  iTapper
//
//  Created by Benjamin Myers on 4/19/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalScoreModel : NSObject

// CoreData Properties
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchRequest *fetchRequest;
@property (strong, nonatomic) NSEntityDescription *entity;
@property (strong, nonatomic) NSMutableArray *sort;
@property (strong, nonatomic) NSArray *sortDescriptors;
@property (strong, nonatomic) NSPredicate *predicate;
@property (strong, nonatomic) NSArray *globalScoresArray;

// Actions
- (void)downloadGlobalScores;
- (NSArray *)getTop10ScoresByGameType:(NSString *)gameType;

@end
