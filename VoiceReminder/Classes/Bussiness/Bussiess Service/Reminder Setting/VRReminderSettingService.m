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
#import "VRShortSoundModel.h"
#import "ShortSound.h"
#import "Sound.h"

@interface VRReminderSettingService()<AVAudioPlayerDelegate>
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@end

@implementation VRReminderSettingService
{
    NSMutableArray *listNotification;
}
- (void)addReminder:(VRReminderModel *)model toDatabaseLocalWithCompletionhandler:(databaseHandler)completion {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        [VRReminderMapping entityFromModel:model inContext:localContext];
    } completion:^(BOOL success, NSError *error) {
        VRReminderModel * result;
        Reminder * entity =  [Reminder MR_findFirstByAttribute:VRUUID withValue:model.uuid];
        if (entity) {
            result = [[VRReminderModel alloc] initWithEntity:entity];
            [self performSelector:@selector(scheduleLocalNotificationWith:) withObject:result afterDelay:0];
        }
        if (completion) {
            completion(error, result);
        }
    }];
}

- (void)performFetchReminderWith:(NSString *)uuid {
    if (uuid.length) {
        Reminder *entity = [Reminder MR_findFirstByAttribute:@"uuid" withValue:uuid];
        if (entity) {
            _modelOringinal = [[VRReminderModel alloc] initWithEntity:entity];
        }
    }
    
    if (!_modelOringinal) {
        _modelOringinal = [VRReminderModel new];
        
        _modelOringinal.name = @"Name";
        
        _modelOringinal.alertReminder = ALERT_TYPE_AT_EVENT_TIME;
        
        _modelOringinal.timeReminder = [VRCommon commonFormatFromDateTime:[NSDate date]];
        
        _modelOringinal.photoList = [NSMutableArray new];
        
        /* short sound*/
        NSArray *listSound = [ShortSound MR_findAll];
        _modelOringinal.shortSoundModel = [[VRShortSoundModel alloc] initWithEntity:listSound[0]];
        
        
        /* music sound */
        _modelOringinal.soundModel = [[VRSoundModel alloc] init];
        _modelOringinal.soundModel.name = _modelOringinal.shortSoundModel.name;
        _modelOringinal.soundModel.isSystemSound = YES;
    }
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
    notification.fireDate = [self getFireDate:model];
    
    NSString *stringAlertBody = nil;
    if (model.notes.length) {
        stringAlertBody = [NSString stringWithFormat:@"(%@) %@",model.timeReminder, model.notes];
    }
    else  {
        stringAlertBody = model.timeReminder;
    }
    notification.alertBody = stringAlertBody;
    notification.alertTitle = model.name;
    /* Action settings */
    notification.hasAction = YES;
    
    /* Badge settings */
    notification.applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
    
    /* sound */
    notification.soundName = [NSString stringWithFormat:@"%@.%@", model.shortSoundModel.name, @"caf"];
    
    /* Additional information, user info */
    notification.userInfo = @{@"uuid" : model.uuid};
    /* Schedule the notification */
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (NSDate *)getFireDate:(VRReminderModel *)model {
    // set fire date
    NSDate *actuallyFireDate = nil;
    if (model.alertReminder == ALERT_TYPE_AT_EVENT_TIME) {
        actuallyFireDate = [[VRCommon commonDateTimeFormat] dateFromString:model.timeReminder];
    }
    else if (model.alertReminder == ALERT_TYPE_5_MINUTES_BEFORE) {
        actuallyFireDate = [VRCommon minusMinutes:5 toDate:[[VRCommon commonDateTimeFormat] dateFromString:model.timeReminder]];
    }
    else if (model.alertReminder == ALERT_TYPE_30_MINUTES_BEFORE) {
        actuallyFireDate = [VRCommon minusMinutes:30 toDate:[[VRCommon commonDateTimeFormat] dateFromString:model.timeReminder]];
    }
    else if (model.alertReminder == ALERT_TYPE_2_HOUR_BEFORE) {
        actuallyFireDate = [VRCommon minusMinutes:120 toDate:[[VRCommon commonDateTimeFormat] dateFromString:model.timeReminder]];
    }
    else if (model.alertReminder == ALERT_TYPE_1_HOUR_BEFORE) {
        actuallyFireDate = [VRCommon minusMinutes:60 toDate:[[VRCommon commonDateTimeFormat] dateFromString:model.timeReminder]];
    }
    else if (model.alertReminder == ALERT_TYPE_1_DAY_BEFORE) {
        actuallyFireDate = [VRCommon minusDays:1 toDate:[[VRCommon commonDateTimeFormat] dateFromString:model.timeReminder]];
    }
    else {
        actuallyFireDate = [VRCommon minusDays:2 toDate:[[VRCommon commonDateTimeFormat] dateFromString:model.timeReminder]];
    }
    
    return actuallyFireDate;
}

@end
