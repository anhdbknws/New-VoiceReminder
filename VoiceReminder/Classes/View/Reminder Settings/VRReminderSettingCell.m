//
//  VRReminderSettingCell.m
//  VoiceReminder
//
//  Created by GemCompany on 1/11/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRReminderSettingCell.h"

@implementation VRReminderSettingCell

- (void)awakeFromNib {
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleDefault];
    toolbar.tintColor = [UIColor blueColor];
    [toolbar sizeToFit];
    UIBarButtonItem *buttonflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *buttonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
    
    [toolbar setItems:[NSArray arrayWithObjects:buttonflexible,buttonDone, nil]];
    self.textfield.inputAccessoryView = toolbar;
    self.titleLabel.textColor = [UIColor blackColor];
    self.textfield.textColor = [UIColor blueColor];
    self.textfield.textAlignment = NSTextAlignmentRight;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)doneClicked:(id)sender {
    if (self.pressDoneAction) {
        self.pressDoneAction(sender);
    }
}

@end
