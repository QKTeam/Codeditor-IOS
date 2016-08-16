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
             [[[self class] alloc] initWithColorSchemeName:@"Default"
                                                Background:[UIColor whiteColor]
                                        andAttributeNormal:[CodeditorColorAttribute initWithColor:[UIColor blackColor]]
                                                   comment:[CodeditorColorAttribute initWithColor:[UIColor greenColor]]
                                                    number:[CodeditorColorAttribute initWithColor:[UIColor blueColor]]
                                                 character:[CodeditorColorAttribute initWithColor:[UIColor blueColor]]
                                                    string:[CodeditorColorAttribute initWithColor:[UIColor redColor]]
                                                   grammar:[CodeditorColorAttribute initWithColor:[UIColor purpleColor]]
                                                   keyword:[CodeditorColorAttribute initWithColor:[UIColor orangeColor]]
                                                    symbol:[CodeditorColorAttribute initWithColor:[UIColor purpleColor]]
              ]
             ];
}

+ (instancetype)colorSchemeWithColorSchemeType:(CodeditorColorSchemeType)type {
    return [self colorSchemes][type];
}

@end
