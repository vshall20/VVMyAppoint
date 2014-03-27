//
//  DataManager.m
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

+ (NSArray *)names
{
    static NSMutableArray * _names = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _names = [[NSMutableArray alloc]init];
        [_names insertObject:@"Matter" atIndex:AppointmentTypeMatter];
        [_names insertObject:@"Consultation" atIndex:AppointmentTypeConsultation];
        [_names insertObject:@"Discussion" atIndex:AppointmentTypeDiscussion];
        [_names insertObject:@"Event" atIndex:AppointmentTypeEvent];
        [_names insertObject:@"Birthday" atIndex:AppointmentTypeBirthday];
        [_names insertObject:@"Anniversary" atIndex:AppointmentTypeAnniversary];
        [_names insertObject:@"Holiday" atIndex:AppointmentTypeHoliday];
        [_names insertObject:@"Other" atIndex:AppointmentTypeOthers];
        [_names insertObject:@"All" atIndex:AppointmentTypeAll];
    });
    
    return _names;
}

+ (NSString *)appointmentTypeForIndex:(AppointmentType)index
{
    return [[self names] objectAtIndex:index];
}

-(id)initWithManagedObjectContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self) {
        self = [[DataManager alloc]init];
//        _managedObjectContext = context;
    }
    return self;
}


-(NSManagedObjectContext *)managedObjectContext
{
    return [[AppDelegate delegate] managedObjectContext];
}

-(NSManagedObjectContext *)bgManagedObjectContext
{
    if (!_bgManagedObjectContext) {
        _bgManagedObjectContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_bgManagedObjectContext setParentContext:[self managedObjectContext]];
    }
    return _bgManagedObjectContext;
}

-(NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:kNameEntityName inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"appId" ascending:NO];
    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:[self managedObjectContext]
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

-(void)performFetch
{
    NSError *error;
	if (![[self fetchedResultsController] performFetch:&error]) {
            // Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
    
}

-(void)performFetchWithPredicateString:(NSString *)predicateString
{
    NSPredicate *predicate;
    if ([predicateString isEqualToString:@"All"] || [predicateString isEqualToString:@"Others"]) {
        predicateString = nil;
    }
    else
    {
        predicate = [NSPredicate predicateWithFormat:@"appointmentType like %@",predicateString];
    }
    
    [self.fetchedResultsController.fetchRequest setPredicate:predicate];
    [self performFetch];
}


-(void)performFetchWithCaseID:(NSString *)caseID
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"caseId like %@",caseID];
    [self.fetchedResultsController.fetchRequest setPredicate:predicate];
    [self performFetch];
}

-(void)performFetchWithPredicateType:(AppointmentType)type
{
    NSPredicate *predicate;
    
    if (type == AppointmentTypeAll || type == AppointmentTypeOthers) {
        predicate = nil;
    }
    else
    {
        predicate = [NSPredicate predicateWithFormat:@"appointmentType like %@",[[self class] appointmentTypeForIndex:type]];
    }
    
    [self.fetchedResultsController.fetchRequest setPredicate:predicate];
    [self performFetch];
}

- (void)saveBGContext
{
    __block NSError *error = nil;
    __block NSManagedObjectContext *tempManagedObjectContext = self.bgManagedObjectContext;
    __block NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    __block NSManagedObjectContext *writerManagedObjectContext = [[self managedObjectContext] parentContext];
    if (tempManagedObjectContext != nil)
    {
        [tempManagedObjectContext performBlock:^{
            
            if ([tempManagedObjectContext hasChanges] && ![tempManagedObjectContext save:&error]) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                
            }
            [managedObjectContext performBlock:^{
               
                if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
                        // Replace this implementation with code to handle the error appropriately.
                        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                    
                }
                
                [writerManagedObjectContext performBlock:^{
                   
                    if ([writerManagedObjectContext hasChanges] && ![writerManagedObjectContext save:&error]) {
                            // Replace this implementation with code to handle the error appropriately.
                            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                        
                    }
                    
                }];
                
            }];
        }];
    }
}


@end
