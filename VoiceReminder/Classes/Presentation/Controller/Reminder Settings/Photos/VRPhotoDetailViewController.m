//
//  VRPhotoDetailViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 4/5/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRPhotoDetailViewController.h"
#import "VRPhotoScrollView.h"

@interface VRPhotoDetailViewController ()

@end

@implementation VRPhotoDetailViewController
+ (VRPhotoDetailViewController *)photoViewControllerForPageIndex:(NSInteger)pageIndex
{
    return [[self alloc] initWithPageIndex:pageIndex];
}

- (id)initWithPageIndex:(NSInteger)pageIndex
{
    if (self = [super init])
    {
        self.pageIndex = pageIndex;
    }
    
    return self;
}

- (void)loadView
{
    VRPhotoScrollView *scrollView   = [[VRPhotoScrollView alloc] init];
    scrollView.dataSource           = self.dataSource;
    scrollView.index                = self.pageIndex;
    
    self.view = scrollView;
}


@end
