//
//  ViewController.h
//  VoiceReminder
//
//  Created by GemCompany on 4/7/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRReminderModel.h"

typedef NS_ENUM(NSInteger, REMINDER_DETAIL_ROW_TYPE) {
    REMINDER_DETAIL_ROW_TYPE_TIME = 0,
    REMINDER_DETAIL_ROW_TYPE_NAME = 1,
    REMINDER_DETAIL_ROW_TYPE_REPEAT = 2,
    REMINDER_DETAIL_ROW_TYPE_ALERT = 3,
    REMINDER_DETAIL_ROW_TYPE_MUSIC_SOUND = 4,
    REMINDER_DETAIL_ROW_TYPE_SHORT_SOUND = 5,
    REMINDER_DETAIL_ROW_TYPE_PHOTO = 6,
};

@interface VRReminderDetailController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableViewDetail;
@property (nonatomic,strong) VRReminderModel *model;
@end
