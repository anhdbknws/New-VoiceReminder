//
//  NSString+VR.m
//  VoiceReminder
//
//  Created by GemCompany on 5/26/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "NSString+VR.h"

@implementation NSString (VR)
static NSString *_emptyString = @"";
+ (NSString *)emptyString
{
    return _emptyString;
}

+ (NSString *)stringWithUUID {
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *UUIDstring = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return UUIDstring;
}

static char base64EncodingTable[64] = {
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
    'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'
};

+ (NSString *)base64StringFromData: (NSData *)data length: (int)length {
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;
    
    lentext = [data length];
    if (lentext < 1)
        return @"";
    result = [NSMutableString stringWithCapacity: lentext];
    raw = [data bytes];
    ixtext = 0;
    
    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0)
            break;
        for (i = 0; i < 3; i++) {
            unsigned long ix = ixtext + i;
            if (ix < lentext)
                input[i] = raw[ix];
            else
                input[i] = 0;
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        switch (ctremaining) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }
        
        for (i = 0; i < ctcopy; i++)
            [result appendString: [NSString stringWithFormat: @"%c", base64EncodingTable[output[i]]]];
        
        for (i = ctcopy; i < 4; i++)
            [result appendString: @"="];
        
        ixtext += 3;
        charsonline += 4;
        
        if ((length > 0) && (charsonline >= length))
            charsonline = 0;
    }
    return result;
}

#pragma mark -
#pragma mark Instance methods
- (BOOL)isValidEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidInputPhoneNumber
{
    if (self.length == 0) {
        return TRUE;
    }
    
    NSString *phoneRegEx = @"^([+]?)(\\d*)";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegEx];
    return [regExPredicate evaluateWithObject: self];
}

- (BOOL)isWhitespaceAndNewlines {
    NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![whitespace characterIsMember:c]) {
            return NO;
        }
    }
    return YES;
}


- (NSString *)trimWhiteSpace {
    NSMutableString *s = [self mutableCopy];
    CFStringTrimWhitespace ((CFMutableStringRef) s);
    return (NSString *) [s copy];
}

- (NSString *)removeWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

// even in the middle, like strange whitespace due &nbsp;
- (NSString *)removeAllWhitespaces {
    return [[self componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString: @""];
}

- (NSString *)replaceAllWhitespacesWithSpace {
    return [[self componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString: @" "];
}

- (NSString *)objcVariableNameStyleToDBNameStyle {
    NSMutableArray *array1 = [NSMutableArray array];
    NSInteger currentLocation = 0;
    NSInteger location = 1;
    for (; location < self.length; location ++) {
        NSString *sub = [self substringWithRange:NSMakeRange(location, 1)];
        if ([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:[sub characterAtIndex:0]]) {
            NSString *addedString = [self substringWithRange:NSMakeRange(currentLocation, location - currentLocation)];
            [array1 addObject:[addedString lowercaseString]];
            currentLocation = location;
        }
    }
    [array1 addObject:[[self substringWithRange:NSMakeRange(currentLocation, location - currentLocation)] lowercaseString]];
    return [array1 componentsJoinedByString:@"_"];
}

- (float) getHeightWithFont:(UIFont*)font maxSizeHeight:(float)max andWidth:(float)width{
    CGSize sizeOfText = [self boundingRectWithSize: CGSizeMake(width, max)
                                           options: (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                        attributes: [NSDictionary dictionaryWithObject:font
                                                                                forKey:NSFontAttributeName]
                                           context: nil].size;
    
    return ceilf(sizeOfText.height);
}

- (float) getWidthWithFont:(UIFont*)font maxSizeWidth:(float)max andHeight:(float)height{
    CGSize sizeOfText = [self boundingRectWithSize: CGSizeMake(max, height)
                                           options: (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                        attributes: [NSDictionary dictionaryWithObject:font
                                                                                forKey:NSFontAttributeName]
                                           context: nil].size;
    
    return ceilf(sizeOfText.width);
    
}

- (BOOL)isNumber
{
    NSString *symbol = [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator];
    NSString *format = [NSString stringWithFormat:@"0123456789%@", symbol];
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:format] invertedSet];
    if ([self rangeOfCharacterFromSet:characterSet].location != NSNotFound)
    {
        return NO;
    }
    else
        return YES;
}

- (BOOL) isNumberWithoutDecimal
{
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    if ([self rangeOfCharacterFromSet:characterSet].location != NSNotFound)
    {
        return NO;
    }
    else
        return YES;
}

- (BOOL)isDecimal
{
    if ([self isNumber]) {
        return ([self doubleValue]-(int)[self doubleValue] != 0);
    }
    return NO;
}

- (BOOL)isDecimalNumberWithTwoDecimal
{
    NSString * newString = self;
    NSString *symbol = [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator];
    NSString *expression = [NSString stringWithFormat:@"^([0-9]+)?(\\%@([0-9]{1,2})?)?$", symbol];
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, [newString length])];
    if (numberOfMatches == 0)
        return NO;
    return YES;
}

-(BOOL) checkValidNumberOfCellBudgets
{
    if ([self isEqualToString:@""]) {
        return TRUE;
    }
    
    //    NSString *regEx = @"0|(^[1-9](\\d*.?[0-9]+)*)";
    NSString *regEx = @"\\d*";
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regEx];
    return [regExPredicate evaluateWithObject: self];
}

- (BOOL)isOnlyNumber{
    if (self.length!=0) {
        NSString *regEx = @"^[0-9](\\d*.?[0-9]+)*";
        NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regEx];
        return [regExPredicate evaluateWithObject: self];
    }
    return NO;
}

- (NSString *)trimToValidNumber{
    NSString *returnString = [self copy];
    returnString = [returnString trimWhiteSpace];
    while (returnString.length >= 2 && [[returnString substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"00"]) {
        returnString = [returnString substringWithRange:NSMakeRange(1, returnString.length - 1)];
    }
    return returnString;
}

- (NSString *)trimToValidText{
    NSString *returnString = [self copy];
    
    while ([returnString characterAtIndex:0]==' ') {
        returnString = [returnString substringWithRange:NSMakeRange(1, returnString.length-1)];
    }
    
    while ([returnString characterAtIndex:returnString.length-1]==' ') {
        returnString = [returnString substringWithRange:NSMakeRange(0, returnString.length-1)];
    }
    
    NSCharacterSet *spaces = [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF != ''"];
    NSArray *tempArray = [[returnString componentsSeparatedByCharactersInSet:spaces] filteredArrayUsingPredicate:predicate];
    returnString = [tempArray componentsJoinedByString:@" "];
    
    return returnString;
}

- (BOOL)containKeyword:(NSString *)keyword {
    if ([self rangeOfString:keyword].location != NSNotFound) {
        return YES;
    }
    return NO;
}

+ (NSString*) stringTimeFromDate:(NSDate*) date{
    long time = labs([date timeIntervalSinceNow]);
    
    if (time < 60) {
        return @"Now";
    }
    
    long minutes = time / 60;
    if (minutes < 60) {
        return [NSString stringWithFormat:@"%lu minute%@ ago", minutes, minutes > 1 ? @"s" : @""];
    }
    
    long hours = time / 60 / 60;
    if (hours < 24) {
        return [NSString stringWithFormat:@"%lu hour%@ ago", hours, hours > 1 ? @"s" : @""];
    }
    
    long days = time / 60 / 60 / 24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%lu day%@ ago", days, days > 1 ? @"s" : @""];
    }
    
    long months = time / 60 / 60 / 24 / 30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%lu month%@ ago", months, months > 1 ? @"s" : @""];
    }
    
    long years = time / 60 / 60 / 24 / 30 / 12;
    return [NSString stringWithFormat:@"%lu year%@ ago", years, years > 1 ? @"s" : @""];
}

- (BOOL) validateUrl
{
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:self];
}

- (BOOL)isValidURLWithPost
{
    if (![self containKeyword:@"http://www."] && ![self containKeyword:@"https://www."]) {
        return NO;
    }
    NSRange range;
    if ([self containKeyword:@"http://www."]) {
        range = [self rangeOfString:@"http://www."];
    }
    else if ([self containKeyword:@"https://www."])
        range = [self rangeOfString:@"https://www."];
    if (range.location != 0) {
        return NO;
    }
    NSString * leftStr = [self substringFromIndex:range.length];
    range = [leftStr rangeOfString:@"/"];
    if (range.location == NSNotFound) {
        return NO;
    }
    leftStr = [leftStr substringFromIndex:range.location + range.length];
    if (leftStr.length == 0) {
        return NO;
    }
    return YES;
}

- (BOOL)isValidURL
{
    if (![self containKeyword:@"http://www."] && ![self containKeyword:@"https://www."]) {
        return NO;
    }
    NSRange range;
    if ([self containKeyword:@"http://www."]) {
        range = [self rangeOfString:@"http://www."];
    }
    else if ([self containKeyword:@"https://www."])
        range = [self rangeOfString:@"https://www."];
    if (range.location != 0) {
        return NO;
    }
    return YES;
}

-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding)));
}
@end
