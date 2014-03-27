//
//  AppointmentTypeViewController.m
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "AppointmentTypeViewController.h"

@interface AppointmentTypeViewController ()

@end

@implementation AppointmentTypeViewController

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


- (IBAction)appointmentTypeClicked:(id)sender {
    
    NSArray *arr = [NSArray arrayWithObjects:@"Matters",@"Consulations",@"Discussions",@"Events",@"Birthday",@"Anniversary",@"Holiday",@"Others",@"All", nil];
    [_myDelegate appointmentTypeClickedWithAppointmentTypeName:[arr objectAtIndex:[sender tag]] buttonIndex:[sender tag]];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
