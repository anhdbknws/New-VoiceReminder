//
//  VRPersonMapping.h
//  VoiceReminder
//
//  Created by GemCompany on 1/29/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "VRPersonModel.h"

@class NSManagedObjectContext;
@interface VRPersonMapping : NSObject
+ (Person *)entityFromModel:(VRPersonModel *)model inContext:(NSManagedObjectContext *)context;
@end
