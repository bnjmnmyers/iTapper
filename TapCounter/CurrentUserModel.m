//
//  CurrentUserModel.m
//  iTapper
//
//  Created by Benjamin Myers on 4/18/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import "CurrentUserModel.h"
#import "CurrentUser.h"

@implementation CurrentUserModel

- (void)saveCurrentUser:(NSString *)username
{
	id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
    [self getCurrentUser];
    
    if ([_currentUserArray count] != 0) {
        CurrentUser *currentUser = [_currentUserArray objectAtIndex:0];
        currentUser.username = username;
    } else {
        CurrentUser *currentUser = [NSEntityDescription insertNewObjectForEntityForName:@"CurrentUser" inManagedObjectContext:[self managedObjectContext]];
		
		currentUser.username = username;
    }
}

- (NSString *)getCurrentUser
{
	id delegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [delegate managedObjectContext];
    
    _fetchRequest = [[NSFetchRequest alloc]init];
    _entity = [NSEntityDescription entityForName:@"CurrentUser" inManagedObjectContext:[self managedObjectContext]];
    
    [_fetchRequest setEntity:_entity];
    
    NSError *error = nil;
    _currentUserArray = [[self managedObjectContext] executeFetchRequest:_fetchRequest error:&error];
    
    if ([_currentUserArray count] > 0) {
        CurrentUser *currentUser = [_currentUserArray objectAtIndex:0];
        _currentUsername = currentUser.username;
    } else {
        _currentUsername = @"";
    }
    
    return _currentUsername;
}

@end
