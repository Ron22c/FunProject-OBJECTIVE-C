//
//  LocationMapViewController.m
//  FunUnleashed
//
//  Created by Ranajit Chandra on 14/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import "LocationMapViewController.h"

@interface LocationMapViewController ()
{
    CLLocationManager *locationManager;
    UILabel *locationData;
}

@end

@implementation LocationMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLayoutSubviews {
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self fetchLocation];
    [self showMap];
    [self showLocationInfo];
}

- (void)fetchLocation {
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestAlwaysAuthorization];
    [locationManager requestWhenInUseAuthorization];
    locationManager.desiredAccuracy=kCLLocationAccuracyHundredMeters;
    locationManager.delegate=self;
    [locationManager startUpdatingLocation];
}

- (void)showMap {
    MKMapView *mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/4, self.view.bounds.size.width, self.view.bounds.size.height/1.5)];
    [mapView setMapType:MKMapTypeStandard];
    [mapView setShowsUserLocation:YES];
    [self.view addSubview:mapView];
}

- (void)showLocationInfo {
    locationData = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height/8, self.view.bounds.size.width, self.view.bounds.size.height/10)];
    [locationData setTextAlignment:NSTextAlignmentCenter];
    [locationData setNumberOfLines:0];
    [locationData setText:@"LOCATION"];
    [locationData setTextColor:[UIColor blackColor]];
    [self.view addSubview:locationData];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if(locations.count>0) {
        NSLog(@"location-> %f, %f", manager.location.coordinate.latitude, manager.location.coordinate.longitude);
        [manager stopUpdatingLocation];
        
        CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:manager.location.coordinate radius:800 identifier:@"home"];
        [manager startMonitoringForRegion:region];
        
        CLGeocoder *coder = [[CLGeocoder alloc] init];
        [coder reverseGeocodeLocation:manager.location
                    completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
            if(placemarks.count>0) {
                NSDictionary *address = [placemarks objectAtIndex:0].addressDictionary;
                NSLog(@"coded %@", address);
                NSLog(@"Country %@", [address valueForKey:@"Country"]);
                [self->locationData setText: [NSString stringWithFormat:
                                        @"name: %@, Country: %@, city: %@, ZIP: %@",
                                        [address valueForKey:@"Name"],
                                        [address valueForKey:@"Country"],
                                        [address valueForKey:@"City"],
                                        [address valueForKey:@"ZIP"]
                                        ]];
            }
        }];

    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error!!"
                                                                       message:@"unable to update location"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Entered from home location");
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"Exited from home location");
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error!!"
                                                                   message:@"unable to update location"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"OK"
                                                   style:UIAlertActionStyleDefault
                                                 handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    NSLog(@"Started monitoring location");
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [mapView setRegion:MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 800, 800) animated:YES];
    if (@available(iOS 13.0, *)) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc]initWithCoordinate:userLocation.location.coordinate
                                                                               title:@"HOME"
                                                                            subtitle:@"home sweet home"];
        [mapView addAnnotation:annotation];
    } else {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
        [annotation setTitle:@"HOME"];
        [annotation setSubtitle:@"home sweet home"];
        [mapView addAnnotation:annotation];
    }
    MKCircle *overlay = [MKCircle circleWithCenterCoordinate:userLocation.location.coordinate radius:800];
    [mapView addOverlay:overlay];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    MKOverlayRenderer *render = [[MKOverlayRenderer alloc]initWithOverlay:overlay];
    return render;
}

@end
