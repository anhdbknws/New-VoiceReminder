//
//  VREnumDefine.m
//  VoiceReminder
//
//  Created by GemCompany on 1/11/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VREnumDefine.h"

@implementation VREnumDefine
+ (NSArray *)listAlertType {
    return @[@"At time of event", @"5 minutes before", @"15 minutes before", @"30 minutes before", @"1 hour before", @"2 hour before", @"1 day before", @"2 day before", @"1 week before"];
}

+ (NSString *)alertTypeStringFrom:(ALERT_TYPE)type {
    return [[self class] listAlertType][type];
}

+ (ALERT_TYPE)alertTypeIntegerFromString:(NSString *)typeString {
    NSArray *array = [[self class] listAlertType];
    for (NSString *item in array) {
        if ([item isEqualToString:typeString]) {
            return [array indexOfObject:item];
        }
    }
    
    return ALERT_TYPE_UNKNOW;
}

+ (NSArray *)listRepeatType {
    NSArray *array = @[@"Never", @"Every Hours", @"Every Days", @"Every Weeks", @"Every Months", @"Every Quater", @"Every Years"];
    return array;
}
+ (NSString *)repeatTypeStringFrom:(REPEAT_TYPE)type {
    return [[self class] listRepeatType][type];
}

+ (REPEAT_TYPE)repeatTypeIntegerFromString:(NSString *)typeString {
    NSArray *array = [[self class] listRepeatType];
    for (NSString *item in array) {
        if ([item isEqualToString:typeString]) {
            return [array indexOfObject:item];
        }
    }
    
    return REPEAT_TYPE_UNKNOW;
}

+ (NSArray *)listShortSound {
    return @[@"alarm", @"awesomemorning_alarm", @"background", @"car_alarm", @"car_sms", @"chicken_alarm", @"complete_car_alarm", @"cop_car", @"morning_alarm_remix", @"morning_alarm", @"nice_morning_alarm", @"sweet_morning_alarm"];
}

+ (NSArray *)listBackgroundImages {
    return @[@"q0", @"q1", @"q2", @"q3", @"q4", @"q5", @"q6", @"q7", @"q8", @"q9", @"q10", @"q11", @"q12", @"q13", @"q14", @"q15", @"q16", @"q17", @"q18", @"q19", @"q20", @"q21", @"q22"];
}
@end
