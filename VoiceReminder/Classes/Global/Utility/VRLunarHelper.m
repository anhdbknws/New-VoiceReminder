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
    return [date compare:startDate] == NSOrderedDescending &&
    [date compare:endDate]  == NSOrderedAscending;;
}

- (NSString *)getCungHoangDao:(NSDate *)date {
    int year = [self getYearFromDate:date];
    
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
        return @"capricorn|Ma Kết (22/12-19/1)";
    if([self checkDate:date from:_Aries to:Aries_])
        return @"aries|Bạch Dương (21/3-19/4)";
    if([self checkDate:date from:_Taurus to:Taurus_])
        return @"taurus|Kim Ngưu (20/4-20/5)";
    if([self checkDate:date from:_Gemini to:Gemini_])
        return @"gemini|Song Tử (21/5-21/6)";
    if([self checkDate:date from:_Cancer to:Cancer_])
        return @"cancer|Cự Giải (22/6-22/7)";
    if([self checkDate:date from:_Leo to:Leo_])
        return @"leo|Sư Tử (23/7-22/8)";
    if([self checkDate:date from:_Virgo to:Virgo_])
        return @"virgo|Xử Nữ (24/8-23/9)";
    if([self checkDate:date from:_Libra to:Libra_])
        return @"libra|Thiên Bình (23/9-23/10)";
    if([self checkDate:date from:_Scorpio to:Scorpio_])
        return @"scorpio|Bọ Cạp (24/10-21/11)";
    if([self checkDate:date from:_Sagittarius to:Sagittarius_])
        return @"sagittarius|Nhân Mã (22/11-21/12)";
    if ([self checkDate:date from:_Aquarius to:Aquarius_]) {
        return @"aquarius|Bảo Bình (20/1-18/2)";
    }
    if ([self checkDate:date from:_Pisces to:Pisces_]) {
        return @"pisces|Song Ngư (19/2-20/3)";
    }
    
    return @"";
}

- (NSDate *)creatDateFrom:(int)day and:(int)month and:(int)year {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    NSNumber *_day = [NSNumber numberWithInt:day];
    NSNumber *_month = [NSNumber numberWithInt:month];
    NSNumber *_year = [NSNumber numberWithInt:year];
    [components setDay:[_day intValue]];
    [components setMonth:[_month intValue]];
    [components setMonth:[_year intValue]];
    NSDate *_date = [calendar dateFromComponents:components];
    return _date;
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

- (int)getCurrentYear {
    NSCalendar *cal = [[NSCalendar alloc] init];
    NSDateComponents *components = [cal components:0 fromDate:[self getCurrentDate]];
    return (int)[components year];
}

- (int)getCurrentMonth {
    NSCalendar *cal = [[NSCalendar alloc] init];
    NSDateComponents *components = [cal components:0 fromDate:[self getCurrentDate]];
    return (int)[components month];
}

- (int)getCurrentDay {
    NSCalendar *cal = [[NSCalendar alloc] init];
    NSDateComponents *components = [cal components:0 fromDate:[self getCurrentDate]];
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

- (NSMutableArray *)yearOfTweenty {
    if (!_yearOfTweenty) {
        _yearOfTweenty = [NSMutableArray new];
        for (NSInteger i = 1900; i < 2000; i++) {
            [_yearOfTweenty addObject:[NSNumber numberWithInteger:i]];
        }
    }
    return _yearOfTweenty;
}

- (NSMutableArray *)yearOfNineTeen {
    if (!_yearOfNineTeen) {
        _yearOfNineTeen = [NSMutableArray new];
        for (NSInteger i = 1800 ; i < 1900; i++) {
            [_yearOfNineTeen addObject:[NSNumber numberWithInteger:i]];
        }
    }
    
    return _yearOfNineTeen;
}

- (NSMutableArray *)yearOfTweentyOne {
    if (!_yearOfTweentyOne) {
        _yearOfTweentyOne = [NSMutableArray new];
        for (NSInteger i = 2000 ; i < 2100; i++) {
            [_yearOfTweentyOne addObject:[NSNumber numberWithInteger:i]];
        }
    }
    
    return _yearOfTweentyOne;
}

- (NSMutableArray *)yearOfTweentyTwo {
    if (!_yearOfTweentyTwo) {
        _yearOfTweentyTwo = [NSMutableArray new];
        for (NSInteger i = 2100 ; i < 2200; i++) {
            [_yearOfTweentyTwo addObject:[NSNumber numberWithInteger:i]];
        }

    }
    return _yearOfTweentyTwo;
}

- (NSMutableArray *)CANS {
    if (!_CANS) {
        _CANS = [NSMutableArray new];
    }
    return _CANS;
}

- (NSMutableArray *)listCHI {
    if (!_CHIS) {
        _CHIS = [NSMutableArray new];
    }
    return _CHIS;
}

- (NSMutableArray *)listWeak {
    if (!_WEEKS) {
        _WEEKS = [NSMutableArray new];
    }
    
    return _WEEKS;
}

- (NSMutableArray *)monthsLunar {
   NSArray *listObject = @[@"Tháng Giêng",@"Tháng Hai",@"Tháng Ba",@"Tháng Tư",@"Tháng Năm",@"Tháng Sáu",@"Tháng Bảy",@"Tháng Tám",@"Tháng Chín",@"Tháng Mười",@"Tháng Mười Một",@"Tháng Chạp"];
    return [NSMutableArray arrayWithArray:listObject];
}

- (int)jdn:(int)dd and:(int)mm and:(int)yyyy {
    int a = (int)((14 - mm) / 12);
    int y = yyyy+4800-a;
    int m = mm+12*a-3;
    int jd = dd + floor((153*m+2)/5) + 365*y + floor(y/4) - floor(y/100) + (int)(y/400) - 32045;
    return jd;
    //return 367*yy - INT(7*(yy+INT((mm+9)/12))/4) - INT(3*(INT((yy+(mm-9)/7)/100)+1)/4) + INT(275*mm/9)+dd+1721029;
}

- (void)jdn2date:(int)jd {
    int a, b, c, d, e, m, day, month, year;

    if (jd > 2299160) {// After 5/10/1582, Gregorian calendar
        a = jd + 32044;
        b = floor((4*a+3)/146097);
        c = a - floor((b*146097)/4);
    } else {
        b = 0;
        c = jd + 32082;
    }
    
    d = floor((4*c+3)/1461);
    e = c - floor((1461*d)/4);
    m = floor((5*e+2)/153);
    day = e - floor((153*m+2)/5) + 1;
    month = m + 3 - 12*floor(m/10);
    year = b*100 + d - 4800 + floor(m/10);
//    return new Array(day, month, year);
    
}

- (NSMutableArray *)decodeLunarYear:(int)yy and:(int)k {
    int offsetOfTet, leapMonth, leapMonthLength, solarNY = 0, currentJD, j, mm;
    NSMutableArray *ly = [NSMutableArray new];
    NSMutableArray *monthLengths = [NSMutableArray arrayWithArray:@[@29,@30]];
    NSMutableArray *regularMonths = [NSMutableArray new];
    offsetOfTet = k >> 17;
    leapMonth = k & 0xf;
    leapMonthLength = (int)monthLengths[k >> 16 & 0x1];
    solarNY = [self jdn:1 and:1 and:yy];//jdn(1, 1, yy);
    currentJD = solarNY+offsetOfTet;
    j = k >> 4;
    
    for(int i = 0; i < 12; i++) {
        regularMonths[12 - i - 1] = monthLengths[j & 0x1];
        j >>= 1;
    }
    
    if (leapMonth == 0) {
        for(mm = 1; mm <= 12; mm++) {
            VRLunarDateModel *model = [[VRLunarDateModel alloc] initWith:1 andMonth:mm andYear:yy andLeap:0 andJD:currentJD];
            [ly addObject:model];
            currentJD += (int)regularMonths[mm-1];
        }
    } else {
        for(mm = 1; mm <= leapMonth; mm++) {
            VRLunarDateModel *model = [[VRLunarDateModel alloc] initWith:1 andMonth:mm andYear:yy andLeap:0 andJD:currentJD];
            [ly addObject:model];
            currentJD += (int)regularMonths[mm-1];
        }

        VRLunarDateModel *model = [[VRLunarDateModel alloc] initWith:1 andMonth:mm andYear:yy andLeap:1 andJD:currentJD];
        [ly addObject:model];
        currentJD += leapMonthLength;
        for(mm = leapMonth+1; mm <= 12; mm++) {
            VRLunarDateModel *md = [[VRLunarDateModel alloc] initWith:1 andMonth:mm andYear:yy andLeap:0 andJD:currentJD];
            [ly addObject:md];
            currentJD += (int)regularMonths[mm-1];
        }
    }
    return ly;
}

- (NSMutableArray *)getYearInfo:(int)yyyy {
    int yearCode;
    if (yyyy < 1900) {
        yearCode = (int)[self.yearOfNineTeen objectAtIndex:yyyy-1800];//TK19[yyyy - 1800];
    } else if (yyyy < 2000) {
        yearCode = (int)[self.yearOfTweenty objectAtIndex:yyyy - 1900];//TK20[yyyy - 1900];
    } else if (yyyy < 2100) {
        yearCode = (int)[self.yearOfTweentyOne objectAtIndex:yyyy - 2000];//TK21[yyyy - 2000];
    } else {
        yearCode = (int)[self.yearOfTweentyTwo objectAtIndex:yyyy - 2100];//TK22[yyyy - 2100];
    }
    return [self decodeLunarYear:yyyy and:yearCode];//decodeLunarYear(yyyy, yearCode);
}

//int FIRST_DAY = [se]//jdn(25, 1, 1800); // Tet am lich 1800
//int LAST_DAY = jdn(31, 12, 2199);
//
//int

- (VRLunarDateModel *)findLunarDate:(int)jd and:(NSMutableArray *)ly {
    int FIRST_DAY = [self jdn:25 and:1 and:1800];
    int LAST_DAY = [self jdn:31 and:12 and:2199];
    VRLunarDateModel *firstObject = [ly firstObject];
    if (jd > LAST_DAY || jd < FIRST_DAY || [firstObject.jd intValue] > jd) {
        return [[VRLunarDateModel alloc] initWith:0 andMonth:0 andYear:0 andLeap:0 andJD:jd];
    }
    int i = (int)ly.count-1;
   
    for (i = (int)ly.count - 1; i>=0; i--) {
        VRLunarDateModel *model =[ly objectAtIndex:i];
        if (jd >= [model.jd intValue]) {
            break;
        }
    }
    VRLunarDateModel *model =[ly objectAtIndex:i];
    int off = jd - [model.jd intValue];

    VRLunarDateModel *newModel = [[VRLunarDateModel alloc] initWith:([model.day intValue] + off) andMonth:model.month.intValue andYear:model.year.intValue andLeap:model.leap.intValue andJD:jd];
    return newModel;
}

- (VRLunarDateModel *) getLunarDate:(int)dd andMonth:(int)mm andYear:(int)yyyy {
    int jd;
    NSMutableArray *ly = [NSMutableArray new];
    if (yyyy < 1800 || 2199 < yyyy) {
        //return new LunarDate(0, 0, 0, 0, 0);
    }
    
    ly = [self getYearInfo:yyyy];//getYearInfo(yyyy);
    jd = [self jdn:dd and:mm and:yyyy];//jdn(dd, mm, yyyy);
    VRLunarDateModel *model = [ly firstObject];
    if (jd < model.jd.intValue) {
        ly = [self getYearInfo:yyyy-1];//getYearInfo(yyyy - 1);
    }
    return [self findLunarDate:jd and:ly];//findLunarDate(jd, ly);
}

- (NSDate *)ConvertSolarToLunar:(NSDate *)date {
    int d = [self getDayFromDate:date];
    int m = [self getMonthFromDate:date];
    int y = [self getYearFromDate:date];
    VRLunarDateModel *model = [self getLunarDate:d andMonth:m andYear:y];
    
    return nil;
}
@end
