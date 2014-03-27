//
//  DataEntity.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DataEntity : NSManagedObject

@property (nonatomic, retain) NSString * appId;
@property (nonatomic, retain) NSString * appointmentType;
@property (nonatomic, retain) NSString * caseId;
@property (nonatomic, retain) NSString * clientName;
@property (nonatomic, retain) NSString * createdBy;
@property (nonatomic, retain) NSDate * createdDate;
@property (nonatomic, retain) NSString * appointmentDescription;
@property (nonatomic, retain) NSDate * end;
@property (nonatomic, retain) NSString * eventVisibility;
@property (nonatomic, retain) NSString * holidayType;
@property (nonatomic, retain) NSString * isAllDay;
@property (nonatomic, retain) NSDate * matterFromDate;
@property (nonatomic, retain) NSString * matterStatus;
@property (nonatomic, retain) NSString * matterSummary;
@property (nonatomic, retain) NSDate * matterToDate;
@property (nonatomic, retain) NSString * recurrenceParentId;
@property (nonatomic, retain) NSString * recurrenceRule;
@property (nonatomic, retain) NSString * reminder;
@property (nonatomic, retain) NSDate * start;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSString * updatedBy;
@property (nonatomic, retain) NSString * updatedOn;
@property (nonatomic, retain) NSString * venue;

@end
