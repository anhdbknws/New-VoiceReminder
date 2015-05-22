//
//  VRPhotoScrollView.h
//  VoiceReminder
//
//  Created by GemCompany on 4/5/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRPhotoDetailViewController.h"

extern NSString * const VRPhotoScrollViewTappedNotification;

@interface VRPhotoScrollView : UIScrollView
@property (nonatomic, weak) id<VRPhotoDetailDataSource> dataSource;
@property (nonatomic) NSUInteger index;
@end
