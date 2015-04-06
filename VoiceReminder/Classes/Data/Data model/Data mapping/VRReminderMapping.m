//
//  VRReminderMapping.m
//  VoiceReminder
//
//  Created by GemCompany on 2/1/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRReminderMapping.h"
#import "NSManagedObject+voiceReminder.h"
#import "VRCommon.h"
#import "VRRepeatModel.h"
#import "VRRepeatMapping.h"
#import "Photo.h"
#import "VRSoundModel.h"

@implementation VRReminderMapping
+ (Reminder*)entityFromModel:(VRReminderModel *)model inContext:(NSManagedObjectContext *)context {
    Reminder *entity = [Reminder entityWithUuid:model.uuid inContext:context];
    entity.name = model.name;
    entity.alertReminder = [NSNumber numberWithInteger:model.alertReminder];
    entity.timeReminder = [[VRCommon commonDateTimeFormat] dateFromString:model.timeReminder];
    entity.urlSound = [[self class] saveAudioToDocumentFolder:model];
    
    entity.nameSound = model.nameOfSound;
    entity.createdDate = model.createdDate;
    entity.isActive = [NSNumber numberWithBool:YES];
    
    [entity removeRepeats:entity.repeats];
    for (VRRepeatModel *object in model.repeats) {
        [entity addRepeatsObject:[VRRepeatMapping entityFromModel:object inContext:context]];
    }
    
    [entity removePhotos:entity.photos];
    for (NSString *url in model.photoList) {
        Photo * photo = [Photo MR_createInContext:context];
        photo.uuid = [NSUUID UUID].UUIDString;
        photo.url = url;
        photo.index = @([model.photoList indexOfObject:url]);
        [entity addPhotosObject:photo];
    }
    return entity;
}

+ (NSString *)saveAudioToDocumentFolder:(VRReminderModel *)model {
    // get content
    NSData *data = [[self class] getContentWithURL:model];
    
    // Generate the file path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.m4a", model.name]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        // Save it into file system
        [data writeToFile:dataPath atomically:YES];
    });
    return dataPath;
}

+ (NSData *)getContentWithURL:(VRReminderModel *)model {
    NSError *readingError = nil;
    NSData  *fileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.soundModel.url]
                                                      options:NSDataReadingMapped
                                                        error:&readingError];
    return fileData;
}

@end
