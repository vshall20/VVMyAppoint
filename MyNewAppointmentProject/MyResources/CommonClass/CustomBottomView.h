//
//  CustomBottomView.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 14/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBottomView : UIView
@property (weak, nonatomic) IBOutlet UIView *view_Matter;
@property (weak, nonatomic) IBOutlet UIButton *btn_Matter;
@property (weak, nonatomic) IBOutlet UIView *view_Attending;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Attending;
@property (weak, nonatomic) IBOutlet UIButton *btn_Yes;
@property (weak, nonatomic) IBOutlet UIButton *btn_No;
@property (weak, nonatomic) IBOutlet UIView *view_AttendingAccepted;
@property (weak, nonatomic) IBOutlet UILabel *lbl_AttendingAccepted;

@end
