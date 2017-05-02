//
//  AddReminderViewController.m
//  LocationReminders
//
//  Created by Brandon Little on 5/2/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import "AddReminderViewController.h"

@interface AddReminderViewController ()

@end

@implementation AddReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Annotation title: %@", self.annotationTitle);
    NSLog(@"Coordinates:  %f, %f", self.coordinate.latitude, self.coordinate.longitude);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
