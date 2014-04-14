//
//  HighScoresViewController.h
//  iTapper
//
//  Created by Benjamin Myers on 4/14/14.
//  Copyright (c) 2014 appguys.biz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScoresViewController : UIViewController

// CoreData Properties
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchRequest *fetchRequest;
@property (strong, nonatomic) NSEntityDescription *entity;
@property (strong, nonatomic) NSMutableArray *sort;
@property (strong, nonatomic) NSArray *sortDescriptors;
@property (strong, nonatomic) NSPredicate *predicate;
@property (strong, nonatomic) NSArray *scoresArray;

// UI Properties
@property (strong, nonatomic) IBOutlet UIButton *btnMenu;
@property (strong, nonatomic) IBOutlet UIButton *btnSettings;
@property (strong, nonatomic) IBOutlet UIButton *btnSprintScores;
@property (strong, nonatomic) IBOutlet UIButton *btnHalfMarathonScores;
@property (strong, nonatomic) IBOutlet UIButton *btnMarathonScores;
@property (strong, nonatomic) IBOutlet UILabel *lblViewControllerTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblScoresTitle;

@property (strong, nonatomic) IBOutlet UILabel *lbl1stPlace;
@property (strong, nonatomic) IBOutlet UILabel *lbl1stPlaceScore;
@property (strong, nonatomic) IBOutlet UILabel *lbl2ndPlace;
@property (strong, nonatomic) IBOutlet UILabel *lbl2ndPlaceScore;
@property (strong, nonatomic) IBOutlet UILabel *lbl3rdPlace;
@property (strong, nonatomic) IBOutlet UILabel *lbl3rdPlaceScore;
@property (strong, nonatomic) IBOutlet UILabel *lbl4thPlace;
@property (strong, nonatomic) IBOutlet UILabel *lbl4thPlaceScore;
@property (strong, nonatomic) IBOutlet UILabel *lbl5thPlace;
@property (strong, nonatomic) IBOutlet UILabel *lbl5thPlaceScore;
@property (strong, nonatomic) IBOutlet UILabel *lbl6thPlace;
@property (strong, nonatomic) IBOutlet UILabel *lbl6thPlaceScore;
@property (strong, nonatomic) IBOutlet UILabel *lbl7thPlace;
@property (strong, nonatomic) IBOutlet UILabel *lbl7thPlaceScore;
@property (strong, nonatomic) IBOutlet UILabel *lbl8thPlace;
@property (strong, nonatomic) IBOutlet UILabel *lbl8thPlaceScore;
@property (strong, nonatomic) IBOutlet UILabel *lbl9thPlace;
@property (strong, nonatomic) IBOutlet UILabel *lbl9thPlaceScore;
@property (strong, nonatomic) IBOutlet UILabel *lbl10thPlace;
@property (strong, nonatomic) IBOutlet UILabel *lbl10thPlaceScore;

// Variable Properties


// Actions


@end
