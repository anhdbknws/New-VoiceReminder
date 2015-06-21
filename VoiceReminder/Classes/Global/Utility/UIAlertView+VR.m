//
//  UIAlertView+VR.m
//  VoiceReminder
//
//  Created by GemCompany on 6/21/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "UIAlertView+VR.h"
#import <objc/runtime.h>

@implementation UIAlertView (VR)
- (id) VR_initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    /*For iOS 8+*/
    return [[[self class] alloc] initWithTitle:@"" message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
}

//Runtime association key.
static NSString *handlerRunTimeAccosiationKey = @"alertViewBlocksDelegate";

- (void)showAlerViewWithHandler:(UIActionAlertViewCallBackHandler)handler {
    
    //set runtime accosiation of object
    //param -  sourse object for association, association key, association value, policy of association
    objc_setAssociatedObject(self, (__bridge  const void *)(handlerRunTimeAccosiationKey), handler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setDelegate:self];
    [self show];  //call UIAlertView show method
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UIActionAlertViewCallBackHandler completionHandler = objc_getAssociatedObject(self, (__bridge  const void *)(handlerRunTimeAccosiationKey));
    
    if (completionHandler != nil) {
        
        completionHandler(alertView, buttonIndex);
    }
}
@end
