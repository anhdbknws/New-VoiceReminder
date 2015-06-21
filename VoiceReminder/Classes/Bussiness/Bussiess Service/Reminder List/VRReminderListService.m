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
        if (completion) {
            completion(error, result);
        }
    }];
}
@end
