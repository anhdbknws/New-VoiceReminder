//
//  VRCommon.m
//  VoiceReminder
//
//  Created by GemCompany on 1/11/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRCommon.h"
static NSDateFormatter *formatDate = nil;
static NSDateFormatter *formatDateTime = nil;
static NSDateFormatter *formatMonthYear = nil;
static NSDateFormatter *formatYear = nil;

static NSDateFormatter *fm = nil;

@implementation VRCommon

+ (NSString *)formatDateAndTimeFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd, yyyy HH:mm"];
    NSString *stringFromDate = [dateFormatter stringFromDate:date];
    return stringFromDate;
}

+ (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd, yyyy HH:mm"];
    NSDate *date = [dateFormat dateFromString:dateString];
    return date;
}

+ (NSDate *)localDateFromUnixTime:(NSNumber *)unixTime {
    if ([unixTime isEqual:[NSNull null]] || !unixTime) {
        return nil;
    }
    else // because respond server calculate in miliseconds so we need divide for 1000.0
        return [NSDate dateWithTimeIntervalSince1970:unixTime.longLongValue / 1000.0];
}

+ (double)unixTimeFromDate:(NSDate *)date {
    if (!date) {
        return 0;
    }
    return [date timeIntervalSince1970];
}

+ (double)unixTimeMiliSecondFromDate:(NSDate *)date{
    if (!date) {
        return 0;
    }
    return [date timeIntervalSince1970] *1000;
}

+ (NSString *)commonFormatFromDate:(NSDate *)date {
    if (!fm) {
        fm  = [[NSDateFormatter alloc] init];
        [fm setTimeStyle:NSDateFormatterNoStyle];
        [fm setDateStyle:NSDateFormatterMediumStyle];
        [fm setLocale:[NSLocale currentLocale]];
    }
    return [fm stringFromDate:date];
}

+ (NSString *)commonFormatTimeFromDate:(NSDate *)date
{
    NSDateFormatter * formatterDate = [[NSDateFormatter alloc] init];
    [formatterDate setTimeStyle:NSDateFormatterShortStyle];
    [formatterDate setDateStyle:NSDateFormatterNoStyle];
    [formatterDate setLocale:[NSLocale currentLocale]];
    return [formatterDate stringFromDate:date];
}

+ (NSDateFormatter *)commonDateTimeFormat
{
    if (!formatDateTime) {
        formatDateTime  = [[NSDateFormatter alloc] init];
        [formatDateTime setTimeStyle:NSDateFormatterShortStyle];
        [formatDateTime setDateStyle:NSDateFormatterMediumStyle];
        
        [formatDateTime setLocale:[NSLocale currentLocale]];
    }
    return formatDateTime;
}

+ (NSDateFormatter *)commonDateFormat {
    if (!fm) {
        fm  = [[NSDateFormatter alloc] init];
        [fm setTimeStyle:NSDateFormatterNoStyle];
        [fm setDateStyle:NSDateFormatterMediumStyle];
        [fm setLocale:[NSLocale currentLocale]];
    }
    return fm;
}

+ (NSString *)commonFormatFromDateTime:(NSDate *)date {
    if (!formatDateTime) {
        formatDateTime  = [[NSDateFormatter alloc] init];
        [formatDateTime setTimeStyle:NSDateFormatterShortStyle];
        [formatDateTime setDateStyle:NSDateFormatterMediumStyle];
        
        [formatDateTime setLocale:[NSLocale currentLocale]];
    }
    return [formatDateTime stringFromDate:date];
}

+ (NSString *)commonFormatFromMonthYear:(NSDate *)date
{
    if (!formatMonthYear) {
        formatMonthYear  = [[NSDateFormatter alloc] init];
        NSString *mothFormat = [NSDateFormatter dateFormatFromTemplate:@"yMMM" options:0 locale:[NSLocale currentLocale]];
        [formatMonthYear setDateFormat:mothFormat];
        
    }
    return [formatMonthYear stringFromDate:date];
}

+ (NSString *)commonFormatFromYear:(NSDate *)date
{
    if (!formatYear) {
        formatYear  = [[NSDateFormatter alloc] init];
        NSString *yearFormat = [NSDateFormatter dateFormatFromTemplate:@"y" options:0 locale:[NSLocale currentLocale]];
        [formatYear setDateFormat:yearFormat];
    }
    return [formatYear stringFromDate:date];
}


+ (NSSortDescriptor *)sortDescriptorByCreatedDate
{
    return [NSSortDescriptor sortDescriptorWithKey:@"createdDate" ascending:NO];
}

+ (NSString *)removeWhiteSpace:(NSString *)inputString {
    if (!inputString) {
        return nil;
    }
    
    return [inputString stringByReplacingOccurrencesOfString:@" " withString:@""];
}

+ (NSDate *)addOneMonthToDate:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *newDate = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

+ (NSDate *)minusOneMonthFromDate:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:-1];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *oneMonthAgo = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    return oneMonthAgo;
}

+ (NSDate *)addOneDayToDate:(NSDate *)date {
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 1;
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    NSDate *nextDate = [theCalendar dateByAddingComponents:dayComponent toDate:date options:0];
    
    return nextDate;
}

+ (NSDate *)minusOneDayFromDate:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:-1];
    NSDate *oneDayAgo = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return oneDayAgo;
}

+ (NSDate *)addOneWeektoDate:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:7];
    NSDate *nextWeek = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return nextWeek;
}

+ (NSDate *)minusOneWeekFromDate:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:-7];
    NSDate *oneWeekAgo = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return oneWeekAgo;
}

+ (NSDate *)add:(NSInteger)numberMinutes toDate:(NSDate *)date {
//    NSDate *datePlusMinute = [date dateByAddingTimeInterval:60*numberMinutes];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMinute:numberMinutes];
    NSDate *datePlusMinute = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return datePlusMinute;
}

+ (NSDate *)minusMinutes:(NSInteger)numberMinutes toDate:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMinute:-numberMinutes];
    NSDate *minutesAgo = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return minutesAgo;
}

+ (NSDate *)minusDays:(NSInteger)numberDays toDate:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:-numberDays];
    NSDate *DaysAgo = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return DaysAgo;
}

+ (NSDate *)minusWeeks:(NSInteger)numberWeeks toDate:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:-7*numberWeeks];
    NSDate *weeksAgo = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return weeksAgo;
}

+ (NSDate *)minusMonths:(NSInteger)numberMonths toDate:(NSDate *)date {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:-numberMonths];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *monthsAgo = [calendar dateByAddingComponents:dateComponents toDate:date options:0];
    return monthsAgo;
}

+ (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

+ (NSString *)filePathWithName:(NSString *)fileName
{
    NSString *documentsDirectory = [[self class] documentsDirectory];
    NSString *newPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    return newPath;
}

+ (NSString *)checkDuplicateFileName:(NSString *)fileName
{
    NSString *tempFileName = fileName;
    if ([[NSFileManager defaultManager] fileExistsAtPath:[[self class] filePathWithName:fileName]]) {
        NSString * originName = tempFileName;
        NSString * extension = [tempFileName pathExtension];
        if (extension.length) {
            originName = [tempFileName stringByDeletingPathExtension];
        }
        NSInteger maxIterations = 99999;
        for (NSInteger numDuplicates = 1; numDuplicates < maxIterations; numDuplicates++) {
            tempFileName = [NSString stringWithFormat:@"%@(%ld)",originName,(long)numDuplicates];
            if (extension.length) {
                tempFileName = [tempFileName stringByAppendingPathExtension:extension];
            }
            if (![[NSFileManager defaultManager] fileExistsAtPath:[[self class] filePathWithName:tempFileName]])
                break;
        }
    }
    
    return tempFileName;
}
@end

