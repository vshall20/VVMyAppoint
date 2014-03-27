//
//  DetailedAppointmentViewController.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 13/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataEntity.h"

@interface DetailedAppointmentViewController : UIViewController

@property(strong,nonatomic) DataEntity  *entityData;
@property (weak, nonatomic) IBOutlet UIButton *btn_Basic;
@property (weak, nonatomic) IBOutlet UIButton *btn_Invite;
- (IBAction)buttnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tbl_MyTable;

@end
