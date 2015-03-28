//
//  NSManagedObject+voiceReminder.h
//  VoiceReminder
//
//  Created by GemCompany on 2/1/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (voiceReminder)
+ (instancetype)entityWithUuid:(NSString *)uuid inContext:(NSManagedObjectContext *)context;
+ (NSArray *)findWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors offset:(NSUInteger)offset limit:(NSUInteger)limit inContext:(NSManagedObjectContext *)context;
+ (NSArray *)findWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors inContext:(NSManagedObjectContext *)context;
@end
