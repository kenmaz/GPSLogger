//
//  AppDelegate.h
//  GPSLogger
//
//  Created by 松前　健太郎 on 13/02/08.
//  Copyright (c) 2013年 kenmaz.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
