//
//  VRMainScreenViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 1/10/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRMainScreenViewController.h"
#import "VRReCordViewController.h"
#import "VRRemindersViewController.h"

@interface VRMainScreenViewController ()

@end

@implementation VRMainScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

#pragma mark - ConfigureUI

- (void)configureUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.recordButton setTitle:@"RECORD" forState:UIControlStateNormal];
    [self.recordButton setBackgroundColor:[UIColor blueColor]];
    [self.recordButton addTarget:self action:@selector(recordAction:) forControlEvents:UIControlEventTouchUpInside];
    self.recordButton.layer.cornerRadius = 8;
    self.recordButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.recordButton.layer.borderWidth = 1.0f;
    [self.recordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [self.remindersButton setTitle:@"REMINDERS" forState:UIControlStateNormal];
    [self.remindersButton setBackgroundColor:[UIColor blueColor]];
    [self.remindersButton addTarget:self action:@selector(remindersAction:) forControlEvents:UIControlEventTouchUpInside];
    self.remindersButton.layer.cornerRadius = 8;
    self.remindersButton.layer.borderWidth = 1.0f;
    self.remindersButton.layer.borderColor = [UIColor blueColor].CGColor;
    [self.remindersButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}


#pragma mark - Actions
- (void)recordAction:(id)sender {
    VRReCordViewController *recordViewController = [[VRReCordViewController alloc] init];
    [self.navigationController pushViewController:recordViewController animated:YES];
}

- (void)remindersAction:(id)sender {
    VRRemindersViewController *remindersViewController = [[VRRemindersViewController alloc] init];
//    [self.navigationController pushViewController:remindersViewController animated:YES];
    [self.navigationController presentViewController:remindersViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"release");
}
@end
