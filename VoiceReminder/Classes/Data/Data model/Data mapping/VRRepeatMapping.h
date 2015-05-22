//
//  VRRepeatMapping.h
//  VoiceReminder
//
//  Created by GemCompany on 3/28/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Repeat, VRRepeatModel, NSManagedObjectContext;

@interface VRRepeatMapping : NSObject
+ (Repeat *)entityFromModel:(VRRepeatModel *)model inContext:(NSManagedObjectContext *)context;
@end
