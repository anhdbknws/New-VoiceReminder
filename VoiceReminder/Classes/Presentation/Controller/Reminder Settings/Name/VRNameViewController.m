//
//  VRNameViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 3/24/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRNameViewController.h"
#import "VRNameCell.h"

@interface VRNameViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) NSString *name;
@end

@implementation VRNameViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Name";
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self backButton];
    [self doneButton];
    [self configureTableView];
    [self addGesture];
}

- (void)configureTableView {
    self.nameTableview.backgroundColor = H5_COLOR;
    self.nameTableview.delegate = self;
    self.nameTableview.dataSource = self;
    self.nameTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.nameTableview registerClass:[VRNameCell class] forCellReuseIdentifier:NSStringFromClass([VRNameCell class])];
}

- (void)addGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

#pragma mark - tableview datasource, delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VRNameCell *cell = [self.nameTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRNameCell class]) forIndexPath:indexPath];
    cell.valueTextfield.text = self.nameValue;
    cell.valueTextfield.delegate = self;
    [cell.valueTextfield becomeFirstResponder];
    cell.valueTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (self.view.frame.size.height/2) - 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height/2) - 44)];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

#pragma mark - textfield delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.name = textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

#pragma mark - actions
- (void)doneAction:(id)sender {
    [self.view endEditing:YES];
    
    if (self.doneNameCompleted) {
        self.doneNameCompleted(self.name);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - dismisskeyboard 
- (void)dismissKeyboard{
    [self.view endEditing:YES];
}
@end
