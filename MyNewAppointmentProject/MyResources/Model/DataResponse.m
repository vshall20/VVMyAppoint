//
//  DataResponse.m
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "DataResponse.h"
#import "Processor.h"

@implementation DataResponse


-(id)initWithDictionary:(NSMutableDictionary *)dict
{
    self = [super init];
    if (self) {
        self = [[DataResponse alloc]init];
        _dataDictionary = dict;
    }
    return self;
}


-(void)saveData
{
    if (_dataDictionary)
    {
        Processor *processor = [[Processor alloc]initWithDictionary:_dataDictionary];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            [processor parseDictionaryAndSave];
        });
    }
}
@end
