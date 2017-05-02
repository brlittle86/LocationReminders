//
//  AddReminderViewController.h
//  LocationReminders
//
//  Created by Brandon Little on 5/2/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import <UIKit/UIKit.h>

@import MapKit;

@interface AddReminderViewController : UIViewController

@property(strong, nonatomic)NSString *annotationTitle;
@property(nonatomic)CLLocationCoordinate2D coordinate;

@end
