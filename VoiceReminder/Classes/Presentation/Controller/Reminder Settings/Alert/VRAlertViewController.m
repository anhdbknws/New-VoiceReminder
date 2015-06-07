//
//  VRAlertViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 3/25/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRAlertViewController.h"
#import "VRRepeatCell.h"

@interface VRAlertViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation VRAlertViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Alert";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self leftNavigationItem:nil andTitle:@"Back" orImage:nil];
    [self rightNavigationItem:@selector(doneAction:) andTitle:@"Done" orImage:nil];
    [self configureTableView];
}

- (void)configureTableView {
    self.alertTableView.backgroundColor = [UIColor colorWithRed:238/255.0 green:237/255.0 blue:242/255.0 alpha:1];
    self.alertTableView.delegate = self;
    self.alertTableView.dataSource = self;
    self.alertTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.alertTableView registerClass:[VRRepeatCell class] forCellReuseIdentifier:NSStringFromClass([VRRepeatCell class])];
}

#pragma mark - Tableview delegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [VREnumDefine listAlertType].count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VRRepeatCell *cell = [self.alertTableView dequeueReusableCellWithIdentifier:NSStringFromClass([VRRepeatCell class]) forIndexPath:indexPath];
    NSString *alert = [[VREnumDefine listAlertType] objectAtIndex:indexPath.row];
    cell.titleLabel.text = alert;
    if ([self.alertSelected isEqualToString:alert]) {
        cell.imageV.hidden = NO;
        [cell.imageV setImage:[UIImage imageNamed:@"assesory.png"]];
    }
    else {
        cell.imageV.hidden = YES;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.alertTableView deselectRowAtIndexPath:indexPath animated:YES];
    self.alertSelected = [[VREnumDefine listAlertType] objectAtIndex:indexPath.row];
    [self.alertTableView reloadData];
}

#pragma mark - actions
- (void)doneAction:(id)sender {
    if (self.selectedAlertCompleted) {
        self.selectedAlertCompleted(self.alertSelected);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end
