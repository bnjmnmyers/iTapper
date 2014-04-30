//
//  MenuViewController.h
//  TapCounter
//
//  Created by Benjamin Myers on 4/3/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController

// UI Properties
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet UIButton *btnFastTapper;
@property (strong, nonatomic) IBOutlet UIButton *btnTapOff;

// Variable Properties
@property (assign) BOOL isConnected;

@end
