//
//  BaseObject.h
//  VoiceReminder
//
//  Created by GemCompany on 2/1/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BaseObject : NSManagedObject

@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSDate * createdDate;

@end
