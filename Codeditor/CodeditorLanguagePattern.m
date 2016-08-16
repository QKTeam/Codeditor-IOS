//
//  CodeditorLanguagePattern.m
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import "CodeditorLanguagePattern.h"

@implementation CodeditorLanguagePattern

- (instancetype)initWithLanguage:(CodeditorLanguageType)type
                         comment:(NSArray<CodeditorPattern*>*)comment
                          number:(NSArray<CodeditorPattern*>*)number
                       character:(NSArray<CodeditorPattern*>*)character
                          string:(NSArray<CodeditorPattern*>*)string
                         grammar:(NSArray<CodeditorPattern*>*)grammar
                         keyword:(NSArray<CodeditorPattern*>*)keyword {
    if(self = [super init]) {
        self.normal = @[
                        [[CodeditorPattern alloc] initWithPattern:@"^(.*)$" leftOffset:0 rightOffset:0]
                        ];
        self.language = type;
        self.comment = comment;
        self.number = number;
        self.character = character;
        self.string = string;
        self.grammar = grammar;
        self.keyword = keyword;
        self.symbol = @[
                           [[CodeditorPattern alloc] initWithPattern:@"[^a-zA-Z0-9_\\[\\]\\(\\)\\{\\}]" leftOffset:0 rightOffset:0]
                           ];
    }
    return self;
}

+ (instancetype)initWithLanguage:(CodeditorLanguageType)type
                         comment:(NSArray<CodeditorPattern*>*)comment
                         grammar:(NSArray<CodeditorPattern*>*)grammar
                         keyword:(NSArray<CodeditorPattern*>*)keyword {
    return [[[self class] alloc] initWithLanguage:type
                                          comment:comment
                                           number:@[
                                                    [[CodeditorPattern alloc] initWithPattern:@"\\b[0-9]+\\b" leftOffset:0 rightOffset:0]
                                                    ]
                                        character:@[
                                                    [[CodeditorPattern alloc] initWithPattern:@"'(.*?)'" leftOffset:0 rightOffset:0]
                                                    ]
                                           string:@[
                                                    [[CodeditorPattern alloc] initWithPattern:@"\"(.*?)\"" leftOffset:0 rightOffset:0]
                                                    ]
                                          grammar:grammar
                                          keyword:keyword
            ];
}



+ (instancetype)initWithLanguage:(CodeditorLanguageType)type {
    switch (type) {
        case CodeditorLanguageCpp:
            return [self initWithLanguage:CodeditorLanguageCpp
                                  comment:@[
                                            [[CodeditorPattern alloc] initWithPattern:@"//(.*)$" leftOffset:0 rightOffset:0],
                                            [[CodeditorPattern alloc] initWithPattern:@"/\\*(.*)\\*/" leftOffset:0 rightOffset:0]
                                            ]
                                  grammar:@[
                                            [[CodeditorPattern alloc] initWithPattern:@"\\b(void|bool|char|float|int|double|short|long|unsigned|signed|struct|union|enum|typedef|sizeof|auto|static|register|extern|const|volatile|return|continue|break|goto|if|else|switch|case|default|for|do|while|include)\\b" leftOffset:0 rightOffset:0]
                                            ]
                                  keyword:@[
                                            [[CodeditorPattern alloc] initWithPattern:@"\\b(.*?)\\(" leftOffset:0 rightOffset:1]
                                            ]
                    ];
            
        case CodeditorLanguagePascal:
            return [self initWithLanguage:CodeditorLanguagePascal
                                  comment:@[]
                                  grammar:@[]
                                  keyword:@[]];
            
        case CodeditorLanguageJava:
            return [self initWithLanguage:CodeditorLanguageJava
                                  comment:@[]
                                  grammar:@[]
                                  keyword:@[]];
            
        default:
            return [self initWithLanguage:CodeditorLanguagePlain
                                  comment:@[]
                                  grammar:@[]
                                  keyword:@[]];
    }
}


@end
