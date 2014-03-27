    //
    //  NewAppointmentViewController.m
    //  MyNewAppointmentProject
    //
    //  Created by Vishnu Gupta on 05/03/14.
    //  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
    //

#import "NewAppointmentViewController.h"
#import "MyNavigationBar.h"
#import "MyTabBar.h"
#import "AddEditAppoinmentViewController.h"
#import "MyAppoinmentSaveCancelView.h"
#import "MyDropDownViewController.h"
#import "DataEntityValidator.h"
#import "SaveAppointmentRequest.h"
#import "SaveAppointmentResponse.h"
#import "DateFormatter.h"
#import "DataEntity.h"




@interface NewAppointmentViewController ()<MyDropDownViewControllerDelegate,UtilityDelegate>

{
    MyNavigationBar  *obj_MyNavigationBar;
    MyTabBar         *obj_MyTabBar;
    NSArray          *nib;
    MyAppoinmentSaveCancelView *obj_SaveCancelView;
    AddEditAppoinmentViewController *obj_addEditViewController;
}
@end

@implementation NewAppointmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    nib = [[NSBundle mainBundle] loadNibNamed:@"myNavigationBar" owner:self options:nil];
    
    obj_MyNavigationBar = (MyNavigationBar *)[nib objectAtIndex:0];
    obj_MyNavigationBar.myNavigationItem.title = @"New Appointment";
        //obj_MyNavigationBar.frame = CGRectMake(0, 0, obj_MyTabBar.frame.size.width, obj_MyTabBar.frame.size.height);
    
    [self.view addSubview:obj_MyNavigationBar];
        // Do any additional setup after loading the view from its nib.
    if (nib)
    {
        nib = nil;
    }
    nib = [[NSBundle mainBundle] loadNibNamed:@"MyAppoinmentSaveCancelView" owner:self options:nil];
    
    obj_SaveCancelView = (MyAppoinmentSaveCancelView *)[nib objectAtIndex:0];
    obj_SaveCancelView.frame = CGRectMake(0,obj_MyNavigationBar.frame.size.height, obj_SaveCancelView.frame.size.width, obj_SaveCancelView.frame.size.height);
    [obj_SaveCancelView.txt_AppointmentType setEnabled:NO];
    [obj_SaveCancelView.btn_DropDownList addTarget:self action:@selector(dropDownListClicked:) forControlEvents:UIControlEventTouchUpInside];
    [obj_SaveCancelView.btn_Save addTarget:self action:@selector(saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [obj_SaveCancelView.btn_Invite addTarget:self action:@selector(inviteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [obj_SaveCancelView.btn_Invite setEnabled:NO];
    
    [obj_SaveCancelView.btn_Cancel
     addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:obj_SaveCancelView];
    
    
    nib = [[NSBundle mainBundle] loadNibNamed:@"MyTabBar" owner:self options:nil];
    
    obj_MyTabBar = (MyTabBar *)[nib objectAtIndex:0];
    obj_MyTabBar.frame = CGRectMake(0, self.view.frame.size.height-obj_MyTabBar.frame.size.height, obj_MyTabBar.frame.size.width, obj_MyTabBar.frame.size.height);
    obj_MyTabBar.delegate = self;
    [self.view addSubview:obj_MyTabBar];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_entityData && _mode > 0)
    {
        obj_SaveCancelView.txt_AppointmentType.text  = _entityData.appointmentType;
        [self addEditViewControllerWithAppointmentType:_entityData.appointmentType withDataEntity:_entityData setMode:_mode];
    }
    
}
#pragma mark - dropDownListClicked
-(void)dropDownListClicked:(id)sender
{
    if (obj_addEditViewController)
    {
        [self removeAddEditViewController];
    }
    [obj_SaveCancelView.btn_DropDownList setEnabled:NO];
    MyDropDownViewController *obj_MyDropDownViewController = [[MyDropDownViewController alloc] initWithNibName:@"MyDropDownViewController" bundle:nil];
    obj_MyDropDownViewController.str_ShowTableContent  = kShowAppointmentType;
    obj_MyDropDownViewController.delegate = self;
    obj_MyDropDownViewController.view.frame = CGRectMake(10, obj_SaveCancelView.frame.size.height+obj_MyNavigationBar.frame.size.height,obj_MyDropDownViewController.view.frame.size.width-20,200);
    
    [self addChildViewController:obj_MyDropDownViewController];
    [self.view addSubview:obj_MyDropDownViewController.view];
    [obj_MyDropDownViewController didMoveToParentViewController:self];
}
#pragma mark - Tab Bar Delegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;
{
        //    if (item.tag != 0)
        //    {
        //    NewAppointmentViewController *obj_New = [[NewAppointmentViewController alloc] initWithNibName:@"NewAppointmentViewController" bundle:nil];
        //    [self.navigationController pushViewController:obj_New animated:YES];
        //    NSLog(@"item %d",item.tag);
        //    }
}
#pragma mark - MyDropDownViewController Delegate
-(void)selectedDropDownListTableWithContent:(NSString *)str_Content contentType:(NSString *)str_ContentType
{
    [obj_SaveCancelView.btn_DropDownList setEnabled:YES];
    if ([str_ContentType isEqualToString:kShowAppointmentType])
    {
        obj_SaveCancelView.txt_AppointmentType.text  = str_Content;
    }
    [self addEditViewControllerWithAppointmentType:str_Content withDataEntity:nil setMode:_mode];
    
    
}
-(void)addEditViewControllerWithAppointmentType:(NSString *)appointmentType withDataEntity:(DataEntity *)myEntityData setMode:(int)modeValue
{
    if (obj_addEditViewController)
    {
        [self removeAddEditViewController];
    }
    if (!obj_addEditViewController)
    {
        obj_addEditViewController = [[AddEditAppoinmentViewController alloc] initWithNibName:@"AddEditAppoinmentViewController" bundle:nil];
        float yOrigin = obj_MyNavigationBar.frame.size.height + obj_SaveCancelView.frame.size.height;
        obj_addEditViewController.str_AppointmentType = appointmentType;
        obj_addEditViewController.entityData          = myEntityData;
        obj_addEditViewController.mode                = _mode;
        obj_addEditViewController.delegate = self;
        float viewHeight = obj_MyNavigationBar.frame.size.height + obj_SaveCancelView.frame.size.height + obj_MyTabBar.frame.size.height;
        obj_addEditViewController.view.frame = CGRectMake(0,yOrigin, self.view.frame.size.width, self.view.frame.size.height-viewHeight);
        [self addChildViewController:obj_addEditViewController];
        [self.view addSubview:obj_addEditViewController.view];
        [obj_addEditViewController didMoveToParentViewController:self];
        
    }
    
}

#pragma mark AddEditViewDelegate

-(void)inviteButtonState:(BOOL) state
{
    return [obj_SaveCancelView.btn_Invite setEnabled:state];
}

#pragma mark -

-(void)removeAddEditViewController
{
    if (obj_addEditViewController)
    {
        [obj_addEditViewController didMoveToParentViewController:nil];
        [obj_addEditViewController.view removeFromSuperview];
        [obj_addEditViewController removeFromParentViewController];
        obj_addEditViewController = nil;
    }
}
#pragma mark - Button Action

-(void)inviteButtonClicked:(id)sender
{
    
}
-(void)basicButtonClicked:(id)sender
{
    
}
-(void)saveButtonClicked:(id)sender
{
        //validate
    obj_addEditViewController.model.subject = @"Test";
//    obj_addEditViewController.model.caseId  = @"fff83d8b-3c03-429d-81d8-f0a7a6064e19";
    [self populateSaveDictionary];
    DataEntityValidator *validator = [[DataEntityValidator alloc]initWithEntity:obj_addEditViewController.model];
    if ([validator isValid]) {
            //send request
        if (_mode == AppointmentModeNew)
        {
            [self saveAppointment];
        }
        else if (_mode == AppointmentModeEdit)
        {
            [_saveDictionary setObject:obj_addEditViewController.model.appId forKey:@"appointmentid"];
            [self saveAppointment];
                // edit
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oops !" message:@"Enter all mandatory fields." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
}

-(void)populateSaveDictionary
{
    _saveDictionary =  [[NSMutableDictionary alloc]initWithObjectsAndKeys:obj_addEditViewController.model.subject,@"subject",
                                   [[DateFormatter sharedDateFormatter] stringFromGivenDate:obj_addEditViewController.model.start], @"start",
                                   [[DateFormatter sharedDateFormatter] stringFromGivenDate:obj_addEditViewController.model.end], @"end",
                                   obj_addEditViewController.model.appointmentType, @"appointmenttype",
                                   obj_addEditViewController.model.clientName, @"clientname",
                                   obj_addEditViewController.model.caseId, @"caseid",
                                   obj_addEditViewController.model.venue, @"venue",
                                   obj_addEditViewController.model.reminder, @"reminder",
                                   obj_addEditViewController.model.recurrenceParentId, @"recurrenceparentid",
                                   obj_addEditViewController.model.recurrenceRule, @"recurrencerule",
                                   obj_addEditViewController.model.status, @"status",
                                   obj_addEditViewController.model.eventVisibility, @"eventvisibility",
                                   obj_addEditViewController.model.createdBy, @"createdby",
                                   obj_addEditViewController.model.isAllDay, @"isallday",
                                   obj_addEditViewController.model.holidayType, @"holidaytype",
                                   obj_addEditViewController.model.matterStatus, @"matterstatus",
                                   obj_addEditViewController.model.matterSummary, @"mattersummary",
                                   [[DateFormatter sharedDateFormatter] stringFromGivenDate:obj_addEditViewController.model.matterFromDate], @"matterfromdate",
                                   obj_addEditViewController.model.updatedOn, @"updatedon",
                                   [[DateFormatter sharedDateFormatter] stringFromGivenDate:obj_addEditViewController.model.matterToDate], @"mattertodate",
                                   obj_addEditViewController.model.updatedBy, @"updatedby",
                                   @"1", @"roleid",
                                   @"", @"acfilterid",
                                   @"", @"acroleid",
                                   @"", @"acappointmentstatus",
                                   nil];
}


-(NSString *)servicePath
{
    if (_mode == AppointmentModeNew) {
        return @"Appointment_Save";
    }
    if (_mode == AppointmentModeEdit) {
        return @"Appointment_Update";
    }
    return nil;
}

-(void)saveAppointment
{
    
        //    SaveAppointmentRequest *request = [[SaveAppointmentRequest alloc]initWithDataEntity:obj_addEditViewController.model];
        //    NSMutableDictionary *dict = [request saveRequest];
        //    SaveAppointmentResponse *response = [[SaveAppointmentResponse alloc]initWithDictionary:dict];
        //    [response parseAndSave];
    
    
    
    
    Utility *util = [Utility sharedInstance];
    [util setDelegate:self];
    [util fetchDataWithMethodName:[self servicePath] andParameterDictionary:_saveDictionary];
    
    
}


-(void)cancelButtonClicked:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark - Utility Delegate
-(void)inComingResponse:(id)response forRequest:(NSString *)request
{
    
}

-(void)inComingError:(NSString *)errorMessage forRequest:(NSString *)request
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

@end
