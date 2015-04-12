//
//  VRSoundMapping.m
//  VoiceReminder
//
//  Created by GemCompany on 4/5/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRSoundMapping.h"
#import "Sound.h"
#import "VRReminderModel.h"
#import "NSManagedObject+voiceReminder.h"
#import "VRSoundModel.h"

@implementation VRSoundMapping
+ (Sound *)entityFromModel:(VRReminderModel *)model inContext:(NSManagedObjectContext *)context {
    Sound *entity = [Sound entityWithUuid:model.soundModel.uuid inContext:context];
    if (model.soundModel.url.length && !model.soundModel.isDefaultObject) {
        entity.url = [[self class] saveAudioToDocumentFolder:model];
    }
    else if (model.soundModel.url.length && model.soundModel.isDefaultObject) {
        entity.url = model.soundModel.url;
    }
    else {
        entity.persistenID = model.soundModel.persistenID;
    }
    
    entity.name = model.name;
    return entity;
}

+ (NSString *)saveAudioToDocumentFolder:(VRReminderModel *)model {
    // get content
    NSData *data = [[self class] getContentWithURL:model.soundModel];
    
    NSString *fileName = [[self class] checkDuplicateFileName:model.name];
    NSString *dataPath = [[self documentsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.m4a", fileName]];
    
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


+ (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}
+ (NSString *)filePathWithName:(NSString *)fileName
{
    NSString *documentsDirectory = [[self class] documentsDirectory];
    NSString *newPath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    return newPath;
}

+ (NSString *)checkDuplicateFileName:(NSString *)fileName
{
    NSString *tempFileName = fileName;
    if ([[NSFileManager defaultManager] fileExistsAtPath:[[self class] filePathWithName:fileName]]) {
        NSString * originName = tempFileName;
        NSString * extension = [tempFileName pathExtension];
        if (extension.length) {
            originName = [tempFileName stringByDeletingPathExtension];
        }
        NSInteger maxIterations = 99999;
        for (NSInteger numDuplicates = 1; numDuplicates < maxIterations; numDuplicates++) {
            tempFileName = [NSString stringWithFormat:@"%@(%ld)",originName,(long)numDuplicates];
            if (extension.length) {
                tempFileName = [tempFileName stringByAppendingPathExtension:extension];
            }
            if (![[NSFileManager defaultManager] fileExistsAtPath:[[self class] filePathWithName:tempFileName]])
                break;
        }
    }
    
    return tempFileName;
}
@end
