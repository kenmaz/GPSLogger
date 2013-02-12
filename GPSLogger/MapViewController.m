//
//  MapViewController.m
//  GPSLogger
//
//  Created by 松前　健太郎 on 13/02/08.
//  Copyright (c) 2013年 kenmaz.net. All rights reserved.
//

#import "MapViewController.h"
#import "NSDate+Additions.h"

@interface MyAnnotation : NSObject <MKAnnotation>
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString*)title;
@end

@implementation MyAnnotation
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString*)title {
    if ((self = [super init])) {
        _coordinate = coordinate;
        _title = title;
    }
    return self;
}
@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    for (Location* location in self.locations) {
        CLLocationCoordinate2D loc;
        loc.latitude = [location.lat doubleValue];
        loc.longitude = [location.lng doubleValue];
        [self.mapView setCenterCoordinate:loc animated:YES];
        
        MKCoordinateRegion cr = self.mapView.region;
        cr.center = loc;
        cr.span.latitudeDelta = 0.9;
        cr.span.longitudeDelta = 0.9;
        [self.mapView setRegion:cr animated:NO];
        
        MyAnnotation* anno = [[MyAnnotation alloc] initWithCoordinate:loc title:[location.createdAt description]];
        [self.mapView addAnnotation:anno];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
