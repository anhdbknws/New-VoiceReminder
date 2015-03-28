//
//  VRCommon.m
//  VoiceReminder
//
//  Created by GemCompany on 1/11/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRCommon.h"

@implementation VRCommon
+ (NSString *)formatDateAndTimeFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd, yyyy HH:mm"];
    NSString *stringFromDate = [dateFormatter stringFromDate:[NSDate date]];
    return stringFromDate;
}

+ (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd, yyyy HH:mm"];
    NSDate *date = [dateFormat dateFromString:dateString];
    return date;
}

@end
