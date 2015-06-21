//
//  VRRepeatViewController.h
//  VoiceReminder
//
//  Created by GemCompany on 3/24/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRSettingBaseViewController.h"

@interface VRRepeatViewController : VRSettingBaseViewController
@property (weak, nonatomic) IBOutlet UITableView *repeatTableview;
@property (nonatomic,assign) REPEAT_TYPE repeatType;
@property (nonatomic,copy) void(^selectedCompleted)(REPEAT_TYPE type);
@end
