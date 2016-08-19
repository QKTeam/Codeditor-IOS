//
//  TimeModel.m
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/19.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import "TimeModel.h"

@implementation TimeModel

NSDate* now() {
    NSTimeZone *zone = [NSTimeZone defaultTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:[NSDate date]];
    NSDate *nowDate=[NSDate dateWithTimeIntervalSinceNow:interval];
    return nowDate;
}

NSString* timeString(NSDate* date) {
    NSString* dateString = [NSString stringWithFormat:@"%@", date];
    return [dateString substringToIndex:dateString.length - 6];
}

@end
