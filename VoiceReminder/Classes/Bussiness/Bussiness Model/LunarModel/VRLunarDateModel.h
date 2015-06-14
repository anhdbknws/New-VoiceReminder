//
//  VRLunarDateModel.h
//  VoiceReminder
//
//  Created by GemCompany on 6/14/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VRLunarDateModel : NSObject
@property (nonatomic, strong) NSNumber *day;
@property (nonatomic, strong) NSNumber *month;
@property (nonatomic, strong) NSNumber *year;
@property (nonatomic, strong) NSNumber *leap;
@property (nonatomic,strong) NSNumber *jd;

- (instancetype)initWith:(int)day andMonth:(int)month andYear:(int)year andLeap:(int)leap andJD:(int)jd;
@end
