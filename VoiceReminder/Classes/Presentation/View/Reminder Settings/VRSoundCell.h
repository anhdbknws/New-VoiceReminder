//
//  VRSoundCell.h
//  VoiceReminder
//
//  Created by GemCompany on 6/6/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRSoundCell : UITableViewCell
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UIImageView *arrowImage;
@property (nonatomic, strong) UIView *viewLine;

- (void)initView;
@end
