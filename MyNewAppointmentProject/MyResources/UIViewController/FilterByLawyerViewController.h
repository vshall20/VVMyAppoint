//
//  FilterByLawyerViewController.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FilterByLawyerDelegate<NSObject>
-(void)lawyerSelectedWithLawyerName:(NSString *)lawyerName;
@end



@interface FilterByLawyerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *view_BackGround;
@property (weak, nonatomic) IBOutlet UITextField *txt_Lawyer;
@property (weak, nonatomic) IBOutlet UITableView *tbl_LawyerList;
@property (nonatomic,assign) id <FilterByLawyerDelegate> myDelegate;
- (IBAction)arrowClicked:(id)sender;
- (IBAction)viewButtonClicked:(id)sender;
- (IBAction)cancelButtonClicked:(id)sender;

@end
