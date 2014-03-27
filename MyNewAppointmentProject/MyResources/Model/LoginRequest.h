//
//  LoginRequest.h
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginRequest : NSObject<UtilityDelegate>

@property (nonatomic, strong) NSString *chamberID;
@property (nonatomic, strong) NSString *lawyerID;

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSMutableDictionary *responseDict;

-(id)initWithUsername:(NSString *)username andPassword:(NSString *)password;

-(void)fetchLawyerIDandChamberID;

@end
