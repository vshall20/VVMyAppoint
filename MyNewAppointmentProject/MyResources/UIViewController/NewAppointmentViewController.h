//
//  NewAppointmentViewController.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 05/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataEntity.h"

@interface NewAppointmentViewController : UIViewController<UITabBarDelegate>

@property(strong,nonatomic) DataEntity  *entityData;
@property(readwrite)int mode; /// 0 for Add 1 for Edit 2 For Add Another Matter
@property(nonatomic, strong) NSMutableDictionary *saveDictionary;

@end
