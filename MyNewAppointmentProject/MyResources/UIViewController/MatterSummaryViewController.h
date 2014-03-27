//
//  MatterSummaryViewController.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 19/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataEntity.h"

@interface MatterSummaryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tbl_MatterSummary;
@property(nonatomic,readwrite)DataEntity *model;
@end
