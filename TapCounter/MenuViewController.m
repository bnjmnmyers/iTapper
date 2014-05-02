//
//  MenuViewController.m
//  TapCounter
//
//  Created by Benjamin Myers on 4/3/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import "MenuViewController.h"
#import "GlobalScoreModel.h"
#import "Reachability.h"
#import "GameKitHelper.h"

@interface MenuViewController ()
{
    Reachability *internetReachable;
}

@property (strong, nonatomic) GlobalScoreModel *globalScoreModelInstance;

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self checkOnlineConnection];
    
    _globalScoreModelInstance = [[GlobalScoreModel alloc]init];
    
    if (_isConnected) {
        [_globalScoreModelInstance downloadGlobalScores];
    }
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenHeight = screenSize.height;
    CGFloat screenWidth = screenSize.width;
    
    if (screenHeight < 568) {
        NSLog(@"%f", screenWidth);
        NSLog(@"%f", screenHeight);
        _backgroundImageView.frame = CGRectMake(0, 0, 320, 480);
        _backgroundImageView.image = [UIImage imageNamed:@"menuScreen640x960"];
        [_backgroundImageView setContentMode:UIViewContentModeScaleAspectFit];
        
        _btnFastTapper.frame = CGRectMake(106, 350, 108, 46);
        _btnTapOff.frame = CGRectMake(106, 409, 108, 46);
        
        NSLog(@"%f", _backgroundImageView.frame.size.height);
        NSLog(@"%f", _backgroundImageView.frame.size.width);
        NSLog(@"%f", _backgroundImageView.frame.origin.x);
        NSLog(@"%f", _backgroundImageView.frame.origin.y);
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(showAuthenticationViewController)
     name:PresentAuthenticationViewController
     object:nil];
    
    [[GameKitHelper sharedGameKitHelper]
     authenticateLocalPlayer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAuthenticationViewController
{
    GameKitHelper *gameKitHelper =
    [GameKitHelper sharedGameKitHelper];
    
    [self presentViewController:
     gameKitHelper.authenticationViewController
                                         animated:YES
                                       completion:nil];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)prefersStatusBarHidden
{
    return TRUE;
}

- (void) checkOnlineConnection {
    
    internetReachable = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is not reachable
    // NOTE - change "reachableBlock" to "unreachableBlock"
    
    internetReachable.unreachableBlock = ^(Reachability*reach)
    {
		_isConnected = FALSE;
    };
	
	internetReachable.reachableBlock = ^(Reachability*reach)
    {
		_isConnected = TRUE;
    };
    
    [internetReachable startNotifier];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
