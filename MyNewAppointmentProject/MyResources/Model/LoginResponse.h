//
//  LoginResponse.h
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginResponse : NSObject

@property (nonatomic, strong) NSMutableDictionary *lawyerDictionary;


-(id)initWithDictionary:(NSMutableDictionary *)dict;

-(void)saveData;

@end
