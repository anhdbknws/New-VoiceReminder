//
//  VRPhotoPageController.h
//  VoiceReminder
//
//  Created by GemCompany on 4/5/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRPhotoPageController : UIPageViewController
- (id)initWithPhotos:(NSArray *)photoList;
@property (nonatomic, assign) NSInteger pageIndex;

@end
