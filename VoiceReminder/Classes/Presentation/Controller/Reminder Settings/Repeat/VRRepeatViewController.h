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
@property (nonatomic,strong) NSMutableArray *arrayRepeatSelected;
@property (nonatomic,copy) void(^selectedCompleted)(NSMutableArray *selectedArray);
@end
