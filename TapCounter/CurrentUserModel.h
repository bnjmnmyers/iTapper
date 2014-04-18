//
//  CurrentUserModel.h
//  iTapper
//
//  Created by Benjamin Myers on 4/18/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentUserModel : NSObject

// CoreData Properties
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchRequest *fetchRequest;
@property (strong, nonatomic) NSEntityDescription *entity;
@property (strong, nonatomic) NSArray *currentUserArray;


@property (strong, nonatomic) NSString *currentUsername;

- (void)saveCurrentUser:(NSString *)username;
- (NSString *)getCurrentUser;
@end
