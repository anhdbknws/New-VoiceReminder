//
//  VCAssetAccessory.m
//  Vaccinations
//
//  Created by Nguyen Le Duan on 12/18/14.
//  Copyright (c) 2014 Gem Vietnam. All rights reserved.
//

#import "VCAssetAccessory.h"
#import "UIApplication+AppDimensions.h"

static NSString * kThumnailSuffix = @"_thumnail";
@implementation VCAssetAccessory
+ (NSString *)saveAssetToDocument:(ALAsset *)asset
{
    ALAssetRepresentation *rep = [asset defaultRepresentation];
    Byte *buffer = (Byte*)malloc(rep.size);
    NSUInteger buffered = [rep getBytes:buffer fromOffset:0 length:rep.size error:nil];
    NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
    CGSize size = [UIApplication currentSize];
    UIImage * imageResized = [[self class] cropImage:[UIImage imageWithData:data] toSize:CGSizeMake(size.width * 2, size.width * 2)];
    
    
    data = UIImageJPEGRepresentation(imageResized, 1);
    NSString * fileName = [[self class] checkDuplicateFileName:rep.filename];
    [data writeToFile:[[self class] filePathWithName:fileName] atomically:YES];
    
    data = UIImageJPEGRepresentation([UIImage imageWithData:data], 0.5f);
    [data writeToFile:[[self class] filePathWithName:[[self class] createThumnailExtensionWithOriginFileName:fileName]] atomically:YES];
    
    return fileName;
}

+ (NSString *)saveImageToDocument:(UIImage *)image
{
    NSString * fileName = [NSUUID UUID].UUIDString;
    NSData *data = UIImageJPEGRepresentation(image, 1);
    NSString * extension  = [[self class] extensionForImageData:data];
    fileName = [fileName stringByAppendingString:[NSString stringWithFormat:@".%@", extension]];
    CGSize size = [UIApplication currentSize];
    UIImage * imageResized = [[self class] cropImage:[UIImage imageWithData:data] toSize:CGSizeMake(size.width * 2, size.width * 2)];
    data = UIImageJPEGRepresentation(imageResized, 1);
    [data writeToFile:[[self class] filePathWithName:fileName] atomically:YES];
    data = UIImageJPEGRepresentation(image, 0.5f);
    [data writeToFile:[[self class] filePathWithName:[[self class] createThumnailExtensionWithOriginFileName:fileName]] atomically:YES];
    
    return fileName;
}
+ (NSString *)checkDuplicateFileName:(NSString *)fileName
{
    NSString *tempFileName = fileName;
    if ([[NSFileManager defaultManager] fileExistsAtPath:[[self class] filePathWithName:fileName]]) {
        NSString * originName = tempFileName;
        NSString * extension = [tempFileName pathExtension];
        if (extension.length) {
            originName = [tempFileName stringByDeletingPathExtension];
        }
        NSInteger maxIterations = 99999;
        for (NSInteger numDuplicates = 1; numDuplicates < maxIterations; numDuplicates++) {
            tempFileName = [NSString stringWithFormat:@"%@(%ld)",originName,(long)numDuplicates];
            if (extension.length) {
                tempFileName = [tempFileName stringByAppendingPathExtension:extension];
            }
            if (![[NSFileManager defaultManager] fileExistsAtPath:[[self class] filePathWithName:tempFileName]])
                break;
        }
    }
    
    return tempFileName;
}
+ (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}
+ (NSString *)filePathWithName:(NSString *)fileName
{
    NSString *documentsDirectory = [[self class] documentsDirectory];
    NSString *newPath = [documentsDirectory stringByAppendingPathComponent:fileName];

    return newPath;
}
+ (UIImage *)getImageThumnailWithName:(NSString *)name
{
    NSString * temp = name;
    if ([temp rangeOfString:kThumnailSuffix].location == NSNotFound) {
        temp = [[self class] createThumnailExtensionWithOriginFileName:temp];
    }
    return [UIImage imageWithContentsOfFile:[[self class] filePathWithName:temp]];
}
+ (UIImage *)getImageWithName:(NSString *)name
{
    return [UIImage imageWithContentsOfFile:[[self class] filePathWithName:name]];
}
+ (NSString *)createThumnailExtensionWithOriginFileName:(NSString *)fileName
{
    NSString * temp = fileName;
    NSArray * array = [temp componentsSeparatedByString:@"."];
    NSString * lastComponent = array[array.count-1];
    temp = [temp stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@", lastComponent] withString:@""];
    temp = [temp stringByAppendingString:kThumnailSuffix];
    return [temp stringByAppendingString:[NSString stringWithFormat:@".%@", lastComponent]];
}
+ (NSString *)extensionForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"JPG";
        case 0x89:
            return @"PNG";
        case 0x47:
            return @"GIF";
        case 0x49:
        case 0x4D:
            return @"TIFF";
    }
    return @"JPG";
}
+ (BOOL)deleteImageInDocumentDirectory:(NSString *)imageName
{
    NSError * error;
    [[NSFileManager defaultManager] removeItemAtPath:[[self class] filePathWithName:imageName] error:&error];
    NSError * error1;
    [[NSFileManager defaultManager] removeItemAtPath:[[self class] filePathWithName:[[self class] createThumnailExtensionWithOriginFileName:imageName]] error:&error1];
    return (!error && !error1);
}
+ (UIImage *)cropImage:(UIImage *)image toSize:(CGSize)size
{
    float actualHeight = size.height;
    float actualWidth = size.width;
    float widthRatio = image.size.width/actualWidth;
    float heightRatio = image.size.height/actualHeight;
    if (widthRatio > heightRatio) {
        actualWidth = image.size.width / heightRatio;
    }
    else
        actualHeight = image.size.height / widthRatio;
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


+ (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = size.width/size.height;
    
    if(imgRatio!=maxRatio){
        if(imgRatio < maxRatio){
            imgRatio = size.height / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = size.height;
        }
        else{
            imgRatio = size.width / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = size.width;
        }
    }
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
@end
