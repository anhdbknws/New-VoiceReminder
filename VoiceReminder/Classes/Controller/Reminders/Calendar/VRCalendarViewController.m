//
//  VRCalendarViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 1/15/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRCalendarViewController.h"
#import "JTCalendarAppearance.h"
NSString *kNotificationName = @"testNotification";
@interface VRCalendarViewController ()<JTCalendarDataSource, UITableViewDataSource, UITableViewDelegate>

@end

@implementation VRCalendarViewController
{
     NSMutableDictionary *eventsByDate;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"calendar";
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
    [self configureNavigationBar];
    // calendar view
    [self createCalendar];
    
    // tableview
    [self configureTableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.calendar reloadData];
}

#pragma mark - ConfigureUI

- (void)configureUI {
    // menu view
    self.menuView = [[JTCalendarMenuView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 44)];
    self.menuView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.menuView];
    
    self.contentView = [[JTCalendarContentView alloc] initWithFrame:CGRectMake(10, 110, self.view.frame.size.width - 20, 280)];
    [self.view addSubview:self.contentView];
    
    UIView *horizontal = [[UIView alloc] initWithFrame:CGRectMake(0, 389, self.view.frame.size.width, 1)];
    horizontal.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:horizontal];
}

- (void)configureNavigationBar {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)configureTableView {
    self.listEventTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 390, self.view.frame.size.width, self.view.frame.size.height - 440) style:UITableViewStylePlain];
    self.listEventTableView.backgroundColor = [UIColor whiteColor];
    self.listEventTableView.dataSource = self;
    self.listEventTableView.delegate = self;
    
    [self.view addSubview:self.listEventTableView];
}

#pragma mark - Tableview datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;

}

#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}


- (void)createCalendar {
    self.calendar = [[JTCalendar alloc] init];
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
        
        return [NSString stringWithFormat:@"%ld %@", comps.year, monthText];
    };
    
    [self.calendar setMenuMonthsView:self.menuView];
    [self.calendar setContentView:self.contentView];
    [self.calendar setDataSource:self];
    
    [self createRandomEvents];
}

#pragma mark - Actions
- (void)backAction:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"testNotification" object:self];
}

- (void)createRandomEvents {
    eventsByDate = [NSMutableDictionary new];
    
    for(int i = 0; i < 30; ++i){
        // Generate 30 random dates between now and 60 days later
        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
        
        // Use the date as key for eventsByDate
        NSString *key = [[self dateFormatter] stringFromDate:randomDate];
        
        if(!eventsByDate[key]){
            eventsByDate[key] = [NSMutableArray new];
        }
        
        [eventsByDate[key] addObject:randomDate];
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
    
    NSLog(@"Date: %@ - %ld events", date, [events count]);
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

@end
