//
//  HighScore.h
//  iTapper
//
//  Created by Benjamin Myers on 4/11/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface HighScore : NSManagedObject

@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * gameType;

@end
