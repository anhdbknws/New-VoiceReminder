//
//  VRAlertViewController.h
//  VoiceReminder
//
//  Created by GemCompany on 3/25/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRAlertViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *alertTableView;
@property (nonatomic, strong) NSString *alertSelected;

@property (nonatomic, strong) void (^selectedAlertCompleted)(NSString *alert);
@end
