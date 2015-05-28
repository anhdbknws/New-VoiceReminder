//
//  UIPlaceHolderTextView.h
//  Method
//
//  Created by NextopHN on 4/17/15.
//  Copyright (c) 2015 Nextop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView

@property(nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *realTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *placeholderColor UI_APPEARANCE_SELECTOR;

@end
