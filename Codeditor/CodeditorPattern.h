//
//  CodeditorPattern.h
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeditorPattern : NSObject

@property (nonatomic, strong) NSString* pattern;
@property NSInteger leftOffset;
@property NSInteger rightOffset;


- (instancetype)initWithPattern:(NSString*)pattern
                     leftOffset:(NSInteger)leftOffset
                    rightOffset:(NSInteger)rightOffset;

@end
