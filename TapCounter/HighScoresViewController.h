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
@property (strong, nonatomic) IBOutlet UILabel *lbl1Place;
@property (strong, nonatomic) IBOutlet UILabel *lbl1PlaceScore;
@property (strong, nonatomic) IBOutlet UILabel *lbl2Place;
@property (strong, nonatomic) IBOutlet UILabel *lbl2PlaceScore;
@property (strong, nonatomic) IBOutlet UILabel *lbl3Place;
@property (strong, nonatomic) IBOutlet UILabel *lbl3PlaceScore;
@property (strong, nonatomic) IBOutlet UILabel *lbl4Place;
@property (strong, nonatomic) IBOutlet UILabel *lbl4PlaceScore;
@property (strong, nonatomic) IBOutlet UILabel *lbl5Place;
@property (strong, nonatomic) IBOutlet UILabel *lbl5PlaceScore;
@property (strong, nonatomic) IBOutlet UILabel *lbl6Place;
@property (strong, nonatomic) IBOutlet UILabel *lbl6PlaceScore;
@property (strong, nonatomic) IBOutlet UILabel *lbl7Place;
@property (strong, nonatomic) IBOutlet UILabel *lbl7PlaceScore;
@property (strong, nonatomic) IBOutlet UILabel *lbl8Place;
@property (strong, nonatomic) IBOutlet UILabel *lbl8PlaceScore;
@property (strong, nonatomic) IBOutlet UILabel *lbl9Place;
@property (strong, nonatomic) IBOutlet UILabel *lbl9PlaceScore;
@property (strong, nonatomic) IBOutlet UILabel *lbl10Place;
@property (strong, nonatomic) IBOutlet UILabel *lbl10PlaceScore;

// Variable Properties


// Actions
- (IBAction)getSprintScores:(id)sender;
- (IBAction)getHalfMarathonScores:(id)sender;
- (IBAction)getMarathonScores:(id)sender;


@end
