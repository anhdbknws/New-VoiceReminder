//
//  VRSoundMapping.h
//  VoiceReminder
//
//  Created by GemCompany on 4/5/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Sound, VRReminderModel, VRSoundModel, NSManagedObjectContext;
@interface VRSoundMapping : NSObject
@property (nonatomic, copy) void(^saveAudioFileCompeted)(NSString *urrlString);

+ (Sound *)entityFromModel:(VRSoundModel *)model andReminderName:(NSString *)reminderName inContext:(NSManagedObjectContext *)context;
@end
