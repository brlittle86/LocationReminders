//
//  Reminder.m
//  LocationReminders
//
//  Created by Brandon Little on 5/3/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import "Reminder.h"

@implementation Reminder

@dynamic name;
@dynamic location;
@dynamic radius;

+(void)load{
    [super load];
    [self registerSubclass];
}

+(NSString *)parseClassName{
    return @"Reminder";
}

@end
