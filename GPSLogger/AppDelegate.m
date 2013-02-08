//
//  AppDelegate.m
//  GPSLogger
//
//  Created by 松前　健太郎 on 13/02/08.
//  Copyright (c) 2013年 kenmaz.net. All rights reserved.
//

#import "AppDelegate.h"
#import "Location.h"

@implementation AppDelegate {
    CLLocationManager* _locationManager;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [MagicalRecord setupCoreDataStack];
    
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        if ([CLLocationManager significantLocationChangeMonitoringAvailable]) {
            [_locationManager startMonitoringSignificantLocationChanges];
        }
    } else {
        NSLog(@"fail to setup location service");
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
          
    if ([CLLocationManager significantLocationChangeMonitoringAvailable]) {
        [_locationManager startMonitoringSignificantLocationChanges];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if ([CLLocationManager significantLocationChangeMonitoringAvailable]) {
        [_locationManager stopMonitoringSignificantLocationChanges];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"%s | %@, %@", __PRETTY_FUNCTION__, newLocation, oldLocation);
    
    Location* loc = [Location MR_createEntity];
    loc.lat = [NSNumber numberWithDouble:newLocation.coordinate.latitude];
    loc.lng = [NSNumber numberWithDouble:newLocation.coordinate.longitude];
    loc.createdAt = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]];;
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL result, NSError* error){
        NSLog(@"location chenged %@, %@", loc.lat, loc.lng);
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%s | %@", __PRETTY_FUNCTION__, error);
    
    if ([error code] == kCLErrorDenied) {
        [manager stopMonitoringSignificantLocationChanges];
    }
}

@end
