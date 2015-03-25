//
//  VRLocalizationCenter.h
//  VoiceReminder
//
//  Created by GemCompany on 1/14/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>

#define VRLocalizationString(key) [[VRLocalizationCenter sharedInstance] localizedStringForKey:(key)]

@interface VRLocalizationCenter : NSObject

+ (instancetype)sharedInstance;
- (NSString *)localizedStringForKey:(NSString *)key;
@end
