//
//  Security.h
//  Codeditor-IOS
//
//  Created by GuessEver on 16/9/18.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Security : NSObject

NSString* base64Decode(NSString* str);
NSString* base64DecodeUrlsafe(NSString* str);


@end
