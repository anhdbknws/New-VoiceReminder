//
//  VRNameViewController.h
//  VoiceReminder
//
//  Created by GemCompany on 3/24/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRNameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *nameTableview;
@property (nonatomic, copy) void (^doneNameCompleted)(NSString *name);
@property (nonatomic, strong) NSString *nameValue;
@end
