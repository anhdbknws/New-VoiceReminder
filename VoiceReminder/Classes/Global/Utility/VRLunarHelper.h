//
//  VRLunarHelper.h
//  VoiceReminder
//
//  Created by GemCompany on 6/14/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VRLunarDateModel.h"

@interface VRLunarHelper : NSObject
@property (nonatomic, strong) NSMutableArray *CANS;
@property (nonatomic, strong) NSMutableArray *CHIS;
@property (nonatomic, strong) NSMutableArray *WEEKS;
@property (nonatomic, strong) NSMutableArray *yearOfNineTeen;
@property (nonatomic, strong) NSMutableArray *yearOfTweenty;
@property (nonatomic, strong) NSMutableArray *yearOfTweentyOne;
@property (nonatomic, strong) NSMutableArray *yearOfTweentyTwo;
@property (nonatomic, strong) NSMutableArray *monthsLunar;
@property (nonatomic, strong) VRLunarDateModel *lunarModel;

- (NSDate *)getCurrentDate;
- (NSDate *)getNextDate;
- (NSDate *)getPreviousDate;

- (BOOL)checkDate:(NSDate *)date from:(NSDate *)startDate to:(NSDate *)endDate;
- (NSString *)getCungHoangDao:(NSDate *)date;

- (int)getCurrentYear;
- (int)getCurrentMonth;
- (int)getCurrentDay;

- (int)getYearFromDate:(NSDate *)date;
- (int)getDayFromDate:(NSDate *)date;
- (NSDate *)ConvertSolarToLunar:(NSDate *)date;


- (NSMutableArray *)listYearOfNineteenCentery;
- (NSMutableArray *)listYearOfTweentyCentery;
- (NSMutableArray *)listYearOfTweentyOneCentery;
- (NSMutableArray *)listYearOfTweentyTwoCentery;
- (NSMutableArray *)listCAN;
- (NSMutableArray *)listCHI;
- (NSMutableArray *)listWeak;

- (void)convertSolar2Lunar:(int)dd andMonth:(int)mm andYear:(int)yy withTimeZone:(int)timeZone;
@end
