//
//  Utils.h
//  Method
//
//  Created by NextopHN on 3/23/15.
//  Copyright (c) 2015 Nextop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface Utils : NSObject

@property (strong, nonatomic) MBProgressHUD *progressView;

+ (Utils *)sharedUtil;
+ (void)showErrorMessage:(NSURLSessionDataTask*)task andError:(NSError*)error;

// Check if input string contains an email adress
+(BOOL)containEmailAddress:(NSString*)input;

+(NSString*)getSubString:(NSString*)input length:(NSInteger)length;

+(void)addGestureToView:(UIView*)view withSelector:(SEL)selector;

+ (NSString*)getHexStringFromColor:(UIColor*)color;
+ (UIImage *)imageWithView:(UIView *)view;
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (void)setCommonButtonStyle:(UIButton*)button;
+ (void)setCommonButtonStyle:(UIButton*)button withColor:(UIColor*)color;

// Alert functions
+ (void)showMessage:(NSString *)message withTitle:(NSString *)title;
+ (void)showMessage:(NSString *)message withTitle:(NSString *)title andDelegate:(id)delegate;
+ (void)showMessage:(NSString *)message withTitle:(NSString *)title delegate:(id)delegate andTag:(NSInteger)tag;
+ (void)showMessage:(NSString *)message withTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle otherButtonTitles:(NSString *)otherTitle delegate:(id)delegate andTag:(NSInteger)tag;

// Loading
- (void)showLoadingView;
- (void)showLoadingViewWithTitle:(NSString *)title;
- (void)hideLoadingView;

// Date functions
+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)dateFormat;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)dateFormat;
+ (NSString *)stringFromDateRelative:(NSDate*)date;
+ (NSInteger)differeceDayFrom:(NSDate*)fromDate toDate:(NSDate*)toDate;

// NSUserDefaults functions
+ (void)setValue:(id)value forKey:(NSString *)key;
+ (void)setIntValue:(NSInteger)value forKey:(NSString *)key;
+ (void)setValue:(id)value forKeyPath:(NSString *)keyPath;
+ (void)setObject:(id)obj forKey:(NSString *)key;

// You can only store property list types (array, data, string, number, date, dictionary) or urls in NSUserDefaults. You'll need to convert your model object to store
+ (void)setCustomizeObject:(id)obj forKey:(NSString *)key;
+ (id)getCustomizeObjectWithKey:(NSString*)key;
+ (id)valueForKey:(NSString *)key;
+ (NSInteger)intValueForKey:(NSString *)key;
+ (id)valueForKeyPath:(NSString *)keyPath;
+ (id)objectForKey:(NSString *)key;
+ (void)removeObjectForKey:(NSString *)key;

// View Utils
+ (void)moveUp:(UIView*)view offset:(float)offset;
+ (void)moveDow:(UIView*)view offset:(float)offset;
+ (void)moveRight:(UIView*)view offset:(float)offset;
+ (void)moveLeft:(UIView*)view offset:(float)offset;

+ (void)moveUp:(UIView*)view offset:(float)offset animation:(BOOL)animation;
+ (void)moveDow:(UIView*)view offset:(float)offset animation:(BOOL)animation;
+ (void)moveRight:(UIView*)view offset:(float)offset animation:(BOOL)animation;
+ (void)moveLeft:(UIView*)view offset:(float)offset animation:(BOOL)animation;

+ (void)changeFrameFor:(UIView*)view newFrame:(CGRect)newFrame animation:(BOOL)animation;

+ (void)moveView:(UIView*)view below:(UIView*)topView  offSet:(float)offset;
+ (void)setGoneView:(UIView*)view;
+ (void)makeAutoLabelHeight:(UILabel*)label withContent:(NSString*)content;


@end
