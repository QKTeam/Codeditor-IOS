//
//  CodeditorLanguage.m
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import "CodeditorLanguage.h"

@implementation CodeditorLanguage

+ (NSArray<NSString*>*)suffixesOfLanguageType:(CodeditorLanguageType)type {
    switch (type) {
        case CodeditorLanguageC:
            return @[@"c"];
        case CodeditorLanguageCpp:
            return @[@"cpp", @"cxx", @"cc"];
        case CodeditorLanguagePascal:
            return @[@"pas"];
        case CodeditorLanguageJava:
            return @[@"java"];
        default:
            return @[];
    }
}

+ (BOOL)isSuffix:(NSString*)currentSuffix equalToType:(CodeditorLanguageType)type {
    for(NSString* suffix in [self suffixesOfLanguageType:type]) {
        if([currentSuffix isEqualToString:suffix]) {
            return YES;
        }
    }
    return NO;
}

+ (CodeditorLanguageType)getLanguageByFileSuffixName:(NSString*)suffix {
    suffix = [suffix lowercaseString];
    for(CodeditorLanguageType type = 0; type < CodeditorLanguagePlain; type++) {
        if([self isSuffix:suffix equalToType:type]) {
            return type;
        }
    }
    return CodeditorLanguagePlain;
}

@end
