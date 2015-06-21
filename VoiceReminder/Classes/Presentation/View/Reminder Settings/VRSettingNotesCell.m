//
//  VRSettingNotesCell.m
//  VoiceReminder
//
//  Created by GemCompany on 5/25/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRSettingNotesCell.h"

@implementation VRSettingNotesCell

- (void)awakeFromNib {
    self.textViewNotes.textColor = [UIColor grayColor];
    self.textViewNotes.font = VRFontRegular(17);
    
    self.labelTitle.textColor = [UIColor blackColor];
    self.labelTitle.font = VRFontRegular(17);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
