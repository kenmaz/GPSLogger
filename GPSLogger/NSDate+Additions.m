//
//  NSDate+Additions.m
//  elmo-album
//
//  Created by 熊谷　一樹 on 13/01/09.
//  Copyright (c) 2013年 dwango. All rights reserved.
//

#import "NSDate+Additions.h"

static const NSTimeInterval secPerMinute = 60;
static const NSTimeInterval secPerHour = secPerMinute * 60;
static const NSTimeInterval secPerDay = secPerHour * 24;
static const NSTimeInterval secPerMonth = secPerDay * 31;
static const NSTimeInterval secPerYear = secPerMonth * 12;

@implementation NSDate (Additions)

-(NSString *)stringOfDateTime {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY/MM/dd HH:mm";
    return [dateFormatter stringFromDate:self];
}

-(NSString *)stringOfDate {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY/MM/dd";
    return [dateFormatter stringFromDate:self];
}

- (NSString*)elapsedString {
    
    NSTimeInterval unixtime = [self timeIntervalSince1970];
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval diff = now - unixtime;
    
    if (diff < secPerMinute) {
        return @"数秒前";
    }
    else if (secPerMinute <= diff && diff < secPerHour) {
        return [NSString stringWithFormat:@"%d分前", (int)(diff / secPerMinute)];
    }
    else if (secPerHour <= diff && diff < secPerDay) {
        return [NSString stringWithFormat:@"%d時間前", (int)(diff / secPerHour)];
    }
    else if (secPerDay <= diff && diff < secPerMonth) {
        return [NSString stringWithFormat:@"%d日前", (int)(diff / secPerDay)];
    }
    else {
        return [NSString stringWithFormat:@"%d年前", (int)(diff / secPerYear)];
    }
}

@end
