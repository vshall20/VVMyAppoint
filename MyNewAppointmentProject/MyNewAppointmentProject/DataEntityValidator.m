//
//  DataEntityValidator.m
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 18/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "DataEntityValidator.h"

@implementation DataEntityValidator


-(id)initWithEntity:(DataEntity *)entity
{
    self = [super init];
    if (self) {
        _entity = entity;
    }
    return  self;
}

-(BOOL)isValid
{
    BOOL valid = YES;
    
    if (_entity.subject.length <=0) {
        return NO;
    }
    
    if ([_entity.appointmentType isEqualToString:@"Event"]) {
        if (_entity.venue.length <= 0) {
            return NO;
        }
    }
    if ([_entity.appointmentType isEqualToString:@"Holiday"] || [_entity.appointmentType isEqualToString:@"Birthday"] || [_entity.appointmentType isEqualToString:@"Aniversary"] ) {
        if (!_entity.start) {
            return NO;
        }
    }
    else
    {
        if (!_entity.start || !_entity.end) {
            return NO;
        }
    }
    return valid;

}

@end
