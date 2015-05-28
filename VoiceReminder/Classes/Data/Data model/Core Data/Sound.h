//
//  Sound.h
//  VoiceReminder
//
//  Created by Nextop HN 2 on 5/28/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseObject.h"

@class Reminder;

@interface Sound : BaseObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSNumber * isShortSound;
@property (nonatomic, retain) NSNumber * isMp3Sound;
@property (nonatomic, retain) NSNumber * isRecordSound;
@property (nonatomic, retain) NSNumber * isSystemSound;
@property (nonatomic, retain) Reminder *reminder;

@end
