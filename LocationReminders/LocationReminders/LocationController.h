//
//  LocationController.h
//  LocationReminders
//
//  Created by Brandon Little on 5/2/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LocationControllerDelegate.h"

@import CoreLocation;

@interface LocationController : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;
@property (weak, nonatomic) id<LocationControllerDelegate> delegate;

+ (id)sharedLocationController;

- (void)startMonitoringForRegion:(CLRegion *)region;

@end
