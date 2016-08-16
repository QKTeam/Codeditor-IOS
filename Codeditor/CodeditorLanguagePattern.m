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
        case CodeditorLanguageC:
            return [self initWithLanguage:CodeditorLanguagePascal
                                  comment:@[ [[CodeditorPattern alloc] initWithPattern:@"//(.*)$" leftOffset:0 rightOffset:0],
                                             [[CodeditorPattern alloc] initWithPattern:@"/\\*(.*)\\*/" leftOffset:0 rightOffset:0]]
                                  grammar:@[
                                            [[CodeditorPattern alloc]initWithPattern:@"\\b(void|bool|char|float|int|double|short|long|unsigned|signed|struct|union|enum|typedef|sizeof|auto|static|register|extern|const|volatile|return|continue|break|goto|if|else|switch|case|default|for|do|while|include)\\b" leftOffset:0 rightOffset:0]
                                            ]
                                  keyword:@[
                                            [[CodeditorPattern alloc] initWithPattern:@"\\b([a-zA-Z0-9_]+?)\\(" leftOffset:0 rightOffset:1]]
                    ];
        case CodeditorLanguageCpp:
            return [self initWithLanguage:CodeditorLanguageCpp
                                  comment:@[
                                            [[CodeditorPattern alloc] initWithPattern:@"//(.*)$" leftOffset:0 rightOffset:0],
                                            [[CodeditorPattern alloc] initWithPattern:@"/\\*(.*)\\*/" leftOffset:0 rightOffset:0]
                                            ]
                                  grammar:@[
                                            [[CodeditorPattern alloc] initWithPattern:@"\\b(asm|auto|bool|break|case|catch|char|class|const|const_cast|continue|default|delete|do|double|dynamic_cast|else|enum|explicit|export|extern|false|float|for|friend|goto|if|inline|int|long|mutable|namespace|new|operator|private|protected |public|register|reinterpret_cast|return|short|signed|sizeof|static|static_cast|struct|switch|template|this|throw|true|try|typedef|typeid|typename|union|unsigned|using|virtual|void|volatile|wchar_t|while)\\b" leftOffset:0 rightOffset:0]
                                            ]
                                  keyword:@[
                                            [[CodeditorPattern alloc] initWithPattern:@"\\b([a-zA-Z0-9_]+?)\\(" leftOffset:0 rightOffset:1]
                                            ]
                    ];
            
        case CodeditorLanguagePascal:
            return [self initWithLanguage:CodeditorLanguagePascal
                                  comment:@[]
                                  grammar:@[
                                            [[CodeditorPattern alloc ] initWithPattern:@"\\b(absolute|abstract|and|array|as|asm|assembler|at|automated|begin|case|cdecl|class|const|constructor|contains|default|destructor|dispid|dispinterface|div|do|downto|dynamic|else|end|except|export|exports|external|far|file|finalization|finally|for|forward|function|goto|if|implementation|implements|in|index|inherited|initialization|inline|interface|is|label|library|message|mod|name|near|nil|nodefault|not|object|of|on|or|out|overload|override|package|packed|pascal|private|procedure|program|property|protected|public|published|raise|read|readonly|record|register|reintroduce|repeat|requires|resident|resourcestring|safecall|set|shl|shr|stdcall|stored|string|then|threadvar|to|try|type|unit|until|uses|var|virtual|while|with|write|writeonly|xor)\\b" leftOffset:0 rightOffset:0]
                                            ]
                                  keyword:@[
                                            [[CodeditorPattern alloc] initWithPattern:@"\\b([a-zA-Z0-9_]+?)\\(" leftOffset:0 rightOffset:1]]
                    ];
            
        case CodeditorLanguageJava:
            return [self initWithLanguage:CodeditorLanguageJava
                                  comment:@[]
                                  grammar:@[
                                            [[CodeditorPattern alloc]initWithPattern:@"\\b(abstract|boolean|break|byte|case|catch|char|class|continue|default|do|double|else|extends|false|final|finally|float|for|if|implements|import|instanceof|int|interface|long|native|new|null|package|private|protected|public|return|short|static|super|seitch|synchronized|this|throw|throws|transient|try|true|void|volatile|while)\\b" leftOffset:0 rightOffset:0]
                                            ]
                                  keyword:@[
                                            [[CodeditorPattern alloc] initWithPattern:@"\\b([a-zA-Z0-9_]+?)\\(" leftOffset:0 rightOffset:1]]
                    ];
            
        default:
            return [self initWithLanguage:CodeditorLanguagePlain
                                  comment:@[]
                                  grammar:@[]
                                  keyword:@[]];
    }
}


@end
