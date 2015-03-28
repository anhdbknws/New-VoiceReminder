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
@end
