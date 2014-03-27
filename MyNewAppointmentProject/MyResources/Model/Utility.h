//
//  Utility.h
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

//// protocol to get WebSerVices respone ///////
@protocol UtilityDelegate <NSObject>
-(void)inComingResponse:(id)response forRequest:(NSString *)request;
-(void)inComingError:(NSString *)errorMessage forRequest:(NSString *)request;
@end

@interface Utility : NSObject

@property (nonatomic, assign) BOOL isNetworkConnectionAvailable;
@property (nonatomic, strong) NSString *chamberID;
@property (nonatomic, strong) NSString *lawyerID;

@property (nonatomic, weak) id<UtilityDelegate> delegate;

- (void) startConnectionCheck;
+(Utility *)sharedInstance;
-(void)fetchDataWithMethodName:(NSString *)webMethod andParameterDictionary:(NSMutableDictionary *)dictionary;
-(NSString *)baseURL;
-(NSMutableDictionary *)fetchData:(NSString *)webMethod;
//-(void)fetchDataAndSave:(NSString *)parameterName;
@end
