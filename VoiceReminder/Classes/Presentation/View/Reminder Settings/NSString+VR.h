//
//  NSString+VR.h
//  VoiceReminder
//
//  Created by GemCompany on 5/26/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (VR)
#pragma mark -
#pragma mark Class methods
/**
 *  Create empty string
 *
 *  @return emtpy string
 */
+ (NSString *)emptyString;

+ (NSString *)stringWithUUID;

+ (NSString *)base64StringFromData:(NSData *)data length:(int)length;

#pragma mark -
#pragma mark Instance methods
/**
 *  Check if string is valid email address
 *
 *  @return true if is valid email, false if invalid email string
 */
- (BOOL)isValidEmail;

/**
 *  Check if string is valid for input phone number (using for textfield input phone number)
 *  It simple check string has just start 0 or 1 character follow by number
 *  Empty string is valid
 *
 *  @return true if valid phone or false otherwise
 */
- (BOOL)isValidInputPhoneNumber;

/**
 *  Check if string is white space and new line
 *
 *  @return bool
 */
- (BOOL)isWhitespaceAndNewlines;

/**
 *  trim white space in string
 *  eg: @"   abc   xyz   " will become @"abc   xyz"
 *
 *  @return string with no space in head and tail
 */
- (NSString *)trimWhiteSpace;

/**
 *  Remove all white spaces of string
 *  eg: @"  a a   a   " become @"aaa"
 *
 *  @return string without space
 */
- (NSString *)removeAllWhitespaces;

- (NSString *)removeWhitespace;

/**
 * Eg: viewController -> view_controller
 */
- (NSString *)objcVariableNameStyleToDBNameStyle;

- (float) getHeightWithFont:(UIFont*)font maxSizeHeight:(float)max andWidth:(float)width;
- (float) getWidthWithFont:(UIFont*)font maxSizeWidth:(float)max andHeight:(float)height;

/**
 * Eg: 0->100 (%)
 * Eg: 69.96 (%)
 */
- (BOOL)isDecimalNumberWithTwoDecimal;


- (BOOL)isNumber;


/*
 *  Eg: 2.5 or 2.0
 */
- (BOOL) isDecimal;

/*
 *  Eg: number without '.' or ','
 */
- (BOOL) isNumberWithoutDecimal;

-(BOOL) checkValidNumberOfCellBudgets;

- (BOOL)isOnlyNumber;

- (NSString *)trimToValidNumber;

- (NSString *)trimToValidText;

- (BOOL) validateUrl;

//valid: http://yourcompany.com/yourpost
- (BOOL)isValidURLWithPost;
//valid: http://yourcompany.com
- (BOOL)isValidURL;

- (BOOL)containKeyword:(NSString *)keyword;

-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;

/* get height from attribute string */
/* return height*/
@end
