//
//  VRLunarHelper.m
//  VoiceReminder
//
//  Created by GemCompany on 6/14/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRLunarHelper.h"

@implementation VRLunarHelper

- (BOOL)checkDate:(NSDate *)date from:(NSDate *)startDate to:(NSDate *)endDate {
    return ([date compare:startDate] == NSOrderedDescending || [date compare:startDate] == NSOrderedSame) &&
    ([date compare:endDate]  == NSOrderedAscending || [date compare:endDate]  == NSOrderedSame);
}

- (NSString *)getCungHoangDao:(NSDate *)shortDate {
    NSString *shortDateString = [[VRCommon commonDateFormat] stringFromDate:shortDate];
    NSDate *date = [[VRCommon commonDateFormat] dateFromString:shortDateString];
    int year = [self getYearFromDate:shortDate];
    
    NSDate *_Aries = [self creatDateFrom:19 and:2 and:year];
    NSDate *Aries_ = [self creatDateFrom:20 and:3 and:year];
    NSDate *_Taurus = [self creatDateFrom:21 and:3 and:year];
    NSDate *Taurus_ = [self creatDateFrom:19 and:4 and:year];
    NSDate *_Gemini = [self creatDateFrom:20 and:4 and:year];
    NSDate *Gemini_ = [self creatDateFrom:20 and:5 and:year];
    NSDate *_Cancer = [self creatDateFrom:21 and:5 and:year];
    NSDate *Cancer_ = [self creatDateFrom:21 and:6 and:year];
    NSDate *_Leo = [self creatDateFrom:22 and:6 and:year];
    NSDate *Leo_ = [self creatDateFrom:22 and:7 and:year];
    NSDate *_Virgo = [self creatDateFrom:23 and:7 and:year];
    NSDate *Virgo_ = [self creatDateFrom:22 and:8 and:year];
    NSDate *_Libra = [self creatDateFrom:23 and:8 and:year];
    NSDate *Libra_ = [self creatDateFrom:22 and:9 and:year];
    NSDate *_Scorpio = [self creatDateFrom:23 and:9 and:year];
    NSDate *Scorpio_ = [self creatDateFrom:23 and:10 and:year];
    NSDate *_Sagittarius = [self creatDateFrom:24 and:10 and:year];
    NSDate *Sagittarius_ = [self creatDateFrom:21 and:11 and:year];
    NSDate *_Capricornus = [self creatDateFrom:22 and:11 and:year];
    NSDate *Capricornus_ = [self creatDateFrom:21 and:12 and:year];
    
    // note
    int day = [self getDayFromDate:date];
    NSDate *_Aquarius;
    NSDate *Aquarius_;
    if (0 <= day && day <= 19) {
        _Aquarius = [self creatDateFrom:22 and:12 and:year - 1];
        Aquarius_ = [self creatDateFrom:19 and:1 and:year];
    }
    else if (day >= 22 && day <= 31){
        _Aquarius = [self creatDateFrom:22 and:12 and:year];
        Aquarius_ = [self creatDateFrom:19 and:1 and:year + 1];
    }
    
    NSDate *_Pisces = [self creatDateFrom:20 and:1 and:year];
    NSDate *Pisces_ = [self creatDateFrom:18 and:2 and:year];

    if([self checkDate:date from:_Capricornus to:Capricornus_])
        return @"Ma Kết (22/12-19/1)";//capricorn|
    if([self checkDate:date from:_Aries to:Aries_])
        return @"Bạch Dương (21/3-19/4)";//aries|
    if([self checkDate:date from:_Taurus to:Taurus_])
        return @"Kim Ngưu (20/4-20/5)";//taurus|
    if([self checkDate:date from:_Gemini to:Gemini_])
        return @"Song Tử (21/5-21/6)";//gemini|
    if([self checkDate:date from:_Cancer to:Cancer_])
        return @"Cự Giải (22/6-22/7)"; //cancer|
    if([self checkDate:date from:_Leo to:Leo_])
        return @"Sư Tử (23/7-22/8)"; //leo|
    if([self checkDate:date from:_Virgo to:Virgo_])
        return @"Xử Nữ (24/8-23/9)";//virgo|
    if([self checkDate:date from:_Libra to:Libra_])
        return @"Thiên Bình (23/9-23/10)"; //libra|
    if([self checkDate:date from:_Scorpio to:Scorpio_])
        return @"Bọ Cạp (24/10-21/11)"; //scorpio|
    if([self checkDate:date from:_Sagittarius to:Sagittarius_])
        return @"Nhân Mã (22/11-21/12)"; //sagittarius|
    if ([self checkDate:date from:_Aquarius to:Aquarius_]) {
        return @"Bảo Bình (20/1-18/2)"; //aquarius|
    }
    if ([self checkDate:date from:_Pisces to:Pisces_]) {
        return @"Song Ngư (19/2-20/3)"; //pisces|
    }
    
    return @"";
}



- (NSString *)horoscopeEngFromVi:(NSString *)horoscopeVi {
    if ([horoscopeVi isEqualToString:@"Ma Kết"]) {
        return @"capricorn";
    }
    else if ([horoscopeVi isEqualToString:@"Bạch Dương"]) {
        return @"aries";
    }
    else if ([horoscopeVi isEqualToString:@"Kim Ngưu"]) {
        return @"taurus";
    }
    else if ([horoscopeVi isEqualToString:@"Song Tử"]) {
        return @"gemini";
    }
    else if ([horoscopeVi isEqualToString:@"Cự Giải"]) {
        return @"cancer";
    }
    else if ([horoscopeVi isEqualToString:@"Sư Tử"]) {
        return @"leo";
    }
    else if ([horoscopeVi isEqualToString:@"Xử Nữ"]) {
        return @"virgo";
    }
    else if ([horoscopeVi isEqualToString:@"Bọ Cạp"]) {
        return @"scorpio";
    }
    else if ([horoscopeVi isEqualToString:@"Thiên Bình"]) {
        return @"libra";
    }
    else if ([horoscopeVi isEqualToString:@"Nhân Mã"]) {
        return @"sagittarius";
    }
    else if ([horoscopeVi isEqualToString:@"Bảo Bình"]){
        return @"aquarius";
    }
    else {
        return @"pisces";
    }
}

- (NSDate *)creatDateFrom:(int)day and:(int)month and:(int)year {
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.timeZone = [NSTimeZone localTimeZone];
    [comps setDay:day];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorian dateFromComponents:comps];
    return date;
}

- (int)getYearFromDate:(NSDate *)date {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    return (int)[components year];
}

- (int)getDayFromDate:(NSDate *)date {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    return (int)[components day];
}

- (int)getMonthFromDate:(NSDate *)date {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    return (int)[components month];
}

- (int)getDayOfWeekFromDate:(NSDate *)date {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal components:NSWeekdayCalendarUnit fromDate:date];
    return (int)[comps weekday];
}

- (int)getCurrentYear {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[self getCurrentDate]];
    return (int)[components year];
}

- (int)getCurrentMonth {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[self getCurrentDate]];
    return (int)[components month];
}

- (int)getCurrentDay {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[self getCurrentDate]];
    return (int)[components day];
}

- (int)getCurrentDayOfWeek {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSWeekdayCalendarUnit fromDate:[self getCurrentDate]];
    return (int)[components day];
}

- (NSDate *)getCurrentDate {
    return [NSDate date];
}

- (NSDate *)getNextDate {
    return [VRCommon addOneDayToDate:[self getCurrentDate]];
}

- (NSDate *)getPreviousDate {
    return [VRCommon minusOneDayFromDate:[self getCurrentDate]];
}

- (NSString *)getMonthYearStringFromDate:(NSDate *)date {
    NSString *monthYearString = [NSString stringWithFormat:@"Tháng %d năm %d", [self getMonthFromDate:date], [self getYearFromDate:date]];
    
    return monthYearString;
}


- (NSMutableArray *)listIdoms {
    if (!_listIdoms) {
        _listIdoms = [NSMutableArray new];
        NSMutableArray *listPrefix = [NSMutableArray new];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"idom_vi" ofType:@"json"];
        listPrefix = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:NULL];
        
        for (NSDictionary *dict in listPrefix) {
            [_listIdoms addObject:dict];
        }
    }
    
    return _listIdoms;
}

- (NSMutableArray *)listGoodHours {
    return nil;
}
@end
