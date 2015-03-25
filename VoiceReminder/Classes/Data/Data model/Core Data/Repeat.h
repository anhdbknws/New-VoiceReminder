//
//  Repeat.h
//  VoiceReminder
//
//  Created by GemCompany on 3/25/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseObject.h"

@class Reminder;

@interface Repeat : BaseObject

@property (nonatomic, retain) NSNumber * repeatType;
@property (nonatomic, retain) Reminder *reminder;

@end
