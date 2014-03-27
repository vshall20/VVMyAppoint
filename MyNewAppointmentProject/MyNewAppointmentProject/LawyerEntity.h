//
//  LawyerEntity.h
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 26/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LawyerEntity : NSManagedObject

@property (nonatomic, retain) NSString * chamberID;
@property (nonatomic, retain) NSString * lawyerID;
@property (nonatomic, retain) NSString * emailAddress;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * loginStatus;
@property (nonatomic, retain) NSString * roleId;
@property (nonatomic, retain) NSString * roleName;

@end
