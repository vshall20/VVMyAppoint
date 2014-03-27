//
//  MatterSummaryViewController.m
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 19/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "MatterSummaryViewController.h"
#import "MyAppoinmentSaveCancelView.h"
#import "MyNavigationBar.h"
#import "MyTabBar.h"
#import "CustomAppointmentTitleCell.h"
#import "CustomAppoinmentDescriptionCell.h"
#import "CustomAppointmentFromToCell.h"
#import "DateFormatter.h"
#import "MyDatePicker.h"
#import "CustomCretaeNewMatter.h"
#import "NewAppointmentViewController.h"

@interface MatterSummaryViewController ()<UITabBarDelegate,UITextFieldDelegate,UITextViewDelegate>

{
    MyNavigationBar  *obj_MyNavigationBar;
    MyTabBar         *obj_MyTabBar;
    MyAppoinmentSaveCancelView *obj_SaveCancelView;
    NSArray *nib;
    
    MyDatePicker  *obj_MyDatePicker;
    UITextField   *tempTextField;
    UIToolbar     *keyboardToolbar;
    UIBarButtonItem *done;

}
@end

@implementation MatterSummaryViewController
@synthesize model;

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
    // Do any additional setup after loading the view from its nib.
    
    nib = [[NSBundle mainBundle] loadNibNamed:@"myNavigationBar" owner:self options:nil];
    
    obj_MyNavigationBar = (MyNavigationBar *)[nib objectAtIndex:0];
    obj_MyNavigationBar.myNavigationItem.title = @"Matter Summary";
    //obj_MyNavigationBar.frame = CGRectMake(0, 0, obj_MyTabBar.frame.size.width, obj_MyTabBar.frame.size.height);
    
    [self.view addSubview:obj_MyNavigationBar];

    
    nib = [[NSBundle mainBundle] loadNibNamed:@"MyAppoinmentSaveCancelView" owner:self options:nil];
    
    obj_SaveCancelView = (MyAppoinmentSaveCancelView *)[nib objectAtIndex:0];
    obj_SaveCancelView.frame = CGRectMake(0,obj_MyNavigationBar.frame.size.height, obj_SaveCancelView.frame.size.width,35);
    
    obj_SaveCancelView.lbl_Title.text = @"Matter Summary";
    obj_SaveCancelView.txt_AppointmentType.alpha = 0.0;
    obj_SaveCancelView.btn_DropDownList.alpha    = 0.0;
    obj_SaveCancelView.btn_Invite.alpha = 0.0;
    obj_SaveCancelView.btn_Basic.alpha  = 0.0;
    [obj_SaveCancelView.btn_Save addTarget:self action:@selector(saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
     [obj_SaveCancelView.btn_Cancel
     addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:obj_SaveCancelView];
    
    nib = [[NSBundle mainBundle] loadNibNamed:@"MyTabBar" owner:self options:nil];
    
    obj_MyTabBar = (MyTabBar *)[nib objectAtIndex:0];
    obj_MyTabBar.frame = CGRectMake(0, self.view.frame.size.height-obj_MyTabBar.frame.size.height, obj_MyTabBar.frame.size.width, obj_MyTabBar.frame.size.height);
    obj_MyTabBar.delegate = self;
    [self.view addSubview:obj_MyTabBar];
    
    nib = [[NSBundle mainBundle] loadNibNamed:@"MyDatePicker" owner:self options:nil];
    obj_MyDatePicker = (MyDatePicker *)[nib objectAtIndex:0];
    [obj_MyDatePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    if (keyboardToolbar == nil) {
        keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        [keyboardToolbar setBarStyle:UIBarStyleBlackTranslucent];
        
        done = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(datePickerDoneButtonClicked:)];
        
        [keyboardToolbar setItems:[[NSArray alloc] initWithObjects:done, nil]];
    }
     _tbl_MatterSummary.backgroundColor = [UIColor colorWithPatternImage:matterScreenBackGroundImage];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tbl_MatterSummary reloadData];
    CGRect myFrame      = _tbl_MatterSummary.frame;
    myFrame.size.height = self.view.frame.size.height-obj_MyNavigationBar.frame.size.height+obj_SaveCancelView.frame.size.height+obj_MyTabBar.frame.size.height;
    myFrame.origin.y =obj_MyNavigationBar.frame.size.height+obj_SaveCancelView.frame.size.height;
    _tbl_MatterSummary.frame = myFrame;
}
#pragma mark - Table view data source
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* customView = nil;
    return customView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0: /// Select Status
            return heightAppointmentTitleCell;
            break;
        case 1: /// Title
            return heightAppoinmentDescriptionCell;
            break;
        case 2: /// From
            return heightAppointmentFromToCell;
            break;
        case 3: /// To
            return heightAppointmentFromToCell;
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
                nib = [[NSBundle mainBundle] loadNibNamed:@"CustomAppointmentTitleCell" owner:self options:nil];
                cell = (CustomAppointmentTitleCell *)[nib objectAtIndex:0];
            }
            cell.txt_AppointmentTitle.delegate = self;
            cell.txt_AppointmentTitle.text     = model.matterStatus;
            cell.contentView.backgroundColor = [UIColor colorWithPatternImage:matterScreenBackGroundImage];
            return cell;
        }
        case 1:
        {
            CustomAppoinmentDescriptionCell *cell = (CustomAppoinmentDescriptionCell*) [tableView dequeueReusableCellWithIdentifier:appoinmentDescriptionCell];
            if (cell == nil)
            {
                nib = [[NSBundle mainBundle] loadNibNamed:@"CustomAppoinmentDescriptionCell" owner:self options:nil];
                cell = (CustomAppoinmentDescriptionCell *)[nib objectAtIndex:0];
            }
            if (model.appointmentDescription) {
                cell.txt_Description.text = model.matterSummary;
            }
            cell.txt_Description.delegate = self;
            cell.txt_Description.tag = 107;
            cell.contentView.backgroundColor = [UIColor colorWithPatternImage:matterScreenBackGroundImage];
                      return cell;

        }
            break;
            
        case 2: ///// From  Date
        {
            CustomAppointmentFromToCell *cell = (CustomAppointmentFromToCell*) [tableView dequeueReusableCellWithIdentifier:appointmentFromToCell];
            if (cell == nil)
            {
                nib = [[NSBundle mainBundle] loadNibNamed:@"CustomAppointmentFromToCell" owner:self options:nil];
                cell = (CustomAppointmentFromToCell *)[nib objectAtIndex:0];
            }
            cell.txt_Date.text = [[DateFormatter sharedDateFormatter] stringFromGivenDate:model.matterFromDate];
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
        case 3:  ////// To Date
        {
            CustomAppointmentFromToCell *cell = (CustomAppointmentFromToCell*) [tableView dequeueReusableCellWithIdentifier:appointmentFromToCell];
            if (cell == nil)
            {
                nib = [[NSBundle mainBundle] loadNibNamed:@"CustomAppointmentFromToCell" owner:self options:nil];
                cell = (CustomAppointmentFromToCell *)[nib objectAtIndex:0];
            }
            cell.txt_Date.text = [[DateFormatter sharedDateFormatter] stringFromGivenDate:model.matterToDate];
            cell.txt_Date.tag = 101;
            done.tag = 1;
            [cell.txt_Date setInputAccessoryView:keyboardToolbar];
            cell.txt_Date.delegate = self;
            obj_MyDatePicker.datePickerMode = UIDatePickerModeDateAndTime;
            obj_MyDatePicker.minimumDate = model.start;
            [cell.txt_Date setInputView:obj_MyDatePicker];
            
            cell.lbl_Title.text = @"To";
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
    CustomAppointmentFromToCell *cell = (CustomAppointmentFromToCell *)[_tbl_MatterSummary cellForRowAtIndexPath:myIndexPath];
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
        [_tbl_MatterSummary scrollToRowAtIndexPath:myIndexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }
}

#pragma mark - Text Field Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if([text isEqualToString:@"\n"]) {
        model.matterSummary = textView.text;
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

-(void)saveButtonClicked:(id)sender
{
    [self createNewMatterAskingScreen];
}
-(void)cancelButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)goToNewAppointmentScreen
{
    NewAppointmentViewController *obj_New = [[NewAppointmentViewController alloc] initWithNibName:@"NewAppointmentViewController" bundle:nil];
    obj_New.mode       =  AppointmentModeAddMatter; //2; // add another matter
    obj_New.entityData = model;
    [self.navigationController pushViewController:obj_New animated:YES];
}
-(void)createNewMatterAskingScreen
{
    nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCretaeNewMatter" owner:self options:nil];
    CustomCretaeNewMatter  *obj_CreateNewMatter = (CustomCretaeNewMatter *)[nib objectAtIndex:0];
    obj_CreateNewMatter.frame = CGRectMake(0, self.view.frame.size.height-(obj_MyTabBar.frame.size.height+obj_CreateNewMatter.frame.size.height), obj_CreateNewMatter.frame.size.width, obj_CreateNewMatter.frame.size.height);
    [self.view addSubview:obj_CreateNewMatter];
    
    [obj_CreateNewMatter.btn_Yes addTarget:self action:@selector(goToNewAppointmentScreen) forControlEvents:UIControlEventTouchUpInside];
    [obj_CreateNewMatter.btn_No
     addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
