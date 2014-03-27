//
//  SaveAppointmentRequest.h
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 22/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataEntity.h"

@interface SaveAppointmentRequest : NSObject

@property (nonatomic, readwrite) DataEntity *entity;

-(id)initWithDataEntity:(DataEntity *)dataEntity;
-(NSMutableDictionary *)saveRequest;

@end
