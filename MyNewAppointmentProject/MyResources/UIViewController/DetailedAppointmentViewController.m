//
//  DetailedAppointmentViewController.m
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 13/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "DetailedAppointmentViewController.h"
#import "DateFormatter.h"
#import "MyNavigationBar.h"
#import "MyTabBar.h"
#import "LeftViewController.h"
#import "NewAppointmentViewController.h"
#import "CustomBottomView.h"
#import "MatterSummaryViewController.h"


@interface DetailedAppointmentViewController ()<UITabBarDelegate,LeftViewControllerDelegate>
{
     MyNavigationBar     *obj_MyNavigationBar;
     NSArray             *nib;
     MyTabBar            *obj_MyTabBar;
     LeftViewController   *obj_LeftViewController;
     DateFormatter       *myDateFormat;
}

@end

@implementation DetailedAppointmentViewController

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
    obj_MyNavigationBar.myNavigationItem.title = @"Appointment";
    [obj_MyNavigationBar.myLeftBarItem setAction:@selector(leftBarClicked:)];
    [obj_MyNavigationBar.myRightItem setAction:@selector(rightBarClicked:)];
    [self.view addSubview:obj_MyNavigationBar];
    
    _btn_Basic.frame = CGRectMake(0, obj_MyNavigationBar.frame.size.height, _btn_Basic.frame.size.width, _btn_Basic.frame.size.height);
    _btn_Invite.frame = CGRectMake(_btn_Invite.frame.origin.x, obj_MyNavigationBar.frame.size.height, _btn_Invite.frame.size.width, _btn_Invite.frame.size.height);
    
    nib = [[NSBundle mainBundle] loadNibNamed:@"MyTabBar" owner:self options:nil];
    
    obj_MyTabBar = (MyTabBar *)[nib objectAtIndex:0];
    obj_MyTabBar.frame = CGRectMake(0, self.view.frame.size.height-obj_MyTabBar.frame.size.height, obj_MyTabBar.frame.size.width, obj_MyTabBar.frame.size.height);
    obj_MyTabBar.delegate = self;
    [self.view addSubview:obj_MyTabBar];
    
   
   
    
   
   ///////// IF END DATE IS LESS THAN TODAYS DATE SHOW MATTER VIEW //////////////////////
    myDateFormat = [DateFormatter sharedDateFormatter];
    NSComparisonResult result = [myDateFormat compareDate:_entityData.end fromTodayDate:[NSDate date]];
    if (result == NSOrderedAscending && [_entityData.appointmentType isEqualToString:@"Matter"])
    {
        nib = [[NSBundle mainBundle] loadNibNamed:@"CustomBottomView" owner:self options:nil];
        CustomBottomView *obj_CustomBottomView = (CustomBottomView *)[nib objectAtIndex:0];
        obj_CustomBottomView.frame = CGRectMake(0, obj_MyTabBar.frame.origin.y-obj_MyTabBar.frame.size.height, obj_CustomBottomView.frame.size.width, obj_CustomBottomView.frame.size.height);
         [self.view addSubview:obj_CustomBottomView];
        obj_CustomBottomView.view_Attending.alpha = 0.0;
        obj_CustomBottomView.view_AttendingAccepted.alpha = 0.0;
        obj_CustomBottomView.view_Matter.alpha = 1.0;
        
        [obj_CustomBottomView.btn_Matter addTarget:self action:@selector(showMatterSummaryScreen:) forControlEvents:UIControlEventTouchUpInside];
    }
     _tbl_MyTable.backgroundColor = [UIColor colorWithPatternImage:matterScreenBackGroundImage];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    float myTableHeight = obj_MyNavigationBar.frame.size.height + _btn_Invite.frame.size.height;
    _tbl_MyTable.frame = CGRectMake(0, myTableHeight, _tbl_MyTable.frame.size.width, self.view.frame.size.height-myTableHeight);
    [_tbl_MyTable reloadData];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)leftBarClicked:(id)sender {
    
    if (!obj_LeftViewController)
    {
        NSArray *arr_Data = [NSArray arrayWithObjects:@"Edit",@"Back", nil];
        obj_LeftViewController = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
        obj_LeftViewController.myArray = arr_Data;
        obj_LeftViewController.delegate = self;
        obj_LeftViewController.view.frame = CGRectMake(0, obj_MyNavigationBar.frame.size.height, 100, 88);
        [self addChildViewController:obj_LeftViewController];
        [self.view addSubview:obj_LeftViewController.view];
        [obj_LeftViewController didMoveToParentViewController:self];
        
    }
    else
    {
        [self removeLeftViewController];
    }

    
}

- (IBAction)rightBarClicked:(id)sender {
    
}
#pragma mark - remove child controller
-(void)removeLeftViewController
{
    if (obj_LeftViewController)
    {
    [obj_LeftViewController didMoveToParentViewController:nil];
    [obj_LeftViewController.view removeFromSuperview];
    [obj_LeftViewController removeFromParentViewController];
    obj_LeftViewController = nil;
    }
}
#pragma mark - Left View Controller Delegate
-(void)leftSideTableViewSelectedWithStringValue:(NSString *)name indexValue:(int)indexValue
{
    [self removeLeftViewController];
    if (indexValue == 0)
    {
        NewAppointmentViewController *obj_New = [[NewAppointmentViewController alloc] initWithNibName:@"NewAppointmentViewController" bundle:nil];
        obj_New.entityData  = _entityData;
        obj_New.mode       = AppointmentModeEdit; // edit
        [self.navigationController pushViewController:obj_New animated:YES];
    }
    else
    {
      [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}
#pragma mark -
#pragma tableView Methods
#pragma mark -


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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 9;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0: /// From Date
            return tableView.rowHeight;
            break;
        case 1: ///// To Date
        {
            if ([_entityData.appointmentType isEqualToString:@"Matter"] || [_entityData.appointmentType isEqualToString:@"Consulation"] || [_entityData.appointmentType isEqualToString:@"Discussion"] || [_entityData.appointmentType isEqualToString:@"Event"])
            {
                return tableView.rowHeight;;
            }
            else{
                return 0;
            }
        }
            break;
        case 2: //// Link to case id
        {
            if ([_entityData.appointmentType isEqualToString:@"Matter"] || [_entityData.appointmentType isEqualToString:@"Consulation"] || [_entityData.appointmentType isEqualToString:@"Discussion"] || [_entityData.appointmentType isEqualToString:@"Event"])
            {
                return tableView.rowHeight;;
            }
            else{
                return 0;
            }
        }
            break;
        case 3: //// select venue
        {
            if ([_entityData.appointmentType isEqualToString:@"Matter"] || [_entityData.appointmentType isEqualToString:@"Consulation"] || [_entityData.appointmentType isEqualToString:@"Discussion"] || [_entityData.appointmentType isEqualToString:@"Event"])
            {
                return tableView.rowHeight;;
            }
            else{
                return 0;
            }
        }
            
            break;
        case 4: /////  Visibility
        {
            if ([_entityData.appointmentType isEqualToString:@"Event"])
            {
                return tableView.rowHeight;;
            }
            else{
                return 0;
            }
        }
        case 5: ////// Recurring
            if ([_entityData.appointmentType isEqualToString:@"Birthday"] || [_entityData.appointmentType isEqualToString:@"Anniversary"] || [_entityData.appointmentType isEqualToString:@"Holiday"])
            {
                return tableView.rowHeight;
            }
            else{
                return 0;
            }
            break;
        case 6: //// hoilday
            if ([_entityData.appointmentType isEqualToString:@"Holiday"])
            {
                return tableView.rowHeight;;
            }
            else{
                return 0;
            }
            break;
        case 7: /////// Description
            if ([_entityData.appointmentType isEqualToString:@"Matter"] || [_entityData.appointmentType isEqualToString:@"Consulation"] || [_entityData.appointmentType isEqualToString:@"Discussion"] || [_entityData.appointmentType isEqualToString:@"Event"])
            {
                return tableView.rowHeight;;
            }
            else{
                return 0;
            }
            break;
        case 8: /// From Reminder
            return tableView.rowHeight;;
            break;
        default:
            return tableView.rowHeight;;
            break;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailAppointmentCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"detailAppointmentCell"];
    }
    

    switch (indexPath.row) {
        case 0: ///// From  Date
        {
            cell.textLabel.text = @"From";
            cell.detailTextLabel.text = [[DateFormatter sharedDateFormatter] stringFromGivenDate:_entityData.start];
        }
            break;
        case 1:  ////// To Date
        {
            cell.textLabel.text = @"To";
            if ([_entityData.appointmentType isEqualToString:@"Matter"]) {
                if ([_entityData.end compare:[NSDate date]]==NSOrderedDescending) {
                        //dont show matter button
                    NSLog(@"Dont Show matter button");
                }
                else
                {
                        //show matter button
                    NSLog(@"Show matter button");
                }
            }
            
            cell.detailTextLabel.text = [[DateFormatter sharedDateFormatter] stringFromGivenDate:_entityData.end];
            if ([_entityData.appointmentType isEqualToString:@"Matter"] || [_entityData.appointmentType isEqualToString:@"Consulation"] || [_entityData.appointmentType isEqualToString:@"Discussion"] || [_entityData.appointmentType isEqualToString:@"Event"])
            {
                cell.hidden = NO;
            }
            else{
                cell.hidden = YES;
                
            }
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"Link to case Id";
            cell.detailTextLabel.text = _entityData.caseId;
            if ([_entityData.appointmentType isEqualToString:@"Matter"] || [_entityData.appointmentType isEqualToString:@"Consulation"] || [_entityData.appointmentType isEqualToString:@"Discussion"] || [_entityData.appointmentType isEqualToString:@"Event"])
            {
                cell.hidden = NO;
            }
            else{
                cell.hidden = YES;
                
            }
            
        }
            break;
        case 3:   ///////// Venue
        {
            cell.textLabel.text = @"Venue";
            cell.detailTextLabel.text = _entityData.venue;
            if ([_entityData.appointmentType isEqualToString:@"Matter"] || [_entityData.appointmentType isEqualToString:@"Consulation"] || [_entityData.appointmentType isEqualToString:@"Discussion"] || [_entityData.appointmentType isEqualToString:@"Event"])
            {
                cell.hidden = NO;
            }
            else{
                cell.hidden = YES;
                
            }
            
        }
            break;
        case 4:
            {
            cell.textLabel.text = @"Visibility";
            cell.detailTextLabel.text = _entityData.eventVisibility;
            if ([_entityData.appointmentType isEqualToString:@"Event"])
            {
                cell.hidden = NO;
            }
            else{
                cell.hidden = YES;
            }
            
        }
            break;
        case 5:
        {
            cell.textLabel.text = @"Recurring";
            cell.detailTextLabel.text = _entityData.recurrenceRule;
            if ([_entityData.appointmentType isEqualToString:@"Birthday"] || [_entityData.appointmentType isEqualToString:@"Anniversary"] || [_entityData.appointmentType isEqualToString:@"Holiday"])
            {
                cell.hidden = NO;
            }
            else{
                cell.hidden = YES;
            }
            
           
            
        }
            break;
        case 6:
        {
            cell.textLabel.text = @"Holiday";
            cell.detailTextLabel.text = _entityData.holidayType;
            if ([_entityData.appointmentType isEqualToString:@"Holiday"])
            {
                cell.hidden = NO;
            }
            else{
                cell.hidden = YES;
            }
            
            
            
        }
            break;
        case 7:
        {
            cell.textLabel.text = @"Description";
            cell.detailTextLabel.text = _entityData.appointmentDescription;
          
            if ([_entityData.appointmentType isEqualToString:@"Matter"] || [_entityData.appointmentType isEqualToString:@"Consulation"] || [_entityData.appointmentType isEqualToString:@"Discussion"] || [_entityData.appointmentType isEqualToString:@"Event"])
            {
                cell.hidden = NO;
            }
            else{
                cell.hidden = YES;
                
            }
        }
            break;
        case 8:
        {
            cell.textLabel.text = @"Reminder";
            cell.detailTextLabel.text = _entityData.reminder;
          
        }
            break;
            
            
        default:
            break;
    }
    cell.contentView.backgroundColor = [UIColor colorWithPatternImage:matterScreenBackGroundImage];
    // Configure the cell...
    
    return cell;
}

-(void)showMatterSummaryScreen:(id)sender
{
    MatterSummaryViewController *obj_Matter = [[MatterSummaryViewController alloc] initWithNibName:@"MatterSummaryViewController" bundle:nil];
    obj_Matter.model  = _entityData;
    [self.navigationController pushViewController:obj_Matter animated:YES];
}
- (IBAction)buttnClicked:(id)sender {
}
#pragma mark - Tab Bar Delegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;
{
 
}
@end
