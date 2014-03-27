//
//  MyAppointmentListViewController.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 04/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Utility.h"

@interface MyAppointmentListViewController : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tbl_AppointmentList;
@property (nonatomic, strong) NSString *chamberID;
@property (nonatomic, strong) NSString *lawyerID;
@property (nonatomic, strong) NSFetchedResultsController *fetchResultController;
@property (nonatomic, strong) NSMutableArray *dateArray;

- (IBAction)leftBarClicked:(id)sender;
- (IBAction)rightBarClicked:(id)sender;


@end
