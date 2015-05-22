//
//  VRPhotoDetailViewController.h
//  VoiceReminder
//
//  Created by GemCompany on 4/5/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VRPhotoDetailDataSource <NSObject>
@required
- (UIImage *)photoAtIndex:(NSUInteger)index;
@end

@interface VRPhotoDetailViewController : UIViewController
@property (nonatomic, weak) id<VRPhotoDetailDataSource> dataSource;
@property (nonatomic, assign) NSInteger pageIndex;
+ (VRPhotoDetailViewController *)photoViewControllerForPageIndex:(NSInteger)pageIndex;
@end
