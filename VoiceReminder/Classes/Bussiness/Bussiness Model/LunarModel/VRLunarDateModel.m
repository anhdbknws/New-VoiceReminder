//
//  VRLunarDateModel.m
//  VoiceReminder
//
//  Created by GemCompany on 6/14/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRLunarDateModel.h"

@implementation VRLunarDateModel
- (instancetype)initWith:(int)day andMonth:(int)month andYear:(int)year andLeap:(int)leap andJD:(int)jd {
    self = [super init];
    if (self) {
        self.day = [NSNumber numberWithInt:day];
        self.month = [NSNumber numberWithInt:month];
        self.year = [NSNumber numberWithInt:year];
        self.leap = [NSNumber numberWithInt:leap];
        self.jd = [NSNumber numberWithInt:jd];
    }
    
    return self;
}
@end
