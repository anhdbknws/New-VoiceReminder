//
//  VRReminderSettingViewController.h
//  VoiceReminder
//
//  Created by GemCompany on 1/11/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, REMINDER_SETTING_TYPE) {
    REMINDER_SETTING_TYPE_REMINDER_TIME = 0,
    REMINDER_SETTING_TYPE_REPEAT        = 1,
    REMINDER_SETTING_TYPE_ALERT         = 2,
    REMINDER_SETTING_TYPE_SOUND         = 3
};

@interface VRReminderSettingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet UITableView *settingTableview;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end
