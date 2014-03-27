//
//  DataEntityValidator.h
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 18/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "DataEntity.h"

@interface DataEntityValidator : NSObject

@property (nonatomic, strong) DataEntity *entity;

-(BOOL)isValid;

-(id)initWithEntity:(DataEntity *)entity;

@end
