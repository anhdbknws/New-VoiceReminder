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
    return @[@"Never",@"Every Monday", @"Every Tuesday", @"Every Wednesday", @"Every Thursday", @"Every Friday", @"Every Saturday", @"Every Sunday", @"Every day"];
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

@end
