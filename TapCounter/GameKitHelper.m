//
//  GameKitHelper.m
//  iTapper
//
//  Created by Benjamin Myers on 5/1/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import "GameKitHelper.h"


#define SPRINT_LEADER_BOARD_ID @"iTapper1"
#define HALFMARATHON_LEADER_BOARD_ID @"iTapper2"
#define MARATHON_LEADER_BOARD_ID @"iTapper3"

NSString *const PresentAuthenticationViewController = @"present_authentication_view_controller";

@implementation GameKitHelper {
    BOOL _enableGameCenter;
    
}

- (id)init
{
    self = [super init];
    if (self) {
        _enableGameCenter = YES;
    }
    return self;
}

+ (instancetype)sharedGameKitHelper
{
    static GameKitHelper *sharedGameKitHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGameKitHelper = [[GameKitHelper alloc] init];
    });
    return sharedGameKitHelper;
}

- (void)authenticateLocalPlayer
{
    //1
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    //2
    localPlayer.authenticateHandler  =
    ^(UIViewController *viewController, NSError *error) {
        //3
        [self setLastError:error];
        
        if(viewController != nil) {
            //4
            [self setAuthenticationViewController:viewController];
        } else if([GKLocalPlayer localPlayer].isAuthenticated) {
            //5
            _enableGameCenter = YES;
        } else {
            //6
            _enableGameCenter = NO;
        }
    };
}

- (void)setAuthenticationViewController:(UIViewController *)authenticationViewController
{
    if (authenticationViewController != nil) {
        _authenticationViewController = authenticationViewController;
        [[NSNotificationCenter defaultCenter]
         postNotificationName:PresentAuthenticationViewController
         object:self];
    }
}

- (void)setLastError:(NSError *)error
{
    _lastError = [error copy];
    if (_lastError) {
        NSLog(@"GameKitHelper ERROR: %@",
              [[_lastError userInfo] description]);
    }
}

- (void)saveHighScoreToGameCenter:(int)currentScore byGameType:(NSString *)gameType
{
    if ([GKLocalPlayer localPlayer].isAuthenticated) {
        if ([gameType isEqualToString:@"Sprint"]) {
            GKScore* score = [[GKScore alloc] initWithLeaderboardIdentifier:SPRINT_LEADER_BOARD_ID];
            score.value = currentScore;
            [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
                if (error) {
                    // handle error
                }
            }];
        }
        else if ([gameType isEqualToString:@"Half-Marathon"])
        {
            GKScore* score = [[GKScore alloc] initWithLeaderboardIdentifier:HALFMARATHON_LEADER_BOARD_ID];
            score.value = currentScore;
            [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
                if (error) {
                    // handle error
                }
            }];
        } else {
            GKScore* score = [[GKScore alloc] initWithLeaderboardIdentifier:MARATHON_LEADER_BOARD_ID];
            score.value = currentScore;
            [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
                if (error) {
                    // handle error
                }
            }];
        }
    }
}

@end
