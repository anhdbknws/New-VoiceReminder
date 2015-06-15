//
//  VRLunarHelper.h
//  VoiceReminder
//
//  Created by GemCompany on 6/14/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VRLunarHelper : NSObject
@property (nonatomic, strong) NSMutableArray *listIdoms;
@property (nonatomic, strong) NSMutableArray *listGoodHours;
- (NSDate *)getCurrentDate;
- (NSDate *)getNextDate;
- (NSDate *)getPreviousDate;

- (BOOL)checkDate:(NSDate *)date from:(NSDate *)startDate to:(NSDate *)endDate;
- (NSString *)getCungHoangDao:(NSDate *)date;

- (int)getCurrentYear;
- (int)getCurrentMonth;
- (int)getCurrentDay;
- (int)getCurrentDayOfWeek;

- (int)getYearFromDate:(NSDate *)date;
- (int)getDayFromDate:(NSDate *)date;
- (int)getMonthFromDate:(NSDate *)date;
- (int)getDayOfWeekFromDate:(NSDate *)date;

- (NSString *)getMonthYearStringFromDate:(NSDate *)date;

@end
