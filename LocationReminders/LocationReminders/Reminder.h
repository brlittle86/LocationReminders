//
//  Reminder.h
//  LocationReminders
//
//  Created by Brandon Little on 5/3/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import <Parse/Parse.h>

@interface Reminder : PFObject<PFSubclassing>

@property(strong, nonatomic)NSString *name;
@property(strong, nonatomic)PFGeoPoint *location;
@property(strong, nonatomic)NSNumber *radius;

@end
