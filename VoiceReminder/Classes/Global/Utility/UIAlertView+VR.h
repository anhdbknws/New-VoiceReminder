//
//  UIAlertView+VR.h
//  VoiceReminder
//
//  Created by GemCompany on 6/21/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^UIActionAlertViewCallBackHandler)(UIAlertView *alertView, NSInteger buttonIndex);
@interface UIAlertView (VR)
- (id)VR_initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

- (void)showAlerViewWithHandler:(UIActionAlertViewCallBackHandler)handler;
@end
