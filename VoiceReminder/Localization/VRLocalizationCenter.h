//
//  VRLocalizationCenter.h
//  VoiceReminder
//
//  Created by GemCompany on 1/14/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
#define VRLocalizationForKey(key) [self LocalizationForKey:(key)];
@interface VRLocalizationCenter : NSObject
+ (instancetype)shareInstance;;

- (NSString *)LocalizationForKey:(NSString *)key;
@end
