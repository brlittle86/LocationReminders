//
//  LocationController.m
//  LocationReminders
//
//  Created by Brandon Little on 5/2/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import "LocationController.h"

@implementation LocationController

+ (id)sharedLocationController {
    static LocationController *sharedLocationController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLocationController = [[self alloc] init];
    });
    return sharedLocationController;
}

- (id)init {
    self = [super init];
    
    return self;
}

@end
