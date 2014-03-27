//
//  DataRequest.h
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataRequest : NSObject


@property (nonatomic, strong) NSString *chamberID;
@property (nonatomic, strong) NSString *lawyerID;

-(id)initWithlawyerID:(NSString *)lawyerID andChamberID:(NSString *)chamberID;
-(NSMutableDictionary *)fetchDataForParameter:(NSString *)parameterName;
-(NSMutableDictionary *)fetchData;


@end
