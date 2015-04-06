//
//  VCAppearanceConfig.h
//  Vaccinations
//
//  Created by Nguyen Le Duan on 12/16/14.
//  Copyright (c) 2014 Gem Vietnam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCAppearanceConfig : NSObject
//selected photo/video checkmark
@property (nonatomic, strong) NSString *assetSelectedImageName;
//deselected photo/video checkmark
@property (nonatomic, strong) NSString *assetDeselectedImageName;
@property (nonatomic, strong) NSString *assetsGroupSelectedImageName;
@property (nonatomic, strong) NSString *cameraImageName;
@property (nonatomic, strong) UIFont * groupTitleFont;
@property (nonatomic, strong) UIColor * groupTitleTextColor;
@property (nonatomic, strong) UIFont * groupDetailFont;
@property (nonatomic, strong) UIColor * groupDetailTextColor;
@property (nonatomic, strong) UIColor * assetsPickerControllerBackground;
@property (nonatomic, assign) NSInteger numberOfImagesPerRow;
@property (nonatomic, strong) NSString * prefixAssetsPickerTitle;
@property (nonatomic, strong) UIFont * prefixAssetPickerTitleFont;
@property (nonatomic, strong) UIColor * prefixAssetPickerTitleColor;
@property (nonatomic, strong) UIColor * assetPickerTitleColor;
@property (nonatomic, strong) UIFont * assetPickerTitleFont;
@property (nonatomic, strong) NSString * assetPickerArrowDownImageName;
@property (nonatomic, strong) NSString * cancelAssetPickerImageName;
@property (nonatomic, strong) NSString * doneAssetPickerImageName;
@property (nonatomic, strong) NSString * backAssetPickerImageName;
+ (instancetype)sharedConfig;
@end
