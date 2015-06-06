//
//  VRSoundCell.m
//  VoiceReminder
//
//  Created by GemCompany on 6/6/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRSoundCell.h"

@implementation VRSoundCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    
    return self;
}
- (void)awakeFromNib {
    [self initView];
}


- (void)initView {
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.labelTitle];
    [self.contentView addSubview:self.arrowImage];
    [self.contentView addSubview:self.viewLine];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // lauyout
    [_imageV autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:5];
    [_imageV autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_imageV autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [_imageV autoSetDimension:ALDimensionWidth toSize:34];
    
    [_labelTitle autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_labelTitle autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [_labelTitle autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:_imageV withOffset:10];
    [_labelTitle autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    
    [_arrowImage autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_arrowImage autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:15];
    [_arrowImage autoSetDimension:ALDimensionWidth toSize:20];
    
    [_viewLine autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [_viewLine autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    [_viewLine autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [_viewLine autoSetDimension:ALDimensionHeight toSize:1];
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] initForAutoLayout];
    }
    
    return _imageV;
}

- (UIImageView *)arrowImage {
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc] initForAutoLayout];
    }
    
    return _arrowImage;
}

- (UILabel *)labelTitle {
    if (!_labelTitle) {
        _labelTitle = [[UILabel alloc] initForAutoLayout];
        _labelTitle.textColor = [UIColor blackColor];
    }
    
    return _labelTitle;
}

- (UIView *)viewLine {
    if (!_viewLine) {
        _viewLine = [[UIView alloc] initForAutoLayout];
        _viewLine.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
    }
    
    return _viewLine;
}
@end
