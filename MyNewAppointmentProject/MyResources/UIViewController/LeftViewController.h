//
//  LeftViewController.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 04/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftViewControllerDelegate <NSObject>
-(void)leftSideTableViewSelectedWithStringValue:(NSString *)name indexValue:(int)indexValue;
@end

@interface LeftViewController : UITableViewController
@property(nonatomic,assign)id <LeftViewControllerDelegate> delegate;
@property(nonatomic,readwrite) NSArray  *myArray;

@end
