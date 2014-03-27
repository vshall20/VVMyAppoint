//
//  SaveAppointmentResponse.m
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 22/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "SaveAppointmentResponse.h"

@implementation SaveAppointmentResponse

-(id)initWithDictionary:(NSMutableDictionary *)dict
{
    self = [super init];
    if (self) {
        _responseDictionary = dict;
    }
    return self;
}

-(void)parseAndSave
{
//   Pase and save or hit request, whatever is needed.
    
}

@end
