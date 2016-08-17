//
//  CodeditorLanguagePattern.h
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CodeditorLanguage.h"
#import "CodeditorPattern.h"

@interface CodeditorLanguagePattern : NSObject

@property CodeditorLanguageType language;
@property (nonatomic, strong) NSArray<CodeditorPattern*>* normal;
@property (nonatomic, strong) NSArray<CodeditorPattern*>* comment;
@property (nonatomic, strong) NSArray<CodeditorPattern*>* number;
@property (nonatomic, strong) NSArray<CodeditorPattern*>* character;
@property (nonatomic, strong) NSArray<CodeditorPattern*>* string;
@property (nonatomic, strong) NSArray<CodeditorPattern*>* grammar; // system
@property (nonatomic, strong) NSArray<CodeditorPattern*>* keyword; // something like function name or language used variables
@property (nonatomic, strong) NSArray<CodeditorPattern*>* symbol;

+ (instancetype)initWithLanguage:(CodeditorLanguageType)type;

@end
