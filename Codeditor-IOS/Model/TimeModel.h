//
//  TimeModel.h
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/19.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeModel : NSObject

NSDate* now();
NSString* timeString(NSDate* date);

@end
