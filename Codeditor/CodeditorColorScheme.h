//
//  CodeditorColorScheme.h
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodeditorColorAttribute.h"

@interface CodeditorColorScheme : NSObject

typedef enum {
    CodeditorColorSchemeDefault = 0
} CodeditorColorSchemeType;

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) UIColor* backgroundColor;
@property (nonatomic, strong) CodeditorColorAttribute* normal;
@property (nonatomic, strong) CodeditorColorAttribute* comment;
@property (nonatomic, strong) CodeditorColorAttribute* number;
@property (nonatomic, strong) CodeditorColorAttribute* character;
@property (nonatomic, strong) CodeditorColorAttribute* string;
@property (nonatomic, strong) CodeditorColorAttribute* grammar;
@property (nonatomic, strong) CodeditorColorAttribute* keyword;
@property (nonatomic, strong) CodeditorColorAttribute* symbol;


+ (NSArray<CodeditorColorScheme*>*)colorSchemes;
+ (instancetype)colorSchemeWithColorSchemeType:(CodeditorColorSchemeType)type;

@end
