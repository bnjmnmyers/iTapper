//
//  MainViewController.h
//  TapCounter
//
//  Created by Benjamin Myers on 4/1/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

//UI Properties
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;

// Variable Properties
@property (assign) int timeTillSegue;

@end
