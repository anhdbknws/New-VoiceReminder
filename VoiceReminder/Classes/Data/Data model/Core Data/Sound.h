//
//  Sound.h
//  VoiceReminder
//
//  Created by GemCompany on 4/17/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseObject.h"

@class Reminder;

@interface Sound : BaseObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * isMp3Sound;
@property (nonatomic, retain) NSNumber * isRecordSound;
@property (nonatomic, retain) NSNumber * isSystemSound;
@property (nonatomic, retain) Reminder *reminder;

@end
