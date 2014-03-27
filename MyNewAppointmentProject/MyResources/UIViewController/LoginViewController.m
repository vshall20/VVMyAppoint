//
//  LoginViewController.m
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 05/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "LoginViewController.h"
#import "MyAppointmentListViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonClicked:(id)sender {
    MyAppointmentListViewController *myTab = [[MyAppointmentListViewController alloc] initWithNibName:@"MyTabBarController" bundle:nil];
    [self.navigationController pushViewController:myTab animated:YES];
}
@end
