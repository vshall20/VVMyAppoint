//
//  DateFormatter.h
//  MyNewAppointmentProject
//
//  Created by Vishnu Gupta on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatter : NSObject

@property (nonatomic, strong) NSDateFormatter *dateFormatter;


+(DateFormatter *)sharedDateFormatter;
-(NSDate *)dateFromParamString:(NSString *)string;
-(NSString *)stringFromGivenDate:(NSDate *)date;
-(NSComparisonResult)compareDate:(NSDate *)myDate fromTodayDate:(NSDate *)todayDate;
@end
