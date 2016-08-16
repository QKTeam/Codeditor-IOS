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
        case CodeditorLanguageCpp:
            return @[@"cpp", @"cxx", @"cc"];
        case CodeditorLanguagePascal:
            return @[@"pas"];
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
    if([self isSuffix:suffix equalToType:CodeditorLanguageCpp]) {
        return CodeditorLanguageCpp;
    }
    if([self isSuffix:suffix equalToType:CodeditorLanguagePascal]) {
        return CodeditorLanguagePascal;
    }
    if([self isSuffix:suffix equalToType:CodeditorLanguageJava]) {
        return CodeditorLanguageJava;
    }
    return CodeditorLanguagePlain;
}

@end
