//
//  VRSettingBaseViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 6/6/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRSettingBaseViewController.h"

@interface VRSettingBaseViewController ()

@end

@implementation VRSettingBaseViewController
{
    UIBarButtonItem *addButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)backButton {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    
    [backButton setTitleTextAttributes:[self textAttributes] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)doneButton {
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneAction:)];
    [doneButton setTitleTextAttributes:[self textAttributes] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)addButton {
    addButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"bt_add"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(addAction:)];
    [addButton setTitleTextAttributes:[self textAttributes] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (NSDictionary *)textAttributes {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [UIColor redColor],NSForegroundColorAttributeName,
            [UIColor redColor],NSBackgroundColorAttributeName,nil];
}

- (void)hideAddButton {
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
}

- (void)showAddButton {
    [self.navigationItem setRightBarButtonItem:addButton animated:YES];
}

- (void)backAction:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
