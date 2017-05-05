//
//  AddReminderViewController.m
//  LocationReminders
//
//  Created by Brandon Little on 5/2/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import "AddReminderViewController.h"
#import "Reminder.h"
#import "LocationController.h"

@interface AddReminderViewController ()

@property (weak, nonatomic) IBOutlet UITextField *reminderName;
@property (weak, nonatomic) IBOutlet UITextField *reminderRadius;

@end

@implementation AddReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareNavigationBarDoneButton];
    
}

- (void)prepareNavigationBarDoneButton{
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]initWithTitle:@"Submit" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonPressed)];
    
    [[self navigationItem] setRightBarButtonItem:doneButton];
}

- (void)doneButtonPressed{
    Reminder *newReminder = [Reminder object];
    
    newReminder.name = self.reminderName.text;
    newReminder.location = [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    newReminder.radius = [self numberFromString:self.reminderRadius.text];
    
    [newReminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        NSLog(@"Annotation title: %@", self.annotationTitle);
        NSLog(@"Coordinates:  %f, %f", self.coordinate.latitude, self.coordinate.longitude);
        
        NSLog(@"Save Reminder successful: %i - Error: %@", succeeded, error.localizedDescription);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReminderSavedToParse" object:nil];
        
    }];
    
    if (self.completion) {
        
        CGFloat radius = [self.reminderRadius.text floatValue]; //for lab coming from UISlider/UITextField from the user
        
        MKCircle *circle = [MKCircle circleWithCenterCoordinate:self.coordinate radius:radius];
        
        if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
            
            CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:self.coordinate radius:radius identifier:newReminder.name];
            
            [LocationController.sharedLocationController startMonitoringForRegion:region];
            
        }
        
        self.completion(circle);
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

-(NSNumber *)numberFromString:(NSString *)string {
    NSNumberFormatter *formatString = [[NSNumberFormatter alloc]init];
    [formatString setNumberStyle:NSNumberFormatterDecimalStyle];
    return  [formatString numberFromString:string];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
