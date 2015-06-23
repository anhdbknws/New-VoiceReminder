//
//  VRMacro.h
//  VoiceReminder
//
//  Created by GemCompany on 2/1/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef VoiceReminder_VRMacro_h
#define VoiceReminder_VRMacro_h

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define OBJECT_NULL  (id)[NSNull null]
#define IS_IPHONE_4 (([[UIScreen mainScreen] bounds].size.height-480)?NO:YES)

#define IS_IPHONE_5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

#define IS_RETINA [[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES && [[UIScreen mainScreen] scale] == 2.00

#define IS_IPHONE_6 (([[UIScreen mainScreen] bounds].size.height-667)?NO:YES)

#define IS_IPHONE_6_PLUS (([[UIScreen mainScreen] bounds].size.height-736)?NO:YES)

#define IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define IS_IOS_8 ([[UIDevice currentDevice].systemVersion floatValue] >= 8)

#define VRUUID @"uuid"
#define EMPTY_STRING @""

// font styles

#define VRFontRegular(v) [UIFont fontWithName:@"Roboto-Regular" size:v]
#define VRFontBold(v) [UIFont fontWithName:@"Roboto-Bold" size:v]
#define VRTitleFont(v) [UIFont fontWithName:@"Berlin Sans FB Demi" size:v]

#define H1_FONT VRFontBold(19)
#define H2_FONT VRFontBold(19)
#define H3_FONT VRFontBold(19)
#define H4_FONT VRFontRegular(15)
#define H5_FONT VRFontRegular(15)
#define H6_FONT VRFontRegular(15)
#define H7_FONT VRFontBold(15)
#define H8_FONT VRFontBold(16)
#define H9_FONT VRFontRegular(12)
#define H10_FONT VRFontRegular(12)
#define H11_FONT VRFontRegular(15)
#define H12_FONT VRFontBold(15)
#define H13_FONT VRFontBold(17)

// font color
#define RGBCOLOR(RED, GREEN, BLUE, ALPHA) [UIColor colorWithRed:RED/255.0f green:GREEN/255.0f blue:BLUE/255.0f alpha:ALPHA]

#define H1_COLOR RGBCOLOR(51,73,93,1)
#define H2_COLOR RGBCOLOR(254,0,32,1)
#define H3_COLOR RGBCOLOR(247,247,247,1)
#define H4_COLOR RGBCOLOR(248,237,242,1)
#define H5_COLOR RGBCOLOR(238, 237, 242, 1)

typedef void(^databaseHandler)(NSError * error, id result);

#define kSaveShortSoundToDBLocal @"SaveShortSoundToDBLocal"
#define kNameDefaultAudioRecord @"Audio record"
#endif
