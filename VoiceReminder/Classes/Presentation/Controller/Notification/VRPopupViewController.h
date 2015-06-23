//
//  VRPopupViewController.h
//  VoiceReminder
//
//  Created by Điệp Nguyễn on 6/23/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRReminderModel.h"

@interface VRPopupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UIView *viewSeparator;
@property (weak, nonatomic) IBOutlet UITableView *tableviewPopup;
@property (weak, nonatomic) IBOutlet UIButton *buttonExit;
@property (weak, nonatomic) IBOutlet UIButton *buttonDetail;
- (IBAction)actionExit:(id)sender;
- (IBAction)actionDetail:(id)sender;

@property (nonatomic, strong) VRReminderModel *model;
@end
