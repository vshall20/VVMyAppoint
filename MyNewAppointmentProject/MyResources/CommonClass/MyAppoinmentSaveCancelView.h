//
//  MyAppoinmentSaveCancelView.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 10/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAppoinmentSaveCancelView : UIView
@property (weak, nonatomic) IBOutlet UILabel *lbl_Title;
@property (weak, nonatomic) IBOutlet UIButton *btn_Save;
@property (weak, nonatomic) IBOutlet UIButton *btn_Cancel;
@property (weak, nonatomic) IBOutlet UITextField *txt_AppointmentType;
@property (weak, nonatomic) IBOutlet UIButton *btn_DropDownList;
@property (weak, nonatomic) IBOutlet UIButton *btn_Invite;
@property (weak, nonatomic) IBOutlet UIButton *btn_Basic;

@end
