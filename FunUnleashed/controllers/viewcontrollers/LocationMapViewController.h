//
//  LocationMapViewController.h
//  FunUnleashed
//
//  Created by Ranajit Chandra on 14/06/20.
//  Copyright © 2020 cranajit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface LocationMapViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate>

@end

NS_ASSUME_NONNULL_END
