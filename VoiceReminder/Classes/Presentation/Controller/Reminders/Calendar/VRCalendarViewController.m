//
//  VRCalendarViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 1/15/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRCalendarViewController.h"
#import "JTCalendarAppearance.h"
#import "VRReminderListCell.h"
#import "VRReminderModel.h"

@interface VRCalendarViewController ()<JTCalendarDataSource, UITableViewDataSource, UITableViewDelegate>

@end

@implementation VRCalendarViewController
{
     NSMutableDictionary *eventsByDate;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
    [self createCalendar];
    [self configureTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getReminderFromDBLocalCompletionHandler:^(NSError *error, id result) {
        [self createCalendar];
        [self.listEventTableview reloadData];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.calendar reloadData];
}

#pragma mark - ConfigureUI

- (void)configureUI {
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.horizontalView];
    [self.view addSubview:self.listEventTableview];
    
    /* layout views*/
    [_menuView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_menuView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [_menuView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    [_menuView autoSetDimension:ALDimensionHeight toSize:44];
    
    [_contentView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:5];
    [_contentView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
    [_contentView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_menuView];
    [_contentView autoSetDimension:ALDimensionHeight toSize:200];
    
    [_horizontalView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [_horizontalView autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    [_horizontalView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_contentView withOffset:5];
    [_horizontalView autoSetDimension:ALDimensionHeight toSize:1];
    
    [_listEventTableview autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_horizontalView];
    [_listEventTableview autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [_listEventTableview autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    [_listEventTableview autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:50];
}

- (void)configureTableView {
    [self.listEventTableview registerClass:[VRReminderListCell class] forCellReuseIdentifier:NSStringFromClass([VRReminderListCell class])];
}

- (UIView *)horizontalView {
    if (!_horizontalView) {
        _horizontalView = [[UIView alloc] initForAutoLayout];
        _horizontalView.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
    }
    
    return _horizontalView;
}

- (JTCalendarMenuView *)menuView {
    if (!_menuView) {
        _menuView = [[JTCalendarMenuView alloc] initForAutoLayout];
        _menuView.backgroundColor = [UIColor redColor];
    }
    
    return _menuView;
}

- (JTCalendarContentView *)contentView {
    if (!_contentView) {
        _contentView = [[JTCalendarContentView alloc] initForAutoLayout];
    }
    
    return _contentView;
}

- (UITableView *)listEventTableview {
    if (!_listEventTableview) {
        _listEventTableview = [[UITableView alloc] initForAutoLayout];
        _listEventTableview.backgroundColor = [UIColor whiteColor];
        _listEventTableview.dataSource = self;
        _listEventTableview.delegate = self;
        _listEventTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _listEventTableview;
}


#pragma mark - Tableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.service.listReminderAll.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VRReminderListCell *cell = [self.listEventTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRReminderListCell class]) forIndexPath:indexPath];
    VRReminderModel *model = [self.service.listReminderAll objectAtIndex:indexPath.row];
    cell.name.text = model.name;
    [cell.switchButton setOn:model.isActive];
    cell.timeReminder.text = model.timeReminder;
    
    __weak typeof(self)weak = self;
    cell.changeSwitch = ^(id sender) {
        [weak updateStatusFor:model CompletionHandler:^(NSError *error, id result) {
            [weak.service.listReminderAll replaceObjectAtIndex:indexPath.row withObject:result];
            [weak.listEventTableview reloadData];
        }];
    };
    
    [cell layoutSubviews];
    return cell;
}

#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}


- (void)createCalendar {
    if (!self.calendar) {
        self.calendar = [[JTCalendar alloc] init];
    }
    
    self.calendar.calendarAppearance.calendar.firstWeekday = 2; // Sunday == 1, Saturday == 7
    self.calendar.calendarAppearance.dayCircleRatio = 1;
    self.calendar.calendarAppearance.ratioContentMenu = 2.;
    self.calendar.calendarAppearance.focusSelectedDayChangeMode = YES;
    
    // Customize the text for each month
    self.calendar.calendarAppearance.monthBlock = ^NSString *(NSDate *date, JTCalendar *jt_calendar){
        NSCalendar *calendar = jt_calendar.calendarAppearance.calendar;
        NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
        NSInteger currentMonthIndex = comps.month;
        
        static NSDateFormatter *dateFormatter;
        if(!dateFormatter){
            dateFormatter = [NSDateFormatter new];
            dateFormatter.timeZone = jt_calendar.calendarAppearance.calendar.timeZone;
        }
        
        while(currentMonthIndex <= 0){
            currentMonthIndex += 12;
        }
        
        NSString *monthText = [[dateFormatter standaloneMonthSymbols][currentMonthIndex - 1] capitalizedString];
        
        return [NSString stringWithFormat:@"%ld %@", (long)comps.year, monthText];
    };
    
    [self.calendar setMenuMonthsView:self.menuView];
    [self.calendar setContentView:self.contentView];
    [self.calendar setDataSource:self];
    
    [self createRandomEvents];
}

#pragma mark - Actions

- (void)createRandomEvents {
    if (!eventsByDate) {
        eventsByDate = [NSMutableDictionary new];
    }
    else {
        [eventsByDate removeAllObjects];
    }
    
    for(VRReminderModel *model in self.service.listReminderAll){
        // Generate 30 random dates between now and 60 days later
//        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];

        NSDate *listDates = [[VRCommon commonDateTimeFormat] dateFromString:model.timeReminder];
        NSLog(@"diep: %@", listDates);
        // Use the date as key for eventsByDate
//        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
//        if(!eventsByDate[key]){
//            eventsByDate[key] = [NSMutableArray new];
//        }
//        
//        [eventsByDate[key] addObject:randomDate];
    }
}

#pragma mark - Transition examples

- (void)transitionExample
{
    CGFloat newHeight = 300;
    if(self.calendar.calendarAppearance.isWeekMode){
        newHeight = 75.;
    }
    
    [UIView animateWithDuration:.5
                     animations:^{
                         //                         self.calendarContentViewHeight.constant = newHeight;
                         [self.view layoutIfNeeded];
                     }];
    
    [UIView animateWithDuration:.25
                     animations:^{
                         self.contentView.layer.opacity = 0;
                     }
                     completion:^(BOOL finished) {
                         [self.calendar reloadAppearance];
                         
                         [UIView animateWithDuration:.25
                                          animations:^{
                                              self.contentView.layer.opacity = 1;
                                          }];
                     }];
}

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    
    if(eventsByDate[key] && [eventsByDate[key] count] > 0){
        return YES;
    }
    
    return NO;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSString *key = [[self dateFormatter] stringFromDate:date];
    NSArray *events = eventsByDate[key];
    
    NSLog(@"Date: %@ - %ld events", date, (unsigned long)[events count]);
}

- (void)calendarDidLoadPreviousPage
{
    NSLog(@"Previous page loaded");
}

- (void)calendarDidLoadNextPage
{
    NSLog(@"Next page loaded");
}

#pragma mark - Fake data

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"dd-MM-yyyy";
    }
    
    return dateFormatter;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)editAction {
    NSLog(@"Edit calendar");
}

- (void)doneAction {
    NSLog(@"done calendar");
}
@end
