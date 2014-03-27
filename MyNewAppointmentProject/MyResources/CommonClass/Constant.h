//
//  Constant.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 04/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#ifndef MyNewAppointmentProject_Constant_h
#define MyNewAppointmentProject_Constant_h

#define myLeftRightTableBackGroundColor [UIColor colorWithRed:73.0/255.0 green:73.0/255.0 blue:73.0/255.0 alpha:0.8]
#define myLeftRightTableCellTextColor [UIColor colorWithRed:86.0/255.0 green:152.0/255.0 blue:76.0/255.0 alpha:1.0]

#define kShowAppointmentType             @"ShowAppointmentType"
#define kShowAppointmentLinkedToCaseId   @"ShowAppointmentLinkedToCaseId"
#define kShowCaseId                      @"ShowCaseId"
#define kShowAppointmentSelectVenue      @"ShowAppointmentSelectVenue"

#define kNameEntityName             @"DataEntity"
#define kNameLawyerEntityName       @"LawyerEntity"

#define kNameja_AllStartDate        @"ja_AllStartDate"
#define kNameja_AppId               @"ja_AppId"
#define kNameja_AppointmentType     @"ja_AppointmentType"
#define kNameja_CaseID              @"ja_CaseID"
#define kNameja_ClientName          @"ja_ClientName"
#define kNameja_CreatedBy           @"ja_CreatedBy"
#define kNameja_CreatedDate         @"ja_CreatedDate"
#define kNameja_Description         @"ja_Description"
#define kNameja_End                 @"ja_End"
#define kNameja_EventVisibility     @"ja_EventVisibility"
#define kNameja_HolidayType         @"ja_HolidayType"
#define kNameja_ISAllDay            @"ja_ISAllDay"
#define kNameja_MatterFromDate      @"ja_MatterFromDate"
#define kNameja_MatterStatus        @"ja_MatterStatus"
#define kNameja_MatterSummary       @"ja_MatterSummary"
#define kNameja_MatterToDate        @"ja_MatterToDate"
#define kNameja_RecurrenceParentId  @"ja_RecurrenceParentId"
#define kNameja_RecurrenceRule      @"ja_RecurrenceRule"
#define kNameja_Reminder            @"ja_Reminder"
#define kNameja_Start               @"ja_Start"
#define kNameja_Status              @"ja_Status"
#define kNameja_Subject             @"ja_Subject"
#define kNameja_UpdatedBy           @"ja_UpdatedBy"
#define kNameja_UpdatedOn           @"ja_UpdatedOn"
#define kNameja_Venue               @"ja_Venue"
#define kNameja_success             @"success"

typedef enum {
    AppointmentTypeMatter =0,
    AppointmentTypeConsultation,
    AppointmentTypeDiscussion,
    AppointmentTypeEvent,
    AppointmentTypeBirthday,
    AppointmentTypeAnniversary,
    AppointmentTypeHoliday,
    AppointmentTypeOthers,
    AppointmentTypeAll
} AppointmentType;

typedef enum {
    AppointmentModeNew =0,
    AppointmentModeEdit,
    AppointmentModeAddMatter
} AppointmentMode;


#define appointmentBasicCell        @"appointmentBasicCell"
#define appointmentTitleCell        @"appointmentTitleCell"
#define appointmentFromToCell       @"appointmentFromToCell"
#define appoinmentDescriptionCell   @"appoinmentDescriptionCell"
#define appoinmentRecurringCell     @"appoinmentRecurringCell"
#define appointmentHoildayTypeCell  @"appointmentHoildayTypeCell"
#define appointmentVisibilityCell   @"appointmentVisibilityCell"

#define heightAppointmentTitleCell         50.0
#define heightAppointmentFromToCell         65.0
#define heightAppoinmentDescriptionCell     150.0
#define heightAppoinmentRecurringCell       55.0
#define heightAppointmentHoildayTypeCell    55.0
#define heightAppointmentBasicCell          44.0
#define heightAppointmentVisibilityCell     55.0

#define matterScreenBackGroundImage   [UIImage imageNamed:@"Background.png"]
#endif
