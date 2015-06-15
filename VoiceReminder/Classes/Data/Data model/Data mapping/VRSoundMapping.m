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
#import <MediaPlayer/MediaPlayer.h>
#import "SDAVAssetExportSession.h"


@implementation VRSoundMapping
+ (Sound *)entityFromModel:(VRSoundModel *)model andReminderName:(NSString *)reminderName inContext:(NSManagedObjectContext *)context {
    Sound *entity = [Sound entityWithUuid:model.uuid inContext:context];
    entity.createdDate = model.createdDate;
    if (!entity.createdDate) {
        entity.createdDate = [NSDate date];
    }
    
    entity.isMp3Sound = [NSNumber numberWithBool:model.isMp3Sound];
    entity.isRecordSound = [NSNumber numberWithBool:model.isRecordSound];
    entity.name = model.name;
    
    if (model.isRecordSound) {
       entity.url = [self saveAudioToDocumentFolder:model.url withName:reminderName];
        entity.name = reminderName;
    }
    else if (model.isMp3Sound) {
        entity.url = [self saveMediaItemToDocument:model];
    }
    else {
        entity.url = model.url;
    }
    
    return entity;
}

+ (NSString *)saveAudioToDocumentFolder:(NSString *)url withName:(NSString *)name{
    NSData *data = [[self class] getContentWithURL:url];

    NSString *fileName = [[self class] checkDuplicateFileName:name];

    NSString *dataPath = [[[self class] documentsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.m4a", fileName]];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        // Save it into document
        [data writeToFile:dataPath atomically:YES];
    });
    
    return dataPath;
}

+ (NSString *)saveMediaItemToDocument:(VRSoundModel *)model {
    
    AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL:model.mp3Url options:nil];
    
    //Now create an AVAssetExportSession object that will save your final audio file at specified path.
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset: songAsset presetName:AVAssetExportPresetAppleM4A];
    exporter.outputFileType = AVFileTypeAppleM4A;
    
    NSString *fileName = [[self class] checkDuplicateFileName:[VRCommon removeWhiteSpace:model.name]];
    NSString *exportFile = [[[self class] documentsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.m4a", fileName]];
    NSURL *exportURL = [NSURL fileURLWithPath:exportFile];
    exporter.outputURL = exportURL;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [exporter exportAsynchronouslyWithCompletionHandler:^{
            int exportStatus = exporter.status;
            
            switch (exportStatus) {
                case AVAssetExportSessionStatusFailed:
                    break;
                case AVAssetExportSessionStatusCompleted:
                {
                    NSData *data = [NSData dataWithContentsOfFile: exportFile];
                    if (data) {
                        
                        NSLog(@"completed");
                    }
                    else {
                        NSLog(@"export failed");
                    }
                }
                    break;
                case AVAssetExportSessionStatusUnknown:
                    NSLog(@"unknow");
                    break;
                default:
                    break;
            }
        }];
    });
    
    return [NSString stringWithFormat:@"%@", exportURL];
}

+ (NSData *)getContentWithURL:(NSString *)url {
    NSError *readingError = nil;
    NSData  *fileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]
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
