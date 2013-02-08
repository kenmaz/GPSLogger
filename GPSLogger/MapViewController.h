//
//  MapViewController.h
//  GPSLogger
//
//  Created by 松前　健太郎 on 13/02/08.
//  Copyright (c) 2013年 kenmaz.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property Location* location;
@end
