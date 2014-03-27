//
//  AppDelegate.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 04/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAppointmentListViewController.h"
#import "DataManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MyAppointmentListViewController *myController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectContext *writerManagedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) DataManager *dataManager;

@property (nonatomic, strong) NSString *lawyerID;
@property (nonatomic, strong) NSString *chamberID;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


+(AppDelegate *)delegate;

@end
