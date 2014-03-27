//
//  AddEditAppoinmentViewController.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 10/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataEntity.h"

@protocol AddEditAppointmentViewDelegate <NSObject>

-(void)inviteButtonState:(BOOL)state;

@end

@interface AddEditAppoinmentViewController : UITableViewController<UtilityDelegate>
@property (nonatomic,readwrite)NSString    *str_AppointmentType;
@property(strong,nonatomic) DataEntity  *entityData;
@property(strong,nonatomic) DataEntity  *model;
@property (nonatomic, weak) id<AddEditAppointmentViewDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *dict_linkToCaseID;
@property(readwrite)int mode; /// 0 for Add 1 for Edit 2 For Add Another Matter
@end
