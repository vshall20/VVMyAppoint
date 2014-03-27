//
//  AddEditAppoinmentViewController.m
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 10/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//



#import "AddEditAppoinmentViewController.h"
#import "CustomAppointmentTitleCell.h"
#import "CustomAppointmentFromToCell.h"
#import "CustomAppoinmentDescriptionCell.h"
#import "CustomHolidayTypeCell.h"
#import "CustomRecurringCell.h"
#import "MyDatePicker.h"
#import "DataEntity.h"
#import "DateFormatter.h"
#import "MyDropDownViewController.h"
#import "CustomVisibilityCell.h"
#import "MyReminderTableViewController.h"


@interface AddEditAppoinmentViewController ()<UITextFieldDelegate,MyDropDownViewControllerDelegate,UITextViewDelegate,ReminderTableViewControllerDelegate>
{
    MyDatePicker  *obj_MyDatePicker;
    UITextField   *tempTextField;
    UIToolbar     *keyboardToolbar;
    UIBarButtonItem *done;
    
}
@end

@implementation AddEditAppoinmentViewController

@synthesize model;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)initializeDataModel
{
    model.appId=@"";
    model.appointmentType=@"";
    model.caseId=@"";
    model.clientName=@"";
    model.createdBy=@"";
    model.createdDate = [NSDate date];
    model.appointmentDescription=@"";
    model.end=[NSDate date];;
    model.eventVisibility=@"";
    model.holidayType=@"";
    model.isAllDay=@"";
    model.matterFromDate=[NSDate date];
    model.matterStatus=@"";
    model.matterSummary=@"";
    model.matterToDate=[NSDate date];
    model.recurrenceParentId=@"";
    model.recurrenceRule=@"";
    model.reminder=@"";
    model.start=[NSDate date];;
    model.status=@"";
    model.subject=@"";
    model.updatedBy=@"";
    model.updatedOn=@"";
    model.venue=@"";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Test");
    
    //////// Initialise a model /////
    if (_entityData)   //// edit mode
    {
        model = _entityData;
        if (_mode == 2)
        {
            model.start = model.matterFromDate;
            model.end   = model.matterToDate;
            model.subject = @"";
            model.appointmentDescription = @"";
            model.reminder  = @"";
            model.venue     = @"";
            
        }
    }
    else{   /// add mode
        NSManagedObjectContext *context = [[[AppDelegate delegate] dataManager] managedObjectContext];
        model = (DataEntity *)[[NSManagedObject alloc]initWithEntity:[NSEntityDescription entityForName:kNameEntityName inManagedObjectContext:context] insertIntoManagedObjectContext:context];
        [self initializeDataModel];
        model.start = [NSDate date];
        model.end   = [NSDate date];
        model.appointmentType = _str_AppointmentType;
    }
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyDatePicker" owner:self options:nil];
    obj_MyDatePicker = (MyDatePicker *)[nib objectAtIndex:0];
    [obj_MyDatePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    if (keyboardToolbar == nil) {
        keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        [keyboardToolbar setBarStyle:UIBarStyleBlackTranslucent];
        
        done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(datePickerDoneButtonClicked:)];
        
        [keyboardToolbar setItems:[[NSArray alloc] initWithObjects:done, nil]];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSString *parameterName = @"";//[NSString stringWithFormat:@"%@parameter={\"search\":\"\",\"lawyerid\":\"%@\"}",[self servicePathForClientName],[[AppDelegate delegate] lawyerID]];
        [self getData:parameterName];
        
    });
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(NSString *)servicePathForClientName
{
//    /eLegalNet_AutoFilter_ClientName_CaseID?
    return @"ViewByCaseID_AutoFilter_ClientName_CaseID";
}


-(void)inComingResponse:(id)response forRequest:(NSString *)request
{
    if ([request isEqualToString:[self servicePathForClientName]]) {
        _dict_linkToCaseID = (NSMutableDictionary *)response;
    }
}

-(void)inComingError:(NSString *)errorMessage forRequest:(NSString *)request
{
    _dict_linkToCaseID = nil;
}

-(void)getData:(NSString *)parameterName
{
    Utility *util = [Utility sharedInstance];
    [util setDelegate:self];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"",@"search",[[AppDelegate delegate] lawyerID],@"id", nil];
    [util fetchDataWithMethodName:[self servicePathForClientName] andParameterDictionary:dict];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0: /// From Date
            return heightAppointmentTitleCell;
            break;
        case 1: /// From Date
            return heightAppointmentFromToCell;
            break;
        case 2: ///// To Date
        {
            if ([_str_AppointmentType isEqualToString:@"Matter"] || [_str_AppointmentType isEqualToString:@"Consulation"] || [_str_AppointmentType isEqualToString:@"Discussion"] || [_str_AppointmentType isEqualToString:@"Event"])
            {
                return heightAppointmentFromToCell;
            }
            else{
                return 0;
            }
        }
            break;
        case 3: //// Link to case id
        {
            if ([_str_AppointmentType isEqualToString:@"Matter"] || [_str_AppointmentType isEqualToString:@"Consulation"] || [_str_AppointmentType isEqualToString:@"Discussion"] || [_str_AppointmentType isEqualToString:@"Event"])
            {
                return heightAppointmentBasicCell;
            }
            else{
                return 0;
            }
        }
            break;
        case 4: //// select venue
        {
            if ([_str_AppointmentType isEqualToString:@"Matter"] || [_str_AppointmentType isEqualToString:@"Consulation"] || [_str_AppointmentType isEqualToString:@"Discussion"] || [_str_AppointmentType isEqualToString:@"Event"])
            {
                return heightAppointmentBasicCell;
            }
            else{
                return 0;
            }
        }
            
            break;
        case 5: /////  Visibility
        {
            if ([_str_AppointmentType isEqualToString:@"Event"])
            {
                return heightAppointmentVisibilityCell;
            }
            else{
                return 0;
            }
        }
        case 6: ////// Recurring
            if ([_str_AppointmentType isEqualToString:@"Birthday"] || [_str_AppointmentType isEqualToString:@"Anniversary"] || [_str_AppointmentType isEqualToString:@"Holiday"])
            {
                return heightAppoinmentRecurringCell;
            }
            else{
                return 0;
            }
            break;
        case 7: //// hoilday
            if ([_str_AppointmentType isEqualToString:@"Holiday"])
            {
                return heightAppointmentHoildayTypeCell;
            }
            else{
                return 0;
            }
            break;
        case 8: /////// Description
            if ([_str_AppointmentType isEqualToString:@"Matter"] || [_str_AppointmentType isEqualToString:@"Consulation"] || [_str_AppointmentType isEqualToString:@"Discussion"] || [_str_AppointmentType isEqualToString:@"Event"])
            {
                return heightAppoinmentDescriptionCell;
            }
            else{
                return 0;
            }
            break;
        case 9: /// From Reminder
            return heightAppointmentBasicCell;
            break;
        default:
            return heightAppointmentBasicCell;
            break;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0: ///// Title
        {
            CustomAppointmentTitleCell *cell = (CustomAppointmentTitleCell*) [tableView dequeueReusableCellWithIdentifier:appointmentTitleCell];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomAppointmentTitleCell" owner:self options:nil];
                cell = (CustomAppointmentTitleCell *)[nib objectAtIndex:0];
            }
            cell.txt_AppointmentTitle.delegate = self;
            if (model.subject)
            {
                cell.txt_AppointmentTitle.text = model.subject;
            }
            else{
                cell.txt_AppointmentTitle.text = @"";
            }
            cell.contentView.backgroundColor = [UIColor colorWithPatternImage:matterScreenBackGroundImage];
            return cell;
        }
            
        case 1: ///// From  Date
        {
            CustomAppointmentFromToCell *cell = (CustomAppointmentFromToCell*) [tableView dequeueReusableCellWithIdentifier:appointmentFromToCell];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomAppointmentFromToCell" owner:self options:nil];
                cell = (CustomAppointmentFromToCell *)[nib objectAtIndex:0];
            }
            cell.txt_Date.text = [[DateFormatter sharedDateFormatter] stringFromGivenDate:model.start];
            done.tag = 0;
            [cell.txt_Date setInputAccessoryView:keyboardToolbar];
            cell.txt_Date.tag = 100;
            cell.txt_Date.delegate = self;
            obj_MyDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
            [cell.txt_Date setInputView:obj_MyDatePicker];
            cell.contentView.backgroundColor = [UIColor colorWithPatternImage:matterScreenBackGroundImage];
            return cell;
        }
            break;
        case 2:  ////// To Date
        {
            CustomAppointmentFromToCell *cell = (CustomAppointmentFromToCell*) [tableView dequeueReusableCellWithIdentifier:appointmentFromToCell];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomAppointmentFromToCell" owner:self options:nil];
                cell = (CustomAppointmentFromToCell *)[nib objectAtIndex:0];
            }
            cell.txt_Date.text = [[DateFormatter sharedDateFormatter] stringFromGivenDate:model.end];
            cell.txt_Date.tag = 101;
            done.tag = 1;
            [cell.txt_Date setInputAccessoryView:keyboardToolbar];
            cell.txt_Date.delegate = self;
            obj_MyDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
            obj_MyDatePicker.minimumDate = model.start;
            [cell.txt_Date setInputView:obj_MyDatePicker];
            
            cell.lbl_Title.text = @"To";
            if ([_str_AppointmentType isEqualToString:@"Matter"] || [_str_AppointmentType isEqualToString:@"Consulation"] || [_str_AppointmentType isEqualToString:@"Discussion"] || [_str_AppointmentType isEqualToString:@"Event"])
            {
                cell.hidden = NO;
            }
            else{
                cell.hidden = YES;
                
            }
            cell.contentView.backgroundColor = [UIColor colorWithPatternImage:matterScreenBackGroundImage];
            return cell;
        }
            break;
        case 3:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:appointmentBasicCell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:appointmentBasicCell];
            }
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
            cell.textLabel.text = @"Link to case id";
            if (model.caseId)
            {
                cell.textLabel.text = [NSString stringWithFormat:@"Link to case id %@",model.caseId];
                //Invite Button
                [_delegate inviteButtonState:YES];
            }
            else
            {
                cell.textLabel.text = [NSString stringWithFormat:@"Link to case id "];
                [_delegate inviteButtonState:NO];
            }
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            if ([_str_AppointmentType isEqualToString:@"Matter"] || [_str_AppointmentType isEqualToString:@"Consulation"] || [_str_AppointmentType isEqualToString:@"Discussion"] || [_str_AppointmentType isEqualToString:@"Event"])
            {
                cell.hidden = NO;
            }
            else{
                cell.hidden = YES;
                
            }
            cell.contentView.backgroundColor = [UIColor colorWithPatternImage:matterScreenBackGroundImage];
            return cell;
        }
            break;
        case 4:   ///////// Venue
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:appointmentBasicCell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:appointmentBasicCell];
            }
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
            cell.textLabel.text = @"Select Venue";
            if (model.venue)
            {
                cell.textLabel.text = [NSString stringWithFormat:@"Select Venue %@",model.venue];
            }
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            if ([_str_AppointmentType isEqualToString:@"Matter"] || [_str_AppointmentType isEqualToString:@"Consulation"] || [_str_AppointmentType isEqualToString:@"Discussion"] || [_str_AppointmentType isEqualToString:@"Event"])
            {
                cell.hidden = NO;
            }
            else{
                cell.hidden = YES;
                
            }
            cell.contentView.backgroundColor = [UIColor colorWithPatternImage:matterScreenBackGroundImage];
            return cell;
        }
            break;
        case 5:
            
        {
            CustomVisibilityCell *cell = (CustomVisibilityCell*) [tableView dequeueReusableCellWithIdentifier:appointmentVisibilityCell];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomVisibilityCell" owner:self options:nil];
                cell = (CustomVisibilityCell *)[nib objectAtIndex:0];
            }
            [cell.btn_Private addTarget:self action:@selector(visibilityButtonSelected:) forControlEvents:UIControlEventTouchDragInside];
            [cell.btn_Public addTarget:self action:@selector(visibilityButtonSelected:) forControlEvents:UIControlEventTouchDragInside];
            if ([_str_AppointmentType isEqualToString:@"Event"])
            {
                cell.hidden = NO;
            }
            else{
                cell.hidden = YES;
            }
            cell.contentView.backgroundColor = [UIColor colorWithPatternImage:matterScreenBackGroundImage];
            return cell;
        }
            break;
        case 6:
        {
            CustomRecurringCell *cell = (CustomRecurringCell*) [tableView dequeueReusableCellWithIdentifier:appoinmentRecurringCell];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomRecurringCell" owner:self options:nil];
                cell = (CustomRecurringCell *)[nib objectAtIndex:0];
            }
            cell.userInteractionEnabled = NO;
            [cell.btn_Yes addTarget:self action:@selector(recurringButtonSelected:) forControlEvents:UIControlEventTouchDragInside];
            [cell.btn_No addTarget:self action:@selector(recurringButtonSelected:) forControlEvents:UIControlEventTouchDragInside];
            if ([_str_AppointmentType isEqualToString:@"Birthday"] || [_str_AppointmentType isEqualToString:@"Anniversary"] || [_str_AppointmentType isEqualToString:@"Holiday"])
            {
                cell.hidden = NO;
            }
            else{
                cell.hidden = YES;
            }
            cell.contentView.backgroundColor = [UIColor colorWithPatternImage:matterScreenBackGroundImage];
            
            return cell;
            
        }
            break;
        case 7:
        {
            CustomHolidayTypeCell *cell = (CustomHolidayTypeCell*) [tableView dequeueReusableCellWithIdentifier:appointmentHoildayTypeCell];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomHolidayTypeCell" owner:self options:nil];
                cell = (CustomHolidayTypeCell *)[nib objectAtIndex:0];
            }
            [cell.btn_Court addTarget:self action:@selector(holidayButtonSelected:) forControlEvents:UIControlEventTouchDragInside];
            [cell.btn_Chamber addTarget:self action:@selector(holidayButtonSelected:) forControlEvents:UIControlEventTouchDragInside];
            if ([_str_AppointmentType isEqualToString:@"Holiday"])
            {
                cell.hidden = NO;
            }
            else{
                cell.hidden = YES;
            }
            cell.contentView.backgroundColor = [UIColor colorWithPatternImage:matterScreenBackGroundImage];
            
            return cell;
            
        }
            break;
        case 8:
        {
            CustomAppoinmentDescriptionCell *cell = (CustomAppoinmentDescriptionCell*) [tableView dequeueReusableCellWithIdentifier:appoinmentDescriptionCell];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomAppoinmentDescriptionCell" owner:self options:nil];
                cell = (CustomAppoinmentDescriptionCell *)[nib objectAtIndex:0];
            }
            if (model.appointmentDescription) {
                cell.txt_Description.text = model.appointmentDescription;
            }
            cell.txt_Description.delegate = self;
            cell.txt_Description.tag = 107;
            if ([_str_AppointmentType isEqualToString:@"Matter"] || [_str_AppointmentType isEqualToString:@"Consulation"] || [_str_AppointmentType isEqualToString:@"Discussion"] || [_str_AppointmentType isEqualToString:@"Event"])
            {
                cell.hidden = NO;
            }
            else{
                cell.hidden = YES;
                
            }
            cell.contentView.backgroundColor = [UIColor colorWithPatternImage:matterScreenBackGroundImage];
            return cell;
        }
            break;
        case 9:
        {
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:appointmentBasicCell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:appointmentBasicCell];
            }
            cell.textLabel.text = @"Reminder";
            if (model.reminder)
            {
                cell.textLabel.text = [NSString stringWithFormat:@"Reminder Before %@",model.reminder];
            }
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            cell.contentView.backgroundColor = [UIColor colorWithPatternImage:matterScreenBackGroundImage];
            return cell;
            
            
        }
            break;
            
            
        default:
            break;
    }
    
    // Configure the cell...
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3)
    {
        [self showDropDownWithContentType:kShowAppointmentLinkedToCaseId andDataArray:nil andDictionary:[_dict_linkToCaseID objectForKey:@"data"]];
    }
    else if (indexPath.row == 4)
    {
        [self showDropDownWithContentType:kShowAppointmentSelectVenue];
    }
    else if (indexPath.row == 9)
    {
        [self showReminderViewController];
    }
}

-(void)showDropDownWithContentType:(NSString *)str_ContentType
{
    MyDropDownViewController *obj_MyDropDownViewController = [[MyDropDownViewController alloc] initWithNibName:@"MyDropDownViewController" bundle:nil];
    obj_MyDropDownViewController.str_ShowTableContent  = str_ContentType;
    obj_MyDropDownViewController.delegate = self;
    obj_MyDropDownViewController.view.frame = CGRectMake(0, self.view.frame.size.height-200,obj_MyDropDownViewController.view.frame.size.width,200);
    
    [self addChildViewController:obj_MyDropDownViewController];
    [self.view addSubview:obj_MyDropDownViewController.view];
    [obj_MyDropDownViewController didMoveToParentViewController:self];
    
}

-(void)showDropDownWithContentType:(NSString *)str_ContentType andDataArray :(NSArray *)array andDictionary:(NSMutableDictionary *)dict
{
    MyDropDownViewController *obj_MyDropDownViewController = [[MyDropDownViewController alloc] initWithNibName:@"MyDropDownViewController" bundle:nil];
    obj_MyDropDownViewController.str_ShowTableContent  = str_ContentType;
    obj_MyDropDownViewController.delegate = self;
    obj_MyDropDownViewController.dataArray = array;
    obj_MyDropDownViewController.dict_linkToCaseID = dict;
//    obj_MyDropDownViewController.view.frame = CGRectMake(0, self.view.frame.size.height-200,obj_MyDropDownViewController.view.frame.size.width,200);
    
//    [self addChildViewController:obj_MyDropDownViewController];
//    [self.view addSubview:obj_MyDropDownViewController.view];
//    [obj_MyDropDownViewController didMoveToParentViewController:self];

    [self.navigationController pushViewController:obj_MyDropDownViewController animated:YES];
}


#pragma mark - MyDropDownViewController Delegate
-(void)selectedDropDownListTableWithContent:(NSString *)str_Content contentType:(NSString *)str_ContentType
{
    if ([str_ContentType isEqualToString:kShowCaseId])
    {
        model.caseId =  str_Content;//[self idForName:str_Content];
    }
    else{
        model.venue = str_Content;
    }
    [self.tableView reloadData];
}


-(NSString *)idForName:(NSString *)str
{//
    int index = [[[_dict_linkToCaseID objectForKey:@"data"] objectForKey:@"ja_CLIENTFULLNAME"] indexOfObject:str];
    return [[[_dict_linkToCaseID objectForKey:@"data"] objectForKey:@"ja_CL_Id"] objectAtIndex:index];
}


-(void)showReminderViewController
{
    MyReminderTableViewController *obj_ReminderTableViewController = [[MyReminderTableViewController alloc] initWithNibName:@"MyReminderTableViewController" bundle:nil];
    
    obj_ReminderTableViewController.myDelegate = self;
    obj_ReminderTableViewController.view.frame = CGRectMake(0, self.view.frame.size.height-100,obj_ReminderTableViewController.view.frame.size.width,100);
    
    [self addChildViewController:obj_ReminderTableViewController];
    [self.view addSubview:obj_ReminderTableViewController.view];
    [obj_ReminderTableViewController didMoveToParentViewController:self];
}
-(void)reminderSelectedWithValue:(NSString *)reminderValue
{
    model.reminder = reminderValue;
    [self.tableView reloadData];
}
#pragma mark - Text Field Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    tempTextField = textField;
    if (model.start) {
        obj_MyDatePicker.minimumDate = model.start;
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]) {
        model.appointmentDescription = textView.text;
        [textView resignFirstResponder];
        return NO;
    }
    else if (range.length > text.length) {
        return YES;
    } else if ([[textView text] length] + text.length > 40) {
        return NO;
    }
    
    return YES;
}

#pragma mark ---

#pragma mark - Date Picker
-(void)datePickerValueChanged:(UIDatePicker*)picker
{
    tempTextField.text = [NSString stringWithFormat:@"%@",picker.date];
    [self setDateAndTimeWithString:[NSString stringWithFormat:@"%@",picker.date] resignDatePicker:NO tagValue:tempTextField.tag];
}
-(void)datePickerDoneButtonClicked:(id)sender
{
    NSString *str_TempValue;
    if ([sender tag] == 0)
    {
        str_TempValue = [[DateFormatter sharedDateFormatter] stringFromGivenDate:model.start];
    }
    else{
        str_TempValue = [[DateFormatter sharedDateFormatter] stringFromGivenDate:model.end];
    }
    [self setDateAndTimeWithString:str_TempValue resignDatePicker:YES tagValue:[sender tag]];
    
}
-(void)setDateAndTimeWithString:(NSString *)dateTime resignDatePicker:(BOOL)bln_Value tagValue:(int)tagValue;
{
    NSIndexPath  *myIndexPath;
    int cellTag = tagValue - 100;
    
    
    NSDate *date = [[NSDate alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    //                                   right here    ^
    
    date = [dateFormatter dateFromString:dateTime];
    
    myIndexPath = [NSIndexPath indexPathForRow:cellTag inSection:0];
    CustomAppointmentFromToCell *cell = (CustomAppointmentFromToCell *)[self.tableView cellForRowAtIndexPath:myIndexPath];
    if (cellTag == 0)
    {
        model.start = nil;
        model.start = date;
        cell.txt_Date.text = [[DateFormatter sharedDateFormatter] stringFromGivenDate:model.start];
    }
    else{
        model.end = nil;
        model.end = date;
        cell.txt_Date.text = [[DateFormatter sharedDateFormatter] stringFromGivenDate:model.end];
        
    }
    if (bln_Value)
    {
        [tempTextField resignFirstResponder];
        myIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:myIndexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }
}
#pragma mark - Button Action
-(void)recurringButtonSelected:(id)sender
{
    if ([sender tag] == 0)
    {
        model.recurrenceRule = @"Yes";
    }
    else{
        model.recurrenceRule = @"No";
    }
}
-(void)visibilityButtonSelected:(id)sender
{
    if ([sender tag] == 0)
    {
        model.eventVisibility = @"private";
    }
    else{
        model.eventVisibility = @"public";
    }
    
}
-(void)holidayButtonSelected:(id)sender
{
    if ([sender tag] == 0)
    {
        model.holidayType = @"court";
    }
    else{
        model.holidayType = @"chamber";
    }
    
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Table view delegate
 
 // In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Navigation logic may go here, for example:
 // Create the next view controller.
 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
 
 // Pass the selected object to the new view controller.
 
 // Push the view controller.
 [self.navigationController pushViewController:detailViewController animated:YES];
 }
 
 */

@end
