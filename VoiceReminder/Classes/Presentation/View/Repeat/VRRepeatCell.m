//
//  VRRepeatCell.m
//  VoiceReminder
//
//  Created by GemCompany on 3/25/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRRepeatCell.h"

@implementation VRRepeatCell
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.rightArrow];
    [self.contentView addSubview:self.bottomLine];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //layout
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [_titleLabel autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:_imageV withOffset:10];
    
    [_imageV autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:15];
    [_imageV autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_imageV autoSetDimension:ALDimensionWidth toSize:25];
    
    [_rightArrow autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:15];
    [_rightArrow autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_rightArrow autoSetDimension:ALDimensionWidth toSize:8];
    
    [_bottomLine autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [_bottomLine autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [_bottomLine autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [_bottomLine autoSetDimension:ALDimensionHeight toSize:1];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initForAutoLayout];
        _titleLabel.numberOfLines = 0;
    }
    
    return _titleLabel;
}

- (UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] initForAutoLayout];
    }
    
    return _imageV;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initForAutoLayout];
        _bottomLine.backgroundColor = [UIColor colorWithRed:224/255.0 green:223/255.0 blue:226/255.0 alpha:1];
    }
    
    return _bottomLine;
}

- (UIImageView *)rightArrow {
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc] initForAutoLayout];
    }
    
    return _rightArrow;
}
@end
