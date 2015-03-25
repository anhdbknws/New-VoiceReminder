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

@interface VRReminderListService ()
@property (nonatomic, strong) NSString *uuid;
@end

@implementation VRReminderListService

- (instancetype)init {
    self = [super init];
    if (self) {
        _listReminder = [NSMutableArray new];
    }
    
    return self;
}

- (void)getListReminderAll {
    [_listReminder removeAllObjects];
    NSArray *listEntity = [Reminder MR_findAll];
    for (Reminder *entity in listEntity) {
        VRReminderModel *model = [[VRReminderModel alloc] initWithEntity:entity];
        [_listReminder addObject:model];
    }
}

- (void)getListReminderActive {
    [_listReminder removeAllObjects];
    NSArray *listEntity = [Reminder MR_findAll];
    for (Reminder *entity in listEntity) {
        VRReminderModel *model = [[VRReminderModel alloc] initWithEntity:entity];
        if (model.isActive) {
            [_listReminder addObject:model];
        }
    }
}

- (void)getListReminderCompleted {
    [_listReminder removeAllObjects];
    NSArray *listEntity = [Reminder MR_findAll];
    NSDate *currentDate = [NSDate date];
    for (Reminder *entity in listEntity) {
        VRReminderModel *model = [[VRReminderModel alloc] initWithEntity:entity];
        if ([currentDate compare:[[VRCommon commonDateFormat] dateFromString:model.timeReminder]] == NSOrderedDescending) {
            [_listReminder addObject:model];
        }
    }
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
@end
