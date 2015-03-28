//
//  VRLocalizationCenter.m
//  VoiceReminder
//
//  Created by GemCompany on 1/14/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRLocalizationCenter.h"

@implementation VRLocalizationCenter
+ (instancetype)shareInstance {
    static VRLocalizationCenter *share = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        share = [[VRLocalizationCenter alloc] init];
    });
    
    return share;
}

- (NSString *)LocalizationForKey:(NSString *)key {
    return NSLocalizedString(key, nil);
}


@end
