//
//  CodeditorColorScheme.m
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import "CodeditorColorScheme.h"

@implementation CodeditorColorScheme

- (instancetype)initWithColorSchemeName:(NSString*)name
                             Background:(UIColor*)backgroundColor
                        lineNumberColor:(UIColor*)lineNumberColor
                            matchedPair:(CodeditorColorAttribute*)matchedPair
                     andAttributeNormal:(CodeditorColorAttribute*)normal
                                comment:(CodeditorColorAttribute*)comment
                                 number:(CodeditorColorAttribute*)number
                              character:(CodeditorColorAttribute*)character
                                 string:(CodeditorColorAttribute*)string
                                grammar:(CodeditorColorAttribute*)grammar
                                keyword:(CodeditorColorAttribute*)keyword
                                 symbol:(CodeditorColorAttribute*)symbol {
    if(self = [super init]) {
        self.name = name;
        self.backgroundColor = backgroundColor;
        self.lineNumberColor = lineNumberColor;
        self.matchedPair = matchedPair;
        self.normal = normal;
        self.comment = comment;
        self.number = number;
        self.character = character;
        self.string = string;
        self.grammar = grammar;
        self.keyword = keyword;
        self.symbol = symbol;
    }
    return self;
}

+ (NSArray<CodeditorColorScheme*>*)colorSchemes {
    return @[
             [[[self class] alloc] initWithColorSchemeName:@"XCode"
                                                Background:RGB2(0xFFFFFF)
                                           lineNumberColor:RGB2(0x808080)
                                               matchedPair:[CodeditorColorAttribute initWithColor:RGB2(0x000000) backgroundColor:RGB2(0xF4C20D)]
                                        andAttributeNormal:[CodeditorColorAttribute initWithColor:RGB2(0x000000)]
                                                   comment:[CodeditorColorAttribute initWithColor:RGB2(0x007400)]
                                                    number:[CodeditorColorAttribute initWithColor:RGB2(0x1C00CF)]
                                                 character:[CodeditorColorAttribute initWithColor:RGB2(0x1C00CF)]
                                                    string:[CodeditorColorAttribute initWithColor:RGB2(0xC41A16)]
                                                   grammar:[CodeditorColorAttribute initWithColor:RGB2(0xAA0D91)]
                                                   keyword:[CodeditorColorAttribute initWithColor:RGB2(0x2E0D6E)]
                                                    symbol:[CodeditorColorAttribute initWithColor:RGB2(0x000000)]
              ]
             ];
}

+ (instancetype)colorSchemeWithColorSchemeType:(CodeditorColorSchemeType)type {
    return [self colorSchemes][type];
}

@end
