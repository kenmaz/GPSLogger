//
//  Location.h
//  GPSLogger
//
//  Created by 松前　健太郎 on 13/02/08.
//  Copyright (c) 2013年 kenmaz.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Location : NSManagedObject

@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * lng;
@property (nonatomic, retain) NSDate * createdAt;

@end
