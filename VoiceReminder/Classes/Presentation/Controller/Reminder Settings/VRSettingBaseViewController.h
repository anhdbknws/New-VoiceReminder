//
//  VRSettingBaseViewController.h
//  VoiceReminder
//
//  Created by GemCompany on 6/6/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRSettingBaseViewController : UIViewController
- (void)doneButton;
- (void)backButton;
- (void)addButton;
- (void)addAction:(id)sender;
- (void)doneAction:(id)sender;
- (void)hideAddButton;
- (void)showAddButton;
@end
