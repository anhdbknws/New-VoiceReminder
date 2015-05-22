//
//  TableViewCell.m
//  VoiceReminder
//
//  Created by GemCompany on 3/11/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRReminderListCell.h"
#import "VRMacro.h"
@implementation VRReminderListCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
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
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.timeReminder];
    [self.contentView addSubview:self.lineSeparate];
    [self.contentView addSubview:self.switchButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // autolayout for components
    [_timeReminder autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_timeReminder autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [_timeReminder autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:_switchButton withOffset:18];
    [_timeReminder autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_name];
    
    [_name autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_timeReminder];
    [_name autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
    [_name autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:_switchButton withOffset:18];
    [_name autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:_lineSeparate];
    
    [_switchButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:15];
    [_switchButton autoSetDimension:ALDimensionWidth toSize:50];
    [_switchButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];

    [_lineSeparate autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [_lineSeparate autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [_lineSeparate autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [_lineSeparate autoSetDimension:ALDimensionHeight toSize:1];
}

- (UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] initForAutoLayout];
    }
    
    return _name;
}

- (UILabel *)timeReminder {
    if (!_timeReminder) {
        _timeReminder = [[UILabel alloc] initForAutoLayout];
    }
    
    return _timeReminder;
}

- (UIView *)lineSeparate {
    if (!_lineSeparate) {
        _lineSeparate = [[UIView alloc] initForAutoLayout];
    }
    
    return _lineSeparate;
}

- (UISwitch *)switchButton {
    if (!_switchButton) {
        _switchButton = [[UISwitch alloc] initForAutoLayout];
        [_switchButton addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _switchButton;
}

- (void)changeSwitch:(id)sender {
    NSLog(@"dsds");
}
@end
