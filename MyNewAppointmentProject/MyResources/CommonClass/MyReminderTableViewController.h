//
//  MyReminderTableViewController.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 13/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReminderTableViewControllerDelegate <NSObject>

-(void)reminderSelectedWithValue:(NSString *)reminderValue;

@end
@interface MyReminderTableViewController : UITableViewController
@property(readwrite)int selectedRow;
@property(nonatomic,assign)id <ReminderTableViewControllerDelegate> myDelegate;
@end
