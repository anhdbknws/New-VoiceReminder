//
//  NSManagedObject+voiceReminder.m
//  VoiceReminder
//
//  Created by GemCompany on 2/1/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "NSManagedObject+voiceReminder.h"

@implementation NSManagedObject (voiceReminder)
+ (instancetype)entityWithUuid:(NSString *)uuid inContext:(NSManagedObjectContext *)context {
    if (!uuid || uuid == (id)[NSNull null] || uuid.length == 0) {
        return nil;
    }
    id object = [[self class] MR_findFirstByAttribute:VRUUID withValue:uuid inContext:context];
    if (!object) {
        object = [[self class] MR_createInContext:context];
        [object setValue:uuid forKey:VRUUID];
    }
    return object;
}

+ (NSArray *)findWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors offset:(NSUInteger)offset limit:(NSUInteger)limit inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest* request = [self MR_createFetchRequestInContext:context];
    if (sortDescriptors && [sortDescriptors count] > 0) {
        [request setSortDescriptors:sortDescriptors];
    }
    [request setPredicate:predicate];
    
    request.fetchOffset = offset;
    request.fetchLimit = limit;
    
    NSError* error = nil;
    NSArray* result = [context executeFetchRequest:request error:&error];
    assert(error == nil);
    return result;
}

+ (NSArray *)findWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest* request = [self MR_createFetchRequestInContext:context];
    if (sortDescriptors && [sortDescriptors count] > 0) {
        [request setSortDescriptors:sortDescriptors];
    }
    [request setPredicate:predicate];
    
    NSError* error = nil;
    NSArray* result = [context executeFetchRequest:request error:&error];
    assert(error == nil);
    return result;
}
@end
