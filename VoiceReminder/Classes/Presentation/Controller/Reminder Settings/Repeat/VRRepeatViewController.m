//
//  VRRepeatViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 3/24/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRRepeatViewController.h"
#import "VRRepeatCell.h"

@interface VRRepeatViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *arrayRepeat;
@end

@implementation VRRepeatViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Repeat";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self leftNavigationItem:nil andTitle:@"Back" orImage:nil];
    [self rightNavigationItem:@selector(doneAction:) andTitle:@"Done" orImage:nil];
    [self configureTableView];
    [self prepareData];
}

- (void)configureTableView {
    self.repeatTableview.backgroundColor = [UIColor colorWithRed:238/255.0 green:237/255.0 blue:242/255.0 alpha:1];
    self.repeatTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.repeatTableview.delegate = self;
    self.repeatTableview.dataSource = self;
    
    [self.repeatTableview registerClass:[VRRepeatCell class] forCellReuseIdentifier:NSStringFromClass([VRRepeatCell class])];
}

- (void)prepareData {
    self.arrayRepeat = [NSMutableArray arrayWithArray:[VREnumDefine listRepeatType]];
}

#pragma mark - tableview delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayRepeat.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VRRepeatCell *cell = [self.repeatTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRRepeatCell class]) forIndexPath:indexPath];
    NSString *repeat = [self.arrayRepeat objectAtIndex:indexPath.row];
    cell.titleLabel.text = repeat;
    
    BOOL found = NO;
    for (NSString *item in self.arrayRepeatSelected) {
        if ([item isEqualToString:repeat]) {
            found = YES;
            break;
        }
    }
    
    if (found) {
        cell.imageV.hidden = NO;
        [cell.imageV setImage:[UIImage imageNamed:@"assesory.png"]];
    }
    else
        cell.imageV.hidden = YES;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.repeatTableview deselectRowAtIndexPath:indexPath animated:YES];
    NSString *repeat = [self.arrayRepeat objectAtIndex:indexPath.row];
    
    BOOL found = NO;
    NSInteger index = 0;
    for (NSString *item in self.arrayRepeatSelected) {
        if ([item isEqualToString:repeat]) {
            found = YES;
            index = [self.arrayRepeatSelected indexOfObject:item];
            break;
        }
    }
    
    if (found) {
        [self.arrayRepeatSelected removeObjectAtIndex:index];
    }
    else {
        [self.arrayRepeatSelected addObject:repeat];
    }
    
    [self.repeatTableview reloadData];
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark - Actions
- (void)doneAction:(id)sender {
    if (self.selectedCompleted) {
        self.selectedCompleted (self.arrayRepeatSelected);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
