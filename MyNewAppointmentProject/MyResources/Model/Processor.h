//
//  Processor.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataEntity.h"

@interface Processor : NSObject

@property (nonatomic,strong) NSMutableDictionary *dictionary;
@property (nonatomic,strong) NSMutableArray *dataEntityArray;

-(id)initWithDictionary:(NSMutableDictionary *)dict;
-(void)parseDictionaryAndSave;
-(void)parseDictionaryAndSaveLawyerData;

@end
