//
//  VRSoundMapping.m
//  VoiceReminder
//
//  Created by GemCompany on 4/5/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRSoundMapping.h"
#import "Sound.h"
#import "VRSoundModel.h"
#import "NSManagedObject+voiceReminder.h"

@implementation VRSoundMapping
+ (Sound *)entityFromModel:(VRSoundModel *)model inContext:(NSManagedObjectContext *)context {
    Sound *entity = [Sound entityWithUuid:model.uuid inContext:context];
    if (!model.url.length) {
//        entity.url = [[self class] saveAudioToDocumentFolder:model];
    }
    else {
        entity.persistenID = model.persistenID;
    }
    
    entity.name = model.name;
    return entity;
}

+ (NSString *)saveAudioToDocumentFolder:(VRSoundModel *)model {
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

+ (NSData *)getContentWithURL:(VRSoundModel *)model {
    NSError *readingError = nil;
    NSData  *fileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.url]
                                              options:NSDataReadingMapped
                                                error:&readingError];
    return fileData;
}
@end
