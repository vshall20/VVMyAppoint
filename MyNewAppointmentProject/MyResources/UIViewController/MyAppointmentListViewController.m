//
//  MyAppointmentListViewController.m
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 04/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "MyAppointmentListViewController.h"
#import "LeftViewController.h"
#import "TKCalendarMonthView.h"
#import "NewAppointmentViewController.h"
#import "MyTabBar.h"
#import "MyNavigationBar.h"
#import "LoginRequest.h"
#import "LoginResponse.h"

#import "DataRequest.h"
#import "DataResponse.h"
#import "AppointmentTypeViewController.h"
#import "FilterByLawyerViewController.h"
#import "DataEntity.h"
#import "CustomMyAppointmentListCell.h"
#import "DateFormatter.h"
#import "DetailedAppointmentViewController.h"

#define customAppointmentListCell @"customAppointmentListCell"


@interface MyAppointmentListViewController ()<LeftViewControllerDelegate,TKCalendarMonthViewDelegate,TKCalendarMonthViewDataSource,AppointmentTypeDelegate,FilterByLawyerDelegate,UtilityDelegate>

{
    LeftViewController  *obj_LeftViewController;
    TKCalendarMonthView *calendarView;
    MyTabBar            *obj_MyTabBar;
    MyNavigationBar     *obj_MyNavigationBar;
    NSArray             *nib;
    float               tableViewYPosition;
}

@end

@implementation MyAppointmentListViewController

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
    obj_MyNavigationBar.myNavigationItem.title = @"Appointment";
    [obj_MyNavigationBar.myLeftBarItem setAction:@selector(leftBarClicked:)];
    [obj_MyNavigationBar.myRightItem setAction:@selector(rightBarClicked:)];
    [self.view addSubview:obj_MyNavigationBar];
    // Do any additional setup after loading the view from its nib.
    if (nib)
    {
        nib = nil;
    }
    
    calendarView = 	[[TKCalendarMonthView alloc] init];
    calendarView.frame = CGRectMake(0, obj_MyNavigationBar.frame.size.height, calendarView.frame.size.width, calendarView.frame.size.height);
    NSLog(@"%f",calendarView.frame.size.height);
    calendarView.delegate = self;
    calendarView.dataSource = self;
    [self.view addSubview:calendarView];
	[calendarView reload];
    
    nib = [[NSBundle mainBundle] loadNibNamed:@"MyTabBar" owner:self options:nil];
    
    obj_MyTabBar = (MyTabBar *)[nib objectAtIndex:0];
    obj_MyTabBar.frame = CGRectMake(0, self.view.frame.size.height-obj_MyTabBar.frame.size.height, obj_MyTabBar.frame.size.width, obj_MyTabBar.frame.size.height);
    obj_MyTabBar.delegate = self;
    [self.view addSubview:obj_MyTabBar];
    tableViewYPosition = (calendarView.frame.size.height +  obj_MyNavigationBar.frame.size.height);
    _tbl_AppointmentList.frame = CGRectMake(0,tableViewYPosition, _tbl_AppointmentList.frame.size.width,self.view.frame.size.height-(tableViewYPosition+obj_MyTabBar.frame.size.height));

    
    
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Login" message:@"" delegate:self cancelButtonTitle:@"Login" otherButtonTitles: nil];
    [av setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
    [av setTag:100];
    [[av textFieldAtIndex:1] setSecureTextEntry:NO];
    [[av textFieldAtIndex:0] setPlaceholder:@"Username"];
    [[av textFieldAtIndex:1] setPlaceholder:@"Password"];
    [[av textFieldAtIndex:0] setText:@"shyam.deore@prod.shriyais.com"];
    [[av textFieldAtIndex:1] setText:@"Password123"];
    [[av textFieldAtIndex:1] setSecureTextEntry:YES];
    [av show];
    
    _dateArray = [[NSMutableArray alloc]init];

//    NSDictionary *dictValue = [NSDictionary dictionaryWithObjectsAndKeys:@"chm00101",@"id",@"shyam.deore@prod.shriyais.com",@"username",@"Password123",@"password",@"1",@"flag", nil];
    
    self.fetchResultController = [[[AppDelegate delegate] dataManager]fetchedResultsController];
    self.fetchResultController.delegate = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self loginWebServiceCallAndResponseToGetChamberIDandLawyerID]; //loginWebService Call.
        //[self callTheEventListWebService];     //fetching Events Details WebService Call.
    });
    
    
    [self controllerDidChangeContent:self.fetchResultController];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark FetchedResultsController Delegate Methods
#pragma mark -


//-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller
//{
//
//}


-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    
    [_tbl_AppointmentList reloadData];
    [self updateClanderView];
}

#pragma
#pragma mark -


-(void)updateClanderView
{
    NSString *str_StartDate;
    NSDateFormatter *dateFormatter;
    dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *startDate;
    for (DataEntity *entity in self.fetchResultController.fetchedObjects) {
        str_StartDate = [[DateFormatter sharedDateFormatter] stringFromGivenDate:entity.start];
        str_StartDate = [str_StartDate substringWithRange:NSMakeRange(0, 10)];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        startDate = [dateFormatter dateFromString:str_StartDate];
        //2014-03-07 00:00:00 +0000
        [dateFormatter setDateFormat:@"yyyy-MM-dd '00':'00':'00 '+0000'"];
        str_StartDate  = [dateFormatter stringFromDate:startDate];
        NSLog(@"str_StartDate %@",str_StartDate);
        [_dateArray addObject:str_StartDate];
    }
    [calendarView reload];
}


-(void)loginWebServiceCallAndResponseToGetChamberIDandLawyerID
{
    
    NSMutableDictionary  *dict =  [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"chm00101",@"id",
                                   @"shyam.deore@prod.shriyais.com", @"username",
                                   @"Password123", @"password",
                                   @"1", @"flag",
                                   nil];
    Utility *util = [Utility sharedInstance];
    [util setDelegate:self];
    [util fetchDataWithMethodName:@"Login" andParameterDictionary:dict];

//    LoginRequest *request = [[LoginRequest alloc]initWithUsername:@"shyam.deore@prod.shriyais.com" andPassword:@"Password123"];
//    [request fetchLawyerIDandChamberID];
//    _chamberID = [AppDelegate delegate].chamberID;
//    _lawyerID = [AppDelegate delegate].lawyerID;
}


-(void)callTheEventListWebService
{
    //{\"search\":\" 11/19/2013\",\"lawyerid\":\"%@\",\"caseid\":\"\",\"appointmenttype\":\"\",\"chamberid\":\"%@\",\"logintype\":\"lawyer\"}
    NSMutableDictionary  *dict =  [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"11/18/2013",@"search",
                                       _lawyerID, @"id",
                                       @"", @"caseid",
                                       @"1", @"appointmenttype",
                                       _chamberID, @"chamberid",
                                       @"lawyer", @"logintype",nil];

    
    Utility *util = [Utility sharedInstance];
    [util setDelegate:self];
    [util fetchDataWithMethodName:@"Appointment_ListAllAppointment" andParameterDictionary:dict];

    
   
    
}
#pragma mark - Utility Delegate 
-(void)inComingResponse:(id)response forRequest:(NSString *)request
{
   if ([request isEqualToString:@"Login"])
   {
       [self parseLoginDataWithResponse:response];  /// after successful response call get List webservices
   }
   else if ([request isEqualToString:@"Appointment_ListAllAppointment"])
   {
       [self parseGetAppointmentListDataWithResponse:response];
   }

}

-(void)inComingError:(NSString *)errorMessage forRequest:(NSString *)request
{
    
}
-(void)parseLoginDataWithResponse:(NSObject *)responseData
{
    _chamberID = [responseData valueForKeyPath:@"data.chamberid"];
    _lawyerID  = [responseData valueForKeyPath:@"data.id"];
    
    [[AppDelegate delegate] setLawyerID:_lawyerID];
    [[AppDelegate delegate] setChamberID:_chamberID];
    
    LoginResponse *lresponse = [[LoginResponse alloc]initWithDictionary:(NSMutableDictionary *)responseData];
    [lresponse saveData];
    
    [self callTheEventListWebService];
}
-(void)parseGetAppointmentListDataWithResponse:(NSObject *)responseData
{
    DataResponse *response = [[DataResponse alloc]initWithDictionary:(NSMutableDictionary *)responseData];
    [response saveData];
}
#pragma mark end
#pragma tableView Methods
#pragma mark -


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.fetchResultController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomMyAppointmentListCell *cell = (CustomMyAppointmentListCell*) [tableView dequeueReusableCellWithIdentifier:customAppointmentListCell];
    if (cell == nil)
    {
        nib = [[NSBundle mainBundle] loadNibNamed:@"CustomMyAppointmentListCell" owner:self options:nil];
        cell = (CustomMyAppointmentListCell *)[nib objectAtIndex:0];
    }

    
    // Configure the cell...

    DataEntity *entity = (DataEntity *)[self.fetchResultController objectAtIndexPath:indexPath];
    cell.lbl_AppointmentType.text = entity.appointmentType;
    cell.lbl_ClientName.text      = entity.clientName;
    cell.lbl_DateTime.text        = [NSString stringWithFormat:@"%@ to %@",[[DateFormatter sharedDateFormatter] stringFromGivenDate:entity.start],[[DateFormatter sharedDateFormatter] stringFromGivenDate:entity.end]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataEntity *entity = (DataEntity *)[self.fetchResultController objectAtIndexPath:indexPath];
    DetailedAppointmentViewController *obj_New = [[DetailedAppointmentViewController alloc]
                                                  initWithNibName:@"DetailedAppointmentViewController" bundle:nil];
    obj_New.entityData   = entity;
    [self.navigationController pushViewController:obj_New animated:YES];
  
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


#pragma <#arguments#>
#pragma mark -

- (IBAction)leftBarClicked:(id)sender {
    
    if (!obj_LeftViewController)
    {
        NSArray *arr_Data = [NSArray arrayWithObjects:@"Appointment Type",@"Filter by Lawyer", nil];
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
    AppointmentTypeViewController *obj_Appointment = [[AppointmentTypeViewController alloc] initWithNibName:@"AppointmentTypeViewController" bundle:nil];
    obj_Appointment.myDelegate = self;
    obj_Appointment.view.backgroundColor = [UIColor clearColor];
    self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:obj_Appointment animated:YES completion:NULL];
    }
    else
    {
        FilterByLawyerViewController *obj_Filterlawyer = [[FilterByLawyerViewController alloc] initWithNibName:@"FilterByLawyerViewController" bundle:nil];
        obj_Filterlawyer.myDelegate = self;
        obj_Filterlawyer.tbl_LawyerList.alpha = 0.0;
        obj_Filterlawyer.view.backgroundColor = [UIColor clearColor];
        self.navigationController.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:obj_Filterlawyer animated:YES completion:NULL];

    }
    
}
#pragma mark -
#pragma mark TKCalendarMonthViewDelegate methods

- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
	NSLog(@"calendarMonthView didSelectDate");
}

- (void)calendarMonthView:(TKCalendarMonthView *)monthView monthDidChange:(NSDate *)d {
	NSLog(@"calendarMonthView monthDidChange");
    tableViewYPosition = (calendarView.frame.size.height +  obj_MyNavigationBar.frame.size.height);
    _tbl_AppointmentList.frame = CGRectMake(0,tableViewYPosition, _tbl_AppointmentList.frame.size.width,self.view.frame.size.height-(tableViewYPosition+obj_MyTabBar.frame.size.height));
}

#pragma mark -
#pragma mark TKCalendarMonthViewDataSource methods

- (NSArray*)calendarMonthView:(TKCalendarMonthView *)monthView marksFromDate:(NSDate *)startDate toDate:(NSDate *)lastDate {
	NSLog(@"calendarMonthView marksFromDate toDate");
	NSLog(@"Make sure to update 'data' variable to pull from CoreData, website, User Defaults, or some other source.");
    
   
    NSMutableArray *marks = [NSMutableArray array];
//    NSArray *data = [NSArray arrayWithObjects:@"2014-03-07 00:00:00 +0000", nil];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    [cal setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
        //NSMonthCalendarUnit | NSMinuteCalendarUnit | NSYearCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSSecondCalendarUnit
    NSDateComponents *comp = [cal components:(NSMonthCalendarUnit | NSYearCalendarUnit | NSDayCalendarUnit) fromDate:startDate];
    
    NSDate *d = [cal dateFromComponents:comp];
    
    // Init offset components to increment days in the loop by one each time
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:1];

    
    // for each date between start date and end date check if they exist in the data array
    while (YES) {
        // Is the date beyond the last date? If so, exit the loop.
        // NSOrderedDescending = the left value is greater than the right
        if ([d compare:lastDate] == NSOrderedDescending) {
            break;
        }
        
        // If the date is in the data array, add it to the marks array, else don't
        if ([_dateArray containsObject:[d description]]) {
            [marks addObject:[NSNumber numberWithBool:YES]];
        } else {
            [marks addObject:[NSNumber numberWithBool:NO]];
        }
        
        // Increment day using offset components (ie, 1 day in this instance)
        d = [cal dateByAddingComponents:offsetComponents toDate:d options:0];
    }
   

	// When testing initially you will have to update the dates in this array so they are visible at the
   	return [NSArray arrayWithArray:marks];

}
#pragma mark - Filter Lawyer Delegate 
-(void)lawyerSelectedWithLawyerName:(NSString *)lawyerName
{
    NSLog(@"lawyerName %@",lawyerName);
}
#pragma mark Appointment Type Delegate 
-(void)appointmentTypeClickedWithAppointmentTypeName:(NSString *)name buttonIndex:(int)indexValue
{
    NSLog(@"indexValue %d and name : %@",indexValue,name);
//    [[[AppDelegate delegate] dataManager] performFetchWithPredicateString:name];
    [[[AppDelegate delegate] dataManager] performFetchWithPredicateType:indexValue];
    [self updateClanderView];
    [_tbl_AppointmentList reloadData];
    
    
}
#pragma mark - Tab Bar Delegate 
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item;
{
    NewAppointmentViewController *obj_New = [[NewAppointmentViewController alloc] initWithNibName:@"NewAppointmentViewController" bundle:nil];
    obj_New.entityData = nil;
    obj_New.mode       = AppointmentModeNew; //0; // add
    [self.navigationController pushViewController:obj_New animated:YES];
    NSLog(@"item %d",item.tag);
}

@end
