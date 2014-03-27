//
//  SaveAppointmentRequest.m
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 22/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "SaveAppointmentRequest.h"
#import "DateFormatter.h"

@implementation SaveAppointmentRequest

-(id)initWithDataEntity:(DataEntity *)dataEntity
{
    self = [super init];
    if (self) {
        _entity = dataEntity;
    }
    return self;
}

-(NSString *)servicePath
{
    if (_entity.appId.length>0) {
        return @"/Appointment_Update?";
    }
    else
    {
        return @"/Appointment_Save?";
    }
}

-(NSMutableDictionary *)saveRequest
{
    NSString *parameterName = [NSString stringWithFormat:@"%@parameter={\"subject\":\"%@\",\"start\":\"%@\",\"end\":\"%@\",\"appointmenttype\":\"%@\",\"clientname\",\"%@\",\"caseid\":\"%@\",\"description\":\"%@\",\"venue\":\"%@\",\"reminder\":\"%@\",\"recurrencerule\":\"%@\",\"recurrenceparentid\":\"%@\",\"status\":\"%@\",\"eventvisibility\":\"%@\",\"createdby\":\"%@\",\"createddate\":\"%@\",\"isallday\":\"%@\",\"holidaytype\":\"%@\",\"matterstatus\":\"%@\",\"mattersummary\":\"%@\",\"matterfromdate\":\"%@\",\"mattertodate\":\"%@\",\"updatedby\":\"%@\",\"updatedon\":\"%@\",\"roleid\":\"%@\",\"acfilterid\":\"%@\",\"acroleid\":\"%@\",\"acappointmentstatus\":\"%@\"}",[self servicePath],_entity.subject,[[DateFormatter sharedDateFormatter] stringFromGivenDate:_entity.start],[[DateFormatter sharedDateFormatter] stringFromGivenDate:_entity.end],_entity.appointmentType,_entity.clientName,_entity.caseId,_entity.description,_entity.venue,_entity.reminder,_entity.recurrenceRule,_entity.recurrenceParentId,_entity.status,_entity.eventVisibility,_entity.createdBy,[[DateFormatter sharedDateFormatter] stringFromGivenDate:_entity.createdDate],_entity.isAllDay,_entity.holidayType,_entity.matterStatus,_entity.matterSummary,[[DateFormatter sharedDateFormatter] stringFromGivenDate:_entity.matterFromDate],[[DateFormatter sharedDateFormatter] stringFromGivenDate:_entity.matterToDate],_entity.updatedBy,_entity.updatedOn,@"roleid",@"acfilterid",@"acroleid",@"acappointmentstatus"];
    
    
    NSMutableDictionary *jsonObject = [[Utility sharedInstance] fetchData:parameterName];
    
    return jsonObject;
    
}

@end
