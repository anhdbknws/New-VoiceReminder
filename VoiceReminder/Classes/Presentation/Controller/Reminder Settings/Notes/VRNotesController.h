//
//  VRNotesController.h
//  VoiceReminder
//
//  Created by GemCompany on 6/2/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRSettingBaseViewController.h"

@interface VRNotesController : VRSettingBaseViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintTop;
@property (weak, nonatomic) IBOutlet UITextView *textViewNotes;

@property (nonatomic, strong) NSString *notesValue;
@property (nonatomic, strong) NSString *text;

@property (nonatomic, copy) void (^doneNotesCompleted)(NSString *name);
@end
