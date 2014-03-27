//
//  LoginRequest.m
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "LoginRequest.h"
#import "LoginResponse.h"

@implementation LoginRequest


-(id)initWithUsername:(NSString *)username andPassword:(NSString *)password
{
    self = [super init];
    if (self) {
        self = [[LoginRequest alloc]init];
        _username = username;
        _password = password;
    }
    return self;
}

-(NSString *)servicePath
{
    return @"Login";
}

-(void)inComingResponse:(id)response forRequest:(NSString *)request
{
    _responseDict = (NSMutableDictionary *)response;
    _chamberID = [_responseDict valueForKeyPath:@"logindata.chamberid"];
    _lawyerID  = [_responseDict valueForKeyPath:@"logindata.lawerid"];
    
    [[AppDelegate delegate] setLawyerID:_lawyerID];
    [[AppDelegate delegate] setChamberID:_chamberID];
    
    LoginResponse *lresponse = [[LoginResponse alloc]initWithDictionary:[self responseDict]];
    [lresponse saveData];
}

-(void)inComingError:(NSString *)errorMessage forRequest:(NSString *)request
{
    
}

-(void)fetchLawyerIDandChamberID
{
//    NSString *parameterName = [NSString stringWithFormat:@"%@parameter={\"id\":\"chm00101\",\"username\":\"%@\",\"password\":\"%@\",\"flag\":\"1\"}",[self servicePath],_username,_password];
//    NSLog(@"Parameter name for local login type:=%@",parameterName);
    
    
}

@end
