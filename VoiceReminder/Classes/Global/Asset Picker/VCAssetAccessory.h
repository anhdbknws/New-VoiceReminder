//
//  VCAssetAccessory.h
//  Vaccinations
//
//  Created by Nguyen Le Duan on 12/18/14.
//  Copyright (c) 2014 Gem Vietnam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface VCAssetAccessory : NSObject
+ (NSString *)saveAssetToDocument:(ALAsset *)asset;
+ (NSString *)saveImageToDocument:(UIImage *)image;
+ (UIImage *)getImageThumnailWithName:(NSString *)name;
+ (UIImage *)getImageWithName:(NSString *)name;
+ (BOOL)deleteImageInDocumentDirectory:(NSString *)imageName;
+ (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size;
+ (UIImage *)cropImage:(UIImage *)image toSize:(CGSize)size;
@end
