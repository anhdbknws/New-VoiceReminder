//
//  Reminder.h
//  VoiceReminder
//
//  Created by GemCompany on 6/21/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseObject.h"

@class Photo, ShortSound, Sound;

@interface Reminder : BaseObject

@property (nonatomic, retain) NSNumber * alertReminder;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * notes;
@property (nonatomic, retain) NSNumber * repeatReminder;
@property (nonatomic, retain) NSDate * timeReminder;
@property (nonatomic, retain) NSSet *photos;
@property (nonatomic, retain) ShortSound *shortSound;
@property (nonatomic, retain) Sound *sound;
@end

@interface Reminder (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(Photo *)value;
- (void)removePhotosObject:(Photo *)value;
- (void)addPhotos:(NSSet *)values;
- (void)removePhotos:(NSSet *)values;

@end
