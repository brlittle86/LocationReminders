//
//  LocationController.m
//  LocationReminders
//
//  Created by Brandon Little on 5/2/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import "LocationController.h"

@import UserNotifications;

@implementation LocationController

+ (id)sharedLocationController {
    static LocationController *sharedLocationController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLocationController = [[self alloc] init];
    });
    return sharedLocationController;
}

- (void)startMonitoringForRegion:(CLRegion *)region{
    [self.locationManager startMonitoringForRegion:region];
}

- (id)init {
    self = [super init];
    
    if (self){
        [self requestPermissions];
    }
    
    self.locationManager.delegate = self;
    
    return self;
}

- (void)requestPermissions {
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 100; //meters
    
    [self.locationManager requestAlwaysAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    self.location = locations.lastObject;
    [self.delegate locationControllerUpdatedLocation:self.location];
    
}

-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
    NSLog(@"Successfully started montitoring changes for Region: %@", region.identifier);
}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"User did ENTER Region: %@", region.identifier);
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = @"Reminder!";
    content.body = [NSString stringWithFormat:@"%@", region.identifier];
    content.sound = [UNNotificationSound defaultSound];
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:0.1 repeats:NO];
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Location Entered" content:content trigger:trigger];
    
    UNUserNotificationCenter *current = [UNUserNotificationCenter currentNotificationCenter];
    
    [current removeAllPendingNotificationRequests];
    [current addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error Posting User Notification: %@", error.localizedDescription);
        }
    }];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSLog(@"User did EXIT Region: %@", region.identifier);
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error occurred while getting User location data: %@", error.localizedDescription); //ignore if in simulator
}

-(void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit{
    NSLog(@"This is here for no reason, but here's a visit: %@", visit);
}

@end
