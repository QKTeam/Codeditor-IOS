//
//  Security.m
//  Codeditor-IOS
//
//  Created by GuessEver on 16/9/18.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import "Security.h"

@implementation Security

NSString* base64Decode(NSString* str) {
    NSData* base64Data = [[NSData alloc] initWithBase64EncodedString:str options:0];
    return [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
}
NSString* base64DecodeUrlsafe(NSString* str) {
    str = [str stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    return base64Decode(str);
}

@end
