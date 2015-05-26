//
//  VRSettingNotesCell.h
//  VoiceReminder
//
//  Created by GemCompany on 5/25/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRTextView.h"

@interface VRSettingNotesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet VRTextView *textViewNotes;
@property (weak, nonatomic) IBOutlet UIImageView *arrowView;

@end
