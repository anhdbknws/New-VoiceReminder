//
//  VCTextView.h
//  Vaccinations
//
//  Created by Nguyen Le Duan on 11/21/14.
//  Copyright (c) 2014 Gem Vietnam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRTextView : UITextView
@property (copy, nonatomic) NSString *placeholder;
@property (copy, nonatomic) NSAttributedString *attributedPlaceholder;
@property (retain, nonatomic) UIColor *placeholderTextColor UI_APPEARANCE_SELECTOR;
@end
