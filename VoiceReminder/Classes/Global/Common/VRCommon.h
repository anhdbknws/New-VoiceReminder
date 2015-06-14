//
//  VRCommon.h
//  VoiceReminder
//
//  Created by GemCompany on 1/11/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VRCommon : NSObject
+ (NSString*)formatDateAndTimeFromDate:(NSDate*)date;
+ (NSDate *)dateFromString:(NSString *)string;
+ (NSDate *)localDateFromUnixTime:(NSNumber *)unixTime;
+ (double)unixTimeFromDate:(NSDate *)date;
+ (double)unixTimeMiliSecondFromDate:(NSDate *)date;
+ (NSDateFormatter *)commonDateFormat;
+ (NSDateFormatter *)commonDateTimeFormat;
+ (NSString *)commonFormatFromDate:(NSDate *)date;
+ (NSString *)commonFormatTimeFromDate:(NSDate *)date;
+ (NSString *)commonFormatFromDateTime:(NSDate *)date;
+ (NSString *)commonFormatFromMonthYear:(NSDate *)date;
+ (NSString *)commonFormatFromYear:(NSDate *)date;
+ (NSString *)removeWhiteSpace:(NSString *)inputString;
+ (NSSortDescriptor *)sortDescriptorByCreatedDate;

+ (NSDate *)addOneMonthToDate:(NSDate *)date;
+ (NSDate *)minusOneMonthFromDate:(NSDate *)date;
+ (NSDate *)addOneDayToDate:(NSDate *)date;
+ (NSDate *)minusOneDayFromDate:(NSDate *)date;
+ (NSDate *)addOneWeektoDate:(NSDate *)date;
+ (NSDate *)minusOneWeekFromDate:(NSDate *)date;
@end
