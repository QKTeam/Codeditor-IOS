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
    NSTimeInterval nowTimestamp = [[NSDate date] timeIntervalSince1970];
    NSString* timeStamp10 = [NSString stringWithFormat:@"%ld", (long)nowTimestamp];
    NSDate* stamp = [NSDate dateWithTimeIntervalSince1970:[timeStamp10 intValue]];
    return stamp;
}

NSString* timeString(NSDate* date) {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

@end
