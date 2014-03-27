//
//  DataManager.h
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectContext *bgManagedObjectContext;

-(id)initWithManagedObjectContext:(NSManagedObjectContext *)context;
- (void)saveBGContext;
-(void)performFetch;
-(void)performFetchWithPredicateString:(NSString *)predicateString;
-(void)performFetchWithPredicateType:(AppointmentType)type;
-(void)performFetchWithCaseID:(NSString *)caseID;
@end
