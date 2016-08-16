//
//  CodeditorPattern.m
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import "CodeditorPattern.h"

@implementation CodeditorPattern

- (instancetype)initWithPattern:(NSString*)pattern
                     leftOffset:(NSInteger)leftOffset
                    rightOffset:(NSInteger)rightOffset {
    if(self = [super init]) {
        self.pattern = pattern;
        self.leftOffset = leftOffset;
        self.rightOffset = rightOffset;
    }
    return self;
}

@end
