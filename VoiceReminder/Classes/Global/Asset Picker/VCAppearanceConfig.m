//
//  VCAppearanceConfig.m
//  Vaccinations
//
//  Created by Nguyen Le Duan on 12/16/14.
//  Copyright (c) 2014 Gem Vietnam. All rights reserved.
//

#import "VCAppearanceConfig.h"
#import "VRMacro.h"

@implementation VCAppearanceConfig
+ (instancetype)sharedConfig
{
    static VCAppearanceConfig *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (NSString *)assetSelectedImageName
{
    if (!_assetSelectedImageName) {
        return @"uzysAP_ico_photo_thumb_check";
    }
    return _assetSelectedImageName;
}

- (NSString *)assetDeselectedImageName
{
    if (!_assetDeselectedImageName) {
        return @"uzysAP_ico_photo_thumb_uncheck";
    }
    return _assetDeselectedImageName;
}

- (NSString *)assetsGroupSelectedImageName
{
    if (!_assetsGroupSelectedImageName) {
        return @"uzysAP_ico_checkMark";
    }
    return _assetsGroupSelectedImageName;
}

- (NSString *)cameraImageName
{
    if (!_cameraImageName) {
        return @"uzysAP_ico_upload_camera";
    }
    return _cameraImageName;
}

- (UIFont *)groupTitleFont
{
    if (!_groupTitleFont) {
        _groupTitleFont = [UIFont fontWithName:@"DroidSans" size:15];
    }
    return _groupTitleFont;
}
- (UIFont *)groupDetailFont
{
    if (!_groupDetailFont) {
        _groupDetailFont = [UIFont fontWithName:@"DroidSans" size:14];
    }
    return _groupDetailFont;
}
- (UIColor *)groupTitleTextColor
{
    if (!_groupTitleTextColor) {
        _groupTitleTextColor = [UIColor blackColor];
    }
    return _groupTitleTextColor;
}
- (UIColor *)groupDetailTextColor
{
    if (!_groupDetailTextColor) {
        _groupDetailTextColor = [UIColor blackColor];
    }
    return _groupDetailTextColor;
}
- (UIColor *)assetsPickerControllerBackground
{
    if (!_assetsPickerControllerBackground) {
        _assetsPickerControllerBackground = [UIColor blackColor];
    }
    return _assetsPickerControllerBackground;
}
- (NSInteger)numberOfImagesPerRow
{
    if (!_numberOfImagesPerRow) {
        _numberOfImagesPerRow = 3;
    }
    return _numberOfImagesPerRow;
}
- (UIFont *)prefixAssetPickerTitleFont
{
    if (!_prefixAssetPickerTitleFont) {
        _prefixAssetPickerTitleFont = [UIFont fontWithName:@"DroidSans" size:13];
    }
    return _prefixAssetPickerTitleFont;
}
- (UIColor *)prefixAssetPickerTitleColor
{
    if (!_prefixAssetPickerTitleColor) {
        _prefixAssetPickerTitleColor = [UIColor whiteColor];
    }
    return _prefixAssetPickerTitleColor;
}
- (UIColor *)assetPickerTitleColor
{
    if (!_assetPickerTitleColor) {
        _assetPickerTitleColor = [UIColor whiteColor];
    }
    return _assetPickerTitleColor;
}
- (UIFont *)assetPickerTitleFont
{
    if (!_assetPickerTitleFont) {
        _assetPickerTitleFont = [UIFont fontWithName:@"DroidSans-Bold" size:16];
    }
    return _assetPickerTitleFont;
}
- (NSString *)assetPickerArrowDownImageName
{
    if (!_assetPickerArrowDownImageName.length) {
        _assetPickerArrowDownImageName = @"icon_arrow_topbar";
    }
    return _assetPickerArrowDownImageName;
}

- (NSString *)cancelAssetPickerImageName
{
    if (!_cancelAssetPickerImageName.length) {
        _cancelAssetPickerImageName = @"bt_cancel";
    }
    return _cancelAssetPickerImageName;
}
- (NSString *)doneAssetPickerImageName
{
    if (!_doneAssetPickerImageName.length) {
        _doneAssetPickerImageName = @"bt_done";
    }
    return _doneAssetPickerImageName;
}
- (NSString *)backAssetPickerImageName
{
    if (!_backAssetPickerImageName) {
        _backAssetPickerImageName = @"bt_back";
    }
    return _backAssetPickerImageName;
}
@end
