//
//  VRSoundMapping.h
//  VoiceReminder
//
//  Created by GemCompany on 4/5/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Sound, VRReminderModel, NSManagedObjectContext;
@interface VRSoundMapping : NSObject
+ (Sound *)entityFromModel:(VRReminderModel *)model inContext:(NSManagedObjectContext *)context;
@end
