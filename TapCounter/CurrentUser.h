//
//  CurrentUser.h
//  iTapper
//
//  Created by Benjamin Myers on 4/18/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CurrentUser : NSManagedObject

@property (nonatomic, retain) NSString * username;

@end
