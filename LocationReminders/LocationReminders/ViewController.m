//
//  ViewController.m
//  LocationReminders
//
//  Created by Brandon Little on 5/1/17.
//  Copyright © 2017 Brandon Little. All rights reserved.
//

#import "ViewController.h"

#import "AddReminderViewController.h"

@import Parse;
@import MapKit;

@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestPermissions];
    
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
}

- (void)requestPermissions {
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 100; //meters
    
    self.locationManager.delegate = self;
    
    [self.locationManager requestAlwaysAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    [super prepareForSegue:segue sender:sender];
    
    if ([segue.identifier isEqualToString:@"AddReminderViewController"] && [sender isKindOfClass:[MKAnnotationView class]])  {
        
        MKAnnotationView *annotationView = (MKAnnotationView *)sender;
        
        AddReminderViewController *newReminderViewController = (AddReminderViewController *)segue.destinationViewController;
        
        newReminderViewController.coordinate = annotationView.annotation.coordinate;
        newReminderViewController.annotationTitle = annotationView.annotation.title;
        newReminderViewController.title = annotationView.annotation.title;
        
    }
    
}

- (IBAction)location1Pressed:(id)sender {
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6566674, -122.351096);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 400.0, 400.0);
    
    [self.mapView setRegion:region animated:YES];
    
}
- (IBAction)location2Pressed:(id)sender {
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(48.025609, -122.142059);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 400.0, 400.0);
    
    [self.mapView setRegion:region animated:YES];
    
}
- (IBAction)location3Pressed:(id)sender {
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(34.515446, -110.120860);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 400.0, 400.0);
    
    [self.mapView setRegion:region animated:YES];
    
}

- (IBAction)userLongPressed:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        CGPoint touchPoint = [sender locationInView:self.mapView];
        
        CLLocationCoordinate2D coordinate = [self.mapView convertPoint:touchPoint
                                                  toCoordinateFromView:self.mapView];
        
        MKPointAnnotation *newPoint = [[MKPointAnnotation alloc]init];
        
        newPoint.coordinate = coordinate;
        newPoint.title = @"New Location";
        
        [self.mapView addAnnotation:newPoint];
        
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location = locations.lastObject;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 400, 400);
    
    [self.mapView setRegion:region animated:YES];
    
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotationView"];
    
    annotationView.annotation = annotation;
    
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annotationView"];
    }
    
    annotationView.canShowCallout = YES;
    annotationView.animatesDrop = YES;
    
    UIButton *rightCalloutAccessory = [UIButton buttonWithType:UIButtonTypeDetailDisclosure]; //callout button
    
    annotationView.rightCalloutAccessoryView = rightCalloutAccessory;
    
    return annotationView;
    
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    NSLog(@"Accessory tapped");
    [self performSegueWithIdentifier:@"AddReminderViewController" sender:view];
    
}


@end
