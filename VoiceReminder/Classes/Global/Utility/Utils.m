//
//  Utils.m
//  Method
//
//  Created by NextopHN on 3/23/15.
//  Copyright (c) 2015 Nextop. All rights reserved.
//

#import "Utils.h"
#import "AppDelegate.h"
@implementation Utils

+ (Utils *)sharedUtil {
    static Utils *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[Utils alloc] init];
    });
    
    return shared;
}

+ (void)showErrorMessage:(NSURLSessionDataTask*)task andError:(NSError*)error {    
//    NSDictionary *userInfo = [error userInfo];
//    NSError *underlyingError = [userInfo objectForKey:NSUnderlyingErrorKey];
//    NSString *underlyingErrorDescription = [underlyingError localizedDescription];
//    NSInteger statusCode = ((NSHTTPURLResponse*)task.response).statusCode;
//    if(statusCode ==  500 ||  statusCode ==  405 || statusCode ==  404 ) {
//        [self showMessage: [[NSHTTPURLResponse localizedStringForStatusCode:((NSHTTPURLResponse*)task.response).statusCode] capitalizedString] withTitle:LOCAL_ERROR];
//    } else {
//        [self showMessage:underlyingErrorDescription withTitle:LOCAL_ERROR];
//    }
}

// Check if input string contains an email adress
+ (BOOL)containEmailAddress:(NSString*)input {
    
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    NSPredicate *regExPredicate =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    BOOL myStringMatchesRegEx = [regExPredicate evaluateWithObject:input];
    
    return  myStringMatchesRegEx;
    
}

//+ (NSInteger)getlineCountForText:(NSString*)text withFont :(UIFont*)font andWidth:(CGFloat)width {
//    
//    CGFloat allHeight  = [text heightWithMaxWidth:width andFont:font];
//    CGFloat oneLineHeight = [@"別" heightWithMaxWidth:width andFont:font];
//
//    return ceil(allHeight / oneLineHeight);
//}

+ (NSString*)getSubString:(NSString*)input length:(NSInteger)length {
    
    if(input.length < length)
    return input;
    else {
        return  [NSString stringWithFormat:@"%@...", [input substringToIndex:length]];
    }
}

+ (void)addGestureToView:(UIView*)view withSelector:(SEL)selector {
    
    UITapGestureRecognizer * tapPress = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    tapPress.numberOfTapsRequired = 1;
    [view addGestureRecognizer:tapPress];
    view.userInteractionEnabled = YES;
}

+ (NSString*)getHexStringFromColor:(UIColor*)color {
    
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    NSString *hexString=[NSString stringWithFormat:@"#%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
    return hexString;
}

+ (UIImage *)imageWithView:(UIView *)view{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *) imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    //  [[UIColor colorWithRed:222./255 green:227./255 blue: 229./255 alpha:1] CGColor]) ;
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (void)setCommonButtonStyle:(UIButton*)button {
//    [self setCommonButtonStyle:button withColor:COLOR_SUM_CYAN];
}

+ (void)setCommonButtonStyle:(UIButton*)button withColor:(UIColor*)color {
    
    [button setBackgroundImage:[self imageWithColor:color] forState:UIControlStateNormal];
    button.layer.borderColor = [UIColor clearColor].CGColor;
    button.layer.borderWidth = 1.5;
    button.layer.cornerRadius = 5;
    button.clipsToBounds = YES;
}

// Loading
- (MBProgressHUD *)progressView{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (!_progressView) {
        _progressView = [[MBProgressHUD alloc] initWithView:appDelegate.window];
        _progressView.animationType = MBProgressHUDAnimationFade;
        _progressView.dimBackground = NO;
        
        [appDelegate.window addSubview:_progressView];
    }
    return _progressView;
}

- (void)showLoadingView {
    [self hideLoadingView];
    [self showLoadingViewWithTitle:@""];
}

- (void)showLoadingViewWithTitle:(NSString *)title{
    [self hideLoadingView];
    self.progressView.labelText = title;
    [self.progressView show:NO];
}

- (void)hideLoadingView {
    [self.progressView hide:NO];
}


#pragma mark - Alert functions

+ (void)showMessage:(NSString *)message withTitle:(NSString *)title {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

+ (void)showMessage:(NSString *)message withTitle:(NSString *)title andDelegate:(id)delegate{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
}

+ (void)showMessage:(NSString *)message withTitle:(NSString *)title delegate:(id)delegate andTag:(NSInteger)tag{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    alert.tag = tag;
    [alert show];
}

+ (void)showMessage:(NSString *)message withTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelTitle
  otherButtonTitles:(NSString *)otherTitle delegate:(id)delegate andTag:(NSInteger)tag{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
    alert.tag = tag;
    alert.delegate = delegate;
    [alert show];
}

#pragma mark - Date functions

+ (NSDate *)dateFromString:(NSString *)dateString withFormat:(NSString *)dateFormat {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    
    //    NSLocale *timeLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    //    [formatter setLocale:timeLocale];
    
    NSDate *ret = [formatter dateFromString:dateString];
    
    return ret;
}

//+ (NSString *)getStringDateWithInput:(NSString *)dateString fromFormat:(NSString *)dateFormat toFormat:(NSString*)ouputFormat {
//    
//    
//    NSDate *inputDate =[self dateFromString:dateString withFormat:dateFormat];
//    NSInteger differenceDay = [self differeceDayFrom:inputDate toDate:[NSDate date]];
//    
//    if(differenceDay==0) {
//        
//        return [NSString stringWithFormat:@"%@ %@",LOCAL_TODAY,[self stringFromDate:inputDate withFormat:SUM_TIME_FORMAT]];
//        
//    } else  if(differenceDay == 1) {
//        return [NSString stringWithFormat:@"%@ %@",LOCAL_YERTERDAY,[self stringFromDate:inputDate withFormat:SUM_TIME_FORMAT]];
//        
//    } else {
//        
//        return [self stringFromDate:inputDate withFormat:ouputFormat];
//    }
//}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormat];
    
    //    NSLocale *timeLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    //    [formatter setLocale:timeLocale];
    
    NSString *ret = [formatter stringFromDate:date];
    
    return ret;
}

+ (NSString *)stringFromDateRelative:(NSDate*)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle: NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle: NSDateFormatterShortStyle];
    [dateFormatter setDoesRelativeDateFormatting:YES];
    
    NSString *result = [dateFormatter stringFromDate:date];
    
    return result;
}

+ (NSInteger)differeceDayFrom:(NSDate*)fromDate toDate:(NSDate*)toDate {
    
    //DNSLog(@"Diff : %@ ==== %@ ",fromDate,toDate);
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDate];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDate];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    NSInteger diff =  [difference day];
    
    
    //DNSLog(@"Diff : %ld",diff);
    return diff;
}

+ (NSCalendar *)calendar{
    static NSCalendar *calendar;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
#ifdef __IPHONE_8_0
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
#endif
        calendar.timeZone = [NSTimeZone localTimeZone];
    });
    
    return calendar;
}


#pragma mark - NSUserDefaults functions

+ (void)setValue:(id)value forKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setIntValue:(NSInteger)value forKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setValue:(id)value forKeyPath:(NSString *)keyPath{
    [[NSUserDefaults standardUserDefaults] setValue:value forKeyPath:keyPath];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setObject:(id)obj forKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setCustomizeObject:(id)obj forKey:(NSString *)key{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:[NSKeyedArchiver archivedDataWithRootObject:obj] forKey:key];
    [def synchronize];
}

+ (id)getCustomizeObjectWithKey:(NSString*)key{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSData *data = [def objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}


+ (id)valueForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

+ (NSInteger)intValueForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

+ (id)valueForKeyPath:(NSString *)keyPath{
    return [[NSUserDefaults standardUserDefaults] valueForKeyPath:keyPath];
}

+ (id)objectForKey:(NSString *)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)removeObjectForKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark  - UIView Moving Utils

+ (void)moveUp:(UIView*)view offset:(float)offset {
    
    [self moveUp:view offset:offset animation:NO];
}

+ (void)moveDow:(UIView*)view offset:(float)offset {
    
    [self moveDow:view offset:offset animation:NO];
}

+ (void)moveRight:(UIView*)view offset:(float)offset {
    [self moveRight:view offset:offset animation:NO];
}

+ (void)moveLeft:(UIView*)view offset:(float)offset {
    
    [self moveLeft:view offset:offset animation:NO];
}

+ (void)moveUp:(UIView*)view offset:(float)offset animation:(BOOL)animation {
    
    if(animation) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.4];
    }
    
    view.frame=CGRectMake(view.frame.origin.x, view.frame.origin.y-offset, view.frame.size.width, view.frame.size.height);
    
    if(animation) {
        [UIView commitAnimations];
    }
}

+ (void)moveDow:(UIView*)view offset:(float)offset animation:(BOOL)animation {
    
    if(animation) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.4];
    }
    
    view.frame=CGRectMake(view.frame.origin.x, view.frame.origin.y+offset, view.frame.size.width, view.frame.size.height);
    
    if(animation) {
        [UIView commitAnimations];
    }
    
}

+ (void)moveRight:(UIView*)view offset:(float)offset animation:(BOOL)animation {
    
    if(animation) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.4];
    }
    view.frame=CGRectMake(view.frame.origin.x+offset, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    
    if(animation) {
        [UIView commitAnimations];
    }
    
}

+ (void)moveLeft:(UIView*)view offset:(float)offset animation:(BOOL)animation {
    
    if(animation) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.4];
    }
    
    view.frame = CGRectMake(view.frame.origin.x-offset, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    
    if(animation) {
        [UIView commitAnimations];
    }
    
}

+ (void)changeFrameFor:(UIView*)view newFrame:(CGRect)newFrame animation:(BOOL)animation {
    
    if(animation) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.4];
    }
    
    view.frame = newFrame;
    
    if(animation) {
        [UIView commitAnimations];
    }
    
}

+ (void)moveView:(UIView*)view below:(UIView*)topView  offSet:(float)offset {
    
    CGRect currentFrame = view.frame;
    currentFrame.origin.y = topView.frame.origin.y + topView.frame.size.height + offset;
    view.frame = currentFrame;
    
}

+ (void)setGoneView:(UIView*)view {
    
    [view setHidden:YES];
    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 0);
}

+ (void)makeAutoLabelHeight:(UILabel*)label withContent:(NSString*)content {
    
    label.text = content;
    label.numberOfLines = 0;
    
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:content
     attributes:@
     {
     NSFontAttributeName: label.font
     }];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){label.frame.size.width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    label.frame=  CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, size.height);
}



@end
