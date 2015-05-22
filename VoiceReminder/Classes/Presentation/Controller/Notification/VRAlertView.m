//
//  VRAlertView.m
//  VoiceReminder
//
//  Created by GemCompany on 4/10/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRAlertView.h"

@implementation VRAlertView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initView];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }
    
    return self;
}

- (void)initView {
    [self addSubview:self.imageView];
    
    /* layout */
    [_imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_imageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [_imageView autoCenterInSuperview];
    [_imageView autoSetDimension:ALDimensionWidth toSize:self.frame.size.height];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initForAutoLayout];
        _imageView.layer.cornerRadius = _imageView.frame.size.width/2;
        _imageView.layer.borderWidth = 2.0f;
        _imageView.layer.borderColor = [UIColor blackColor].CGColor;
        _imageView.clipsToBounds = YES;
    }
    
    return _imageView;
}

@end
