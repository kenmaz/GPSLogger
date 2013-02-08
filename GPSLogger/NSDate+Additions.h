//
//  NSDate+Additions.h
//  elmo-album
//
//  Created by 熊谷　一樹 on 13/01/09.
//  Copyright (c) 2013年 dwango. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Additions)

//現在の日付時刻を文字列で取得
- (NSString *)stringOfDateTime;
- (NSString *)stringOfDate;
- (NSString*)elapsedString;
@end
