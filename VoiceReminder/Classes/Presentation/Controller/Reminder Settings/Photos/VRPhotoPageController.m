//
//  VRPhotoPageController.m
//  VoiceReminder
//
//  Created by GemCompany on 4/5/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRPhotoPageController.h"
#import "VRPhotoDetailViewController.h"
#import "VRAssetAccessory.h"
#import "VRPhotoScrollView.h"

@interface VRPhotoPageController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate, VRPhotoDetailDataSource>

@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, assign, getter = isStatusBarHidden) BOOL statusBarHidden;
@end

@implementation VRPhotoPageController
- (id)initWithPhotos:(NSArray *)photoList {
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    if (self) {
        self.photos = photoList;
        self.dataSource = self;
        self.delegate = self;
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self configureNavigationBar];
    [self createNotification];
}

- (void)configureNavigationBar {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor redColor],NSForegroundColorAttributeName,
                                    [UIColor redColor],NSBackgroundColorAttributeName,nil];
    [backButton setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = backButton;
}

#pragma mark - Update Title
- (void)setTitleIndex:(NSInteger)index
{
    NSInteger count = self.photos.count;
    self.title      = [NSString stringWithFormat:NSLocalizedStringFromTable(@"%ld of %ld", @"CTAssetsPickerController", nil), index, count];
}

#pragma mark - pageview datasource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = ((VRPhotoDetailViewController *)viewController).pageIndex;
    
    if (index > 0) {
        VRPhotoDetailViewController *page = [VRPhotoDetailViewController photoViewControllerForPageIndex:(index - 1)];
        page.dataSource = self;
        
        return page;
    }
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger count = self.photos.count;
    NSInteger index = ((VRPhotoDetailViewController *)viewController).pageIndex;
    
    if (index < count - 1)
    {
        VRPhotoDetailViewController *page = [VRPhotoDetailViewController photoViewControllerForPageIndex:(index + 1)];
        page.dataSource = self;
        
        return page;
    }
    
    return nil;
}

#pragma mark - pageview delegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed)
    {
        VRPhotoDetailViewController *vc   = (VRPhotoDetailViewController *)pageViewController.viewControllers[0];
        NSInteger index                 = vc.pageIndex + 1;
        
        [self setTitleIndex:index];
    }
}

- (void)setPageIndex:(NSInteger)pageIndex
{
    NSInteger count = self.photos.count;
    
    if (pageIndex >= 0 && pageIndex < count)
    {
        VRPhotoDetailViewController *page = [VRPhotoDetailViewController photoViewControllerForPageIndex:pageIndex];
        page.dataSource = self;
        
        [self setViewControllers:@[page]
                       direction:UIPageViewControllerNavigationDirectionForward
                        animated:NO
                      completion:NULL];
        
        [self setTitleIndex:pageIndex + 1];
    }
}

#pragma mark - Page Index

- (NSInteger)pageIndex
{
    return ((VRPhotoDetailViewController *)self.viewControllers[0]).pageIndex;
}

#pragma mark - VCPhotoViewControllerDataSource

- (UIImage *)photoAtIndex:(NSUInteger)index;
{
    id object = [self.photos objectAtIndex:index];
    UIImage * image;
    if ([object isKindOfClass:[NSString class]]) {
        image = [VRAssetAccessory getImageWithName:object];
    }
    else
        image = object;
    return image;
}

- (void)fadeNavigationBarAway
{
    self.statusBarHidden = YES;
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         [self setNeedsStatusBarAppearanceUpdate];
                         [self.navigationController.navigationBar setAlpha:0.0f];
                         [self.navigationController setNavigationBarHidden:YES];
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

- (void)fadeNavigationBarIn
{
    self.statusBarHidden = NO;
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         [self setNeedsStatusBarAppearanceUpdate];
                         [self.navigationController.navigationBar setAlpha:1.0f];
                         [self.navigationController setNavigationBarHidden:NO];
                     }];
}

#pragma mark - Actions
- (void)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:VRPhotoScrollViewTappedNotification object:nil];
}

- (void)createNotification {
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    
    [notification addObserver:self
               selector:@selector(scrollViewTapped:)
                   name:VRPhotoScrollViewTappedNotification
                 object:nil];
}
#pragma mark - Tap Gesture

- (void)scrollViewTapped:(NSNotification *)notification
{
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *)notification.object;
    
    if (gesture.numberOfTapsRequired == 1)
        [self toogleNavigationBar:gesture];
}

#pragma mark - Fade in / away navigation bar

- (void)toogleNavigationBar:(id)sender
{
    if (self.isStatusBarHidden)
        [self fadeNavigationBarIn];
    else
        [self fadeNavigationBarAway];
}
@end
