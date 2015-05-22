//
//  VRAspectRatioImageView.h
//  VoiceReminder
//
//  Created by GemCompany on 4/4/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRAspectRatioImageView : UIImageView
@property (nonatomic, strong) NSLayoutConstraint *constraintOfWidth;
@property (nonatomic, strong) NSLayoutConstraint *constraintOfHeight;
@end
