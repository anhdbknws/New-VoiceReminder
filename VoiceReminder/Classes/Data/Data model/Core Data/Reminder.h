//
//  Reminder.h
//  VoiceReminder
//
//  Created by GemCompany on 4/7/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseObject.h"

@class Photo, Repeat, Sound;

@interface Reminder : BaseObject

@property (nonatomic, retain) NSNumber * alertReminder;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * timeReminder;
@property (nonatomic, retain) NSSet *photos;
@property (nonatomic, retain) NSSet *repeats;
@property (nonatomic, retain) Sound *sound;
@end

@interface Reminder (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet *)values;
- (void)removePhotos:(NSSet *)values;

- (void)addRepeatsObject:(Repeat *)value;
- (void)removeRepeatsObject:(Repeat *)value;
- (void)addRepeats:(NSSet *)values;
- (void)removeRepeats:(NSSet *)values;

@end
