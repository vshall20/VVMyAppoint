//
//  SaveAppointmentResponse.h
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 22/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveAppointmentResponse : NSObject

@property (nonatomic, strong) NSMutableDictionary *responseDictionary;

-(id)initWithDictionary:(NSMutableDictionary *)dict;

-(void)parseAndSave;

@end
