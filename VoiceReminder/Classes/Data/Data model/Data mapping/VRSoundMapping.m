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
+ (Sound *)entityFromModel:(VRSoundModel *)model inContext:(NSManagedObjectContext *)context {
    Sound *entity = [Sound entityWithUuid:model.uuid inContext:context];
    
    if (model.isMusicSound) {
//        entity.url = [[self class] saveAudioToDocumentFolder:model];
    }
    else if (model.isShortSound) {
//        entity.url = model.musicSoundModel.url;
    }
    else{
        
    }
    
    return entity;
}

+ (NSString *)saveAudioToDocumentFolder:(VRReminderModel *)model {
//    // get content
//    NSData *data = [[self class] getContentWithURL:model.musicSoundModel];
//    
//    NSString *fileName = [[self class] checkDuplicateFileName:model.name];
//    
//    NSString *dataPath = [[[self class] documentsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.m4a", fileName]];
//    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
//        // Save it into file system
//        [data writeToFile:dataPath atomically:YES];
//    });
//    
//    return dataPath;
}

+ (NSString *)saveMediaItemToDocument:(VRReminderModel *)model {
    
//    AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL: model.musicSoundModel.mp3Url options:nil];
//    
//    //Now create an AVAssetExportSession object that will save your final audio file at specified path.
//    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset: songAsset presetName:AVAssetExportPresetAppleM4A];
//    exporter.outputFileType = AVFileTypeAppleM4A;
//    
//    NSString *fileName = [[self class] checkDuplicateFileName:[VRCommon removeWhiteSpace:model.musicSoundModel.name]];
//    NSString *exportFile = [[[self class] documentsDirectory] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.m4a", fileName]];
//    NSURL *exportURL = [NSURL fileURLWithPath:exportFile];
//    exporter.outputURL = exportURL;
//    
//    exporter.shouldOptimizeForNetworkUse = YES;
//    CMTime start = CMTimeMakeWithSeconds(1.0, 100);
//    CMTime duration = CMTimeMakeWithSeconds(3.0, 100);
//    CMTimeRange range = CMTimeRangeMake(start, duration);
//    exporter.timeRange = range;
//    
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [exporter exportAsynchronouslyWithCompletionHandler:^{
//            int exportStatus = exporter.status;
//            
//            switch (exportStatus) {
//                case AVAssetExportSessionStatusFailed:
//                    break;
//                case AVAssetExportSessionStatusCompleted:
//                {
//                    NSData *data = [NSData dataWithContentsOfFile: exportFile];
//                    if (data) {
//                        
//                        NSLog(@"completed");
//                    }
//                    else {
//                        NSLog(@"export failed");
//                    }
//                }
//                    break;
//                case AVAssetExportSessionStatusUnknown:
//                    NSLog(@"unknow");
//                    break;
//                default:
//                    break;
//            }
//        }];
//    });
//    
//    return [NSString stringWithFormat:@"%@", exportURL];
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
