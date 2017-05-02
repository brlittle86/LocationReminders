//
//  LocationControllerDelegate.h
//  LocationReminders
//
//  Created by Brandon Little on 5/2/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LocationControllerDelegate <NSObject>

- (void)locationControllerUpdatedLocation:(CLLocation *)location;

@end
