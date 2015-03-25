//
//  VRPersonMapping.m
//  VoiceReminder
//
//  Created by GemCompany on 1/29/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRPersonMapping.h"
#import <CoreData/CoreData.h>
#import "Person.h"
#import "VRPersonModel.h"
#import "NSManagedObject+voiceReminder.h"

@implementation VRPersonMapping
+ (Person*)entityFromModel:(VRPersonModel *)model inContext:(NSManagedObjectContext *)context {
    Person *entity = [Person entityWithUuid:model.uuid inContext:context];
    entity.firstName = model.firstName;
    entity.lastName = model.lastName;
    entity.createdDate = model.createdDate;
    if (!entity.createdDate) {
        entity.createdDate = [NSDate date];
    }
    
    return entity;
}
@end
