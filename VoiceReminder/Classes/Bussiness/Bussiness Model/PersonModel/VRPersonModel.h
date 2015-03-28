//
//  VRPersonModel.h
//  VoiceReminder
//
//  Created by GemCompany on 1/29/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface VRPersonModel : BaseModel
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@end
