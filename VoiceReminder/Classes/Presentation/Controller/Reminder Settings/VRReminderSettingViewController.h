//
//  VRReminderSettingViewController.h
//  VoiceReminder
//
//  Created by GemCompany on 1/11/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleProgressView.h"
#import "UIPlaceHolderTextView.h"
#import "VRSettingBaseViewController.h"
#import "VRSoundModel.h"

typedef NS_ENUM(NSInteger, REMINDER_SETTING_TYPE) {
    REMINDER_SETTING_TYPE_NAME          = 0,
    REMINDER_SETTING_TYPE_ALERT         = 1,
    REMINDER_SETTING_TYPE_MUSIC_SOUND   = 2,
    REMINDER_SETTING_TYPE_SHORT_SOUND   = 3,
    REMINDER_SETTING_TYPE_NOTES         = 4
};

@interface VRReminderSettingViewController : VRSettingBaseViewController
@property (weak, nonatomic) IBOutlet UITableView *settingTableview;
@property (nonatomic, strong) VRSoundModel *soundModel;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) UIView * activeField;
@property (nonatomic, strong) UIPlaceHolderTextView * noteTextView;
@property (nonatomic, strong) NSString *uuid;

@property (nonatomic, assign) BOOL isEditMode;

- (instancetype)initWithUUID:(NSString *)uuid;

@property (nonatomic, copy) void (^editCompleted)(id object);
@end
