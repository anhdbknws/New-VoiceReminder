//
//  VRReminderSettingService.m
//  VoiceReminder
//
//  Created by GemCompany on 2/1/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRReminderSettingService.h"
#import "VRCommon.h"
#import "VRSoundModel.h"

@interface VRReminderSettingService()<AVAudioPlayerDelegate>
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@end

@implementation VRReminderSettingService
- (void)addReminder:(VRReminderModel *)model toDatabaseLocalWithCompletionhandler:(databaseHandler)completion {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        [VRReminderMapping entityFromModel:model inContext:localContext];
    } completion:^(BOOL success, NSError *error) {
        VRReminderModel * result;
        Reminder * entity =  [Reminder MR_findFirstByAttribute:VRUUID withValue:model.uuid];
        if (entity) {
            result = [[VRReminderModel alloc] initWithEntity:entity];
            [self performSelector:@selector(scheduleLocalNotificationWith:) withObject:result afterDelay:5];
        }
        if (completion) {
            completion(error, result);
        }
    }];
}

- (BOOL)validateModel:(VRReminderModel *)model errorMessage:(NSString *__autoreleasing *)errorMessage {
    if (!model.name.length) {
        *errorMessage = @"Name is Required";
        return NO;
    }
    
    return YES;
}

/* register system */
- (void)scheduleLocalNotificationWith:(VRReminderModel *)model {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    /* Time and timezone settings */
    notification.fireDate = [[VRCommon commonDateTimeFormat] dateFromString:model.timeReminder];
    notification.timeZone = [NSTimeZone localTimeZone];
    notification.repeatInterval = 0;
    notification.alertBody = NSLocalizedString(@"A new item is downloaded.", nil);
    notification.alertLaunchImage = @"icon_camera";
    /* Action settings */
    notification.hasAction = YES;
    notification.alertAction = NSLocalizedString(@"View", nil);
    /* Badge settings */
    notification.applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
    /* sound */
    for (VRSoundModel *soundModel in model.soundModels) {
        if (soundModel.isShortSound) {
            notification.soundName = model.name;
        }
    }
    
    /* Additional information, user info */
    notification.userInfo = @{model.uuid : @"uuid", @"Alarm": @"VoiceReminder"};
    /* Schedule the notification */
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (NSString *)getRepeatStringFrom:(NSMutableArray *)listRepeat {
    NSString *fullString = nil;
    if (listRepeat.count == 7) {
        fullString = @"Every day";
    }
    else if (!listRepeat.count) {
        fullString = @"Never";
    }
    else if (listRepeat.count == 1) {
        fullString = [listRepeat objectAtIndex:0];
    }
    else {
        NSMutableArray *temp = [NSMutableArray new];
        NSMutableArray *tempRepeat = [self sortOrderDayInWeekly:listRepeat];
        for (NSString *item in tempRepeat) {
            if ([item isEqualToString:@"Every Monday"]) {
                [temp addObject:@"Mon"];
            }
            else if ([item isEqualToString:@"Every Tuesday"]) {
                [temp addObject:@"Tue"];
            }
            else if ([item isEqualToString:@"Every Wednesday"]) {
                [temp addObject:@"Wed"];
            }
            else if ([item isEqualToString:@"Every Thursday"]) {
                [temp addObject:@"Thu"];
            }
            else if ([item isEqualToString:@"Every Friday"]) {
                [temp addObject:@"Fri"];
            }
            else if ([item isEqualToString:@"Every Saturday"]) {
                [temp addObject:@"Sat"];
            }
            else {
                [temp addObject:@"Sun"];
            }
        }
        
        fullString = [temp componentsJoinedByString:@" "];
    }
    
    return fullString;
}

- (NSMutableArray *)sortOrderDayInWeekly:(NSMutableArray *)listRepeat {
    NSMutableArray *temp = [NSMutableArray new];
    for (NSString *item in listRepeat) {
        if ([item isEqualToString:@"Every Monday"]) {
            [temp addObject:item];
        }
    }
    
    for (NSString *item in listRepeat) {
        if ([item isEqualToString:@"Every Tuesday"]) {
            [temp addObject:item];
        }
    }
    
    for (NSString *item in listRepeat) {
        if ([item isEqualToString:@"Every Wednesday"]) {
            [temp addObject:item];
        }
    }
    
    for (NSString *item in listRepeat) {
        if ([item isEqualToString:@"Every Thursday"]) {
            [temp addObject:item];
        }
    }
    
    for (NSString *item in listRepeat) {
        if ([item isEqualToString:@"Every Friday"]) {
            [temp addObject:item];
        }
    }
    
    for (NSString *item in listRepeat) {
        if ([item isEqualToString:@"Every Saturday"]) {
            [temp addObject:item];
        }
    }
    
    for (NSString *item in listRepeat) {
        if ([item isEqualToString:@"Every Sunday"]) {
            [temp addObject:item];
        }
    }
    
    return temp;
}
@end
