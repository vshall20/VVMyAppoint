//
//  Processor.m
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "Processor.h"
#import "DataManager.h"
#import "DateFormatter.h"
#import "LawyerEntity.h"

@implementation Processor

@synthesize dictionary,dataEntityArray;

-(id)initWithDictionary:(NSMutableDictionary *)dict
{
    self = [super init];
    if (self) {
        self = [[Processor alloc]init];
        dictionary = dict;
    }
    return self;
}

-(void)parseDictionaryAndSaveLawyerData
{
    DataManager *dataManager = [[AppDelegate delegate] dataManager];
    if (dictionary) {
        NSMutableDictionary *dict = [dictionary objectForKey:@"data"];
        LawyerEntity *entity = [NSEntityDescription insertNewObjectForEntityForName:kNameLawyerEntityName inManagedObjectContext:[dataManager bgManagedObjectContext]];
        entity.chamberID = [dict valueForKey:@"chamberid"];
        entity.lawyerID = [dict valueForKey:@"id"];
        entity.emailAddress = [dict valueForKey:@"emailadd"];
        entity.firstName = [dict valueForKey:@"firstname"];
        entity.lastName = [dict valueForKey:@"lastname"];
        entity.roleName = [dict valueForKey:@"rolename"];
        entity.loginStatus = [dict valueForKey:@"login_status"];
        entity.roleId = [dict valueForKey:@"roleid"];
        [dataManager saveBGContext];
    }
}

-(void)parseDictionaryAndSave
{
    DataManager *dataManager = [[AppDelegate delegate] dataManager];
    if (dictionary) {
        NSArray *tempArray = [dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_AppId]];
        for (int i=0; i<[tempArray count]; i++) {
            DataEntity *entity = [NSEntityDescription insertNewObjectForEntityForName:kNameEntityName inManagedObjectContext:[dataManager bgManagedObjectContext]];
            
            entity.appId = [(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_AppId]] objectAtIndex:i];
            entity.appointmentType= [(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_AppointmentType]] objectAtIndex:i];
            entity.caseId = [(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_CaseID]] objectAtIndex:i];
            entity.clientName = [(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_ClientName]] objectAtIndex:i];
            entity.createdBy = [(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_CreatedBy]] objectAtIndex:i];
            entity.createdDate = [[DateFormatter sharedDateFormatter]dateFromParamString:[(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_CreatedDate]] objectAtIndex:i]];
            entity.appointmentDescription = [(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_Description]] objectAtIndex:i];
            entity.end = [[DateFormatter sharedDateFormatter]dateFromParamString:[(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_End]] objectAtIndex:i]];
            entity.eventVisibility = [(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_EventVisibility]] objectAtIndex:i];
            entity.holidayType = [(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_HolidayType]] objectAtIndex:i];
            entity.isAllDay = [(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_ISAllDay]] objectAtIndex:i];
            entity.matterFromDate = [[DateFormatter sharedDateFormatter]dateFromParamString:[(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_MatterFromDate]] objectAtIndex:i]];
            entity.matterStatus = [(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_MatterStatus]] objectAtIndex:i];
            entity.matterSummary = [(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_MatterSummary]] objectAtIndex:i];
            entity.matterToDate = [[DateFormatter sharedDateFormatter]dateFromParamString:[(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_MatterToDate]] objectAtIndex:i]];
            entity.recurrenceParentId = [(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_RecurrenceParentId]] objectAtIndex:i];
            entity.recurrenceRule = [(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_RecurrenceRule]] objectAtIndex:i];
            entity.reminder = [(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_Reminder]] objectAtIndex:i];
            entity.start = [[DateFormatter sharedDateFormatter]dateFromParamString:[(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_Start]] objectAtIndex:i]];
//            entity.status = [(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_Status]] objectAtIndex:i];
            entity.subject = [(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_Subject]] objectAtIndex:i];
            entity.updatedBy = [(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_UpdatedBy]] objectAtIndex:i];
            entity.updatedOn = [(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_UpdatedOn]] objectAtIndex:i];
            entity.venue = [(NSArray *)[dictionary valueForKeyPath:[NSString stringWithFormat:@"data.%@",kNameja_Venue]] objectAtIndex:i];
            
            [dataManager saveBGContext];
            [dataManager performFetch];
        }
        
    }
}

@end
