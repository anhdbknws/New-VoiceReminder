//
//  VRRemiderListService.m
//  VoiceReminder
//
//  Created by GemCompany on 3/11/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRReminderListService.h"
#import "Reminder.h"
#import "VRReminderModel.h"
#import "VRCommon.h"
#import "VRReminderMapping.h"

@interface VRReminderListService ()
@property (nonatomic, strong) NSString *uuid;
@end

@implementation VRReminderListService

- (instancetype)init {
    self = [super init];
    if (self) {
        _listReminderActive = [NSMutableArray new];
        _listReminderAll = [NSMutableArray new];
        _listReminderCompleted = [NSMutableArray new];
    }
    
    return self;
}

- (void)getListReminderFromDBWithcompletionHandler:(databaseHandler)completion {
    [self resetAll];
    
    NSArray *listEntity = [Reminder MR_findAll];
    NSDate *currentDate = [NSDate date];
    /* all reminder */
    for (Reminder *entity in listEntity) {
        VRReminderModel *model = [[VRReminderModel alloc] initWithEntity:entity];
        
        NSDate *dateReminder = [[VRCommon commonDateTimeFormat] dateFromString:model.timeReminder];
        
        if ([currentDate compare:dateReminder] == NSOrderedDescending) {
            if (!model.completed) {
                model.completed = YES;
                model.isActive = NO;
                [self updateCompleted:model];
            }
            
            [_listReminderCompleted addObject:model];
        }
        
        if (model.isActive) {
            [_listReminderActive addObject:model];
        }
        
        [_listReminderAll addObject:model];
    }
}

- (void)updateCompleted:(VRReminderModel *)model {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        Reminder *entity = [Reminder MR_findFirstByAttribute:@"uuid" withValue:model.uuid inContext:localContext];
        if (entity) {
            entity.isActive = @(NO);
            entity.completed = @(YES);
        }
    } completion:^(BOOL success, NSError *error) {
        
    }];
}

- (void)resetAll {
    [_listReminderActive removeAllObjects];
    [_listReminderAll removeAllObjects];
    [_listReminderCompleted removeAllObjects];
}

- (void)deleteReminderWithUUID:(NSString *)uuid completionHandler:(databaseHandler)completion {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        Reminder *entity = [Reminder MR_findFirstByAttribute:@"uuid" withValue:uuid];
        if (entity) {
            [entity MR_deleteEntity];
        }
    } completion:^(BOOL success, NSError *error) {
        for (UILocalNotification *item in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
            if ([[item.userInfo objectForKey:@"uuid"] isEqualToString:uuid]) {
                [[UIApplication sharedApplication] cancelLocalNotification:item];
            }
        }
        
        if (completion) {
            completion(error, nil);
        }
    }];
}

- (void)setStatusForReminder:(VRReminderModel *)model completionHandler:(databaseHandler)completion{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        Reminder *entity = [Reminder MR_findFirstByAttribute:@"uuid" withValue:model.uuid inContext:localContext];
        if (entity) {
            entity.isActive = [NSNumber numberWithBool:!model.isActive];
        }
    } completion:^(BOOL success, NSError *error) {
        Reminder *enti = [Reminder MR_findFirstByAttribute:@"uuid" withValue:model.uuid];
        VRReminderModel *result = nil;
        if (enti) {
            result = [[VRReminderModel alloc] initWithEntity:enti];
        }
        /* check and remove local notification*/
        if (model.isActive) {
            for (UILocalNotification *item in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
                if ([[item.userInfo objectForKey:@"uuid"] isEqualToString:model.uuid]) {
                    [[UIApplication sharedApplication] cancelLocalNotification:item];
                }
            }
        }
        else {
            [self scheduleLocalNotificationWith:model];
        }
        
        
        if (completion) {
            completion(error, result);
        }
    }];
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
