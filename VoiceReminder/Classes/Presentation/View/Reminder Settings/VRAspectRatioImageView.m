//
//  VRAspectRatioImageView.m
//  VoiceReminder
//
//  Created by GemCompany on 4/4/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRAspectRatioImageView.h"

@implementation VRAspectRatioImageView

- (void)layoutSubviews {
    [super layoutSubviews];
    UIImage * image = self.image;
    if (self.constraintOfHeight) {
        float ratio = self.superview.bounds.size.width/image.size.width;
        float scaledHeight = image.size.height * ratio;
        self.constraintOfHeight.constant = scaledHeight;
    }
    else {
        float ratio = self.superview.bounds.size.height/image.size.height;
        float scaledWidth = image.size.width * ratio;
        self.constraintOfWidth.constant = scaledWidth;
    }
}

@end
