//
//  VRNameCell.m
//  VoiceReminder
//
//  Created by GemCompany on 3/15/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRNameCell.h"
#import <PureLayout.h>
#import "VRMacro.h"

@implementation VRNameCell
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
    [self.contentView addSubview:self.valueTextfield];
    [self.contentView addSubview:self.bottomLine];
    [self.contentView addSubview:self.topLine];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // layout component
    [_topLine autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [_topLine autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [_topLine autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_topLine autoSetDimension:ALDimensionHeight toSize:1];
    
    [_valueTextfield autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [_valueTextfield autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:7];
    [_valueTextfield autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:15];
    [_valueTextfield autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:7];
    
    [_bottomLine autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [_bottomLine autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [_bottomLine autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [_bottomLine autoSetDimension:ALDimensionHeight toSize:1];
}


- (UITextField *)valueTextfield {
    if (!_valueTextfield) {
        _valueTextfield = [[UITextField alloc] initForAutoLayout];
        _valueTextfield.textAlignment = NSTextAlignmentLeft;
        _valueTextfield.backgroundColor = [UIColor clearColor];
        _valueTextfield.borderStyle = UITextBorderStyleNone;
    }
    
    return _valueTextfield;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initForAutoLayout];
        _bottomLine.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
    }
    
    return _bottomLine;
}

- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [[UIView alloc] initForAutoLayout];
        _topLine.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
    }
    
    return _topLine;
}

@end
