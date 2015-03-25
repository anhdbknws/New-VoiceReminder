//
//  BaseModel.h
//  VoiceReminder
//
//  Created by GemCompany on 2/1/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSDate *createdDate;
@end
