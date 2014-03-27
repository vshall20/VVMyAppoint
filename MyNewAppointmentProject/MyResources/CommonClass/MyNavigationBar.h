//
//  MyNavigationBar.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 05/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNavigationBar : UINavigationBar
@property (weak, nonatomic) IBOutlet UINavigationItem *myNavigationItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *myLeftBarItem;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *myRightItem;

@end
