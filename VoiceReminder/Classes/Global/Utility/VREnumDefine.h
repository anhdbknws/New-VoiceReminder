//
//  VREnumDefine.h
//  VoiceReminder
//
//  Created by GemCompany on 1/11/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, REPEAT_TYPE) {
    REPEAT_TYPE_UNKNOW  = -1,
    REPEAT_TYPE_NERER   = 0,
    REPEAT_TYPE_HOURLY  = 1,
    REPEAT_TYPE_DAILY   = 2,
    REPEAT_TYPE_WEEKLY  = 3,
    REPEAT_TYPE_MONTHLY = 4,
    REPEAT_TYPE_YEARLY  = 5
};

typedef NS_ENUM(NSInteger, ALERT_TYPE) {
    ALERT_TYPE_UNKNOW            = -1,
    ALERT_TYPE_AT_EVENT_TIME     = 0,
    ALERT_TYPE_5_MINUTES_BEFORE  = 1,
    ALERT_TYPE_15_MINUTES_BEFORE = 2,
    ALERT_TYPE_30_MINUTES_BEFORE = 3,
    ALERT_TYPE_1_HOUR_BEFORE     = 4,
    ALERT_TYPE_2_HOUR_BEFORE     = 5,
    ALERT_TYPE_1_DAY_BEFORE      = 6,
    ALERT_TYPE_2_DAY_BEFORE      = 7,
    ALERT_TYPE_1_WEEAK_BEFORE    = 8
};

@interface VREnumDefine : NSObject
+ (NSArray *)listRepeatType;
+ (NSString *)repeatTypeStringFrom:(REPEAT_TYPE)type;
+ (REPEAT_TYPE)repeatTypeIntegerFromString:(NSString *)typeString;

+ (NSArray *)listAlertType;
+ (NSString *)alertTypeStringFrom:(ALERT_TYPE)type;
+ (ALERT_TYPE)alertTypeIntegerFromString:(NSString *)typeString;
@end
