//
//  VRReminderSettingCell.h
//  VoiceReminder
//
//  Created by GemCompany on 1/11/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQDropDownTextField.h"

@interface VRReminderSettingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet IQDropDownTextField *textfield;
@property (nonatomic, copy) void(^pressDoneAction)(id sender);

@end
