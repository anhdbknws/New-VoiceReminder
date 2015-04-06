//
//  VRAssetAccessory.h
//  VoiceReminder
//
//  Created by GemCompany on 4/4/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface VRAssetAccessory : NSObject
+ (NSString *)saveAssetToDocument:(ALAsset *)asset;
+ (NSString *)saveImageToDocument:(UIImage *)image;
+ (UIImage *)getImageThumnailWithName:(NSString *)name;
+ (UIImage *)getImageWithName:(NSString *)name;
+ (BOOL)deleteImageInDocumentDirectory:(NSString *)imageName;
+ (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size;
+ (UIImage *)cropImage:(UIImage *)image toSize:(CGSize)size;
@end
