//
//  ShortSound.h
//  VoiceReminder
//
//  Created by GemCompany on 6/15/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseObject.h"

@class Reminder;

@interface ShortSound : BaseObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *reminder;
@end

@interface ShortSound (CoreDataGeneratedAccessors)

- (void)addReminderObject:(Reminder *)value;
- (void)removeReminderObject:(Reminder *)value;
- (void)addReminder:(NSSet *)values;
- (void)removeReminder:(NSSet *)values;

@end
