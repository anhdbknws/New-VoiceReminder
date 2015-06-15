//
//  VRShortSoundMapping.h
//  VoiceReminder
//
//  Created by GemCompany on 6/15/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShortSound.h"
#import "VRShortSoundModel.h"

@class NSManagedObjectContext;
@interface VRShortSoundMapping : NSObject
+ (ShortSound *)entityFromModel:(VRShortSoundModel *)model inContext:(NSManagedObjectContext *)context;
@end
