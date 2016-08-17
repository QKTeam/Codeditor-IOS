//
//  CodeditorColorAttribute.m
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import "CodeditorColorAttribute.h"

@implementation CodeditorColorAttribute

- (instancetype)initWithColor:(UIColor*)color
                         bold:(BOOL)bold
                         size:(CGFloat)size
                    underline:(BOOL)underline
                       italic:(BOOL)italic {
    if(self = [super init]) {
        self.color = color;
        self.bold = bold;
        self.size = size;
        self.underline = underline;
        self.italic = italic;
        self.attributesDictionary = @{
                                      NSForegroundColorAttributeName: color,
                                      NSFontAttributeName: bold ? [UIFont boldSystemFontOfSize:size] : [UIFont systemFontOfSize:size],
                                      NSUnderlineStyleAttributeName: underline ? @(NSUnderlineStyleSingle) : @(NSUnderlineStyleNone),
                                      NSObliquenessAttributeName: italic ? @0.5 : @0
                                      };
    }
    return self;
}

+ (instancetype)initWithColor:(UIColor*)color
                         bold:(BOOL)bold
                       italic:(BOOL)italic {
    return [[[self class] alloc] initWithColor:color
                                          bold:bold
                                          size:[UIFont systemFontSize]
                                     underline:NO
                                        italic:italic
            ];
}

+ (instancetype)initWithColor:(UIColor*)color
                         bold:(BOOL)bold {
    return [self initWithColor:color bold:bold italic:NO];
}

+ (instancetype)initWithColor:(UIColor*)color
                       italic:(BOOL)italic {
    return [self initWithColor:color bold:NO italic:italic];
}

+ (instancetype)initWithColor:(UIColor*)color {
    return [self initWithColor:color bold:NO];
}



@end
