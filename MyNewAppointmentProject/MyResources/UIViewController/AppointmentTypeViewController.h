//
//  AppointmentTypeViewController.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AppointmentTypeDelegate <NSObject>
-(void)appointmentTypeClickedWithAppointmentTypeName:(NSString *)name buttonIndex:(int)indexValue;
@end



@interface AppointmentTypeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *view_BackGround;
- (IBAction)appointmentTypeClicked:(id)sender;
@property(nonatomic,assign)id <AppointmentTypeDelegate> myDelegate;


@end
