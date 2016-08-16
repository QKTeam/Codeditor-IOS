//
//  Codeditor.m
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import "Codeditor.h"

@implementation Codeditor

- (instancetype)init {
    if(self = [super init]) {
        self.languagePattern = [CodeditorLanguagePattern initWithLanguage:CodeditorLanguagePlain];
        self.colorScheme = [CodeditorColorScheme colorSchemeWithColorSchemeType:CodeditorColorSchemeDefault];
        [self setBackgroundColor:self.colorScheme.backgroundColor];
        [self setAutocorrectionType:UITextAutocorrectionTypeNo];
        [self setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [self setDelegate:self];
    }
    return self;
}

- (instancetype)initWithLanguage:(CodeditorLanguageType)languageType andColorScheme:(CodeditorColorSchemeType)colorScheme {
    if(self = [self init]) {
        self.languagePattern = [CodeditorLanguagePattern initWithLanguage:languageType];
        self.colorScheme = [CodeditorColorScheme colorSchemeWithColorSchemeType:colorScheme];
        [self setBackgroundColor:self.colorScheme.backgroundColor];
    }
    return self;
}

- (instancetype)initWithLanguage:(CodeditorLanguageType)languageType {
    if(self = [self initWithLanguage:languageType andColorScheme:CodeditorColorSchemeDefault]) {
    }
    return self;
}

- (void)setAttributes:(CodeditorColorAttribute*)attributes andPattern:(NSArray<CodeditorPattern*>*)patterns To:(NSMutableAttributedString**)strPoint {
    NSMutableAttributedString* str = *strPoint;
    for (CodeditorPattern* pattern in patterns) {
        NSRegularExpression* regrex = [NSRegularExpression regularExpressionWithPattern:pattern.pattern options:NSRegularExpressionAnchorsMatchLines error:nil];
        NSArray<NSTextCheckingResult*>* results = [regrex matchesInString:str.string options:0 range:NSMakeRange(0, str.string.length)];
        for (NSTextCheckingResult* result in results) {
//            NSLog(@"(%ld, %ld) = %@ -- %@", result.range.location, result.range.length, [str.string substringWithRange:result.range], attributes.attributesDictionary);
            [str setAttributes:attributes.attributesDictionary range:NSMakeRange(result.range.location + pattern.leftOffset, result.range.length - pattern.leftOffset - pattern.rightOffset)];
        }
    }
    *strPoint = str;
}

- (void)reloadData {
    NSRange selectedRange = self.selectedRange;
    NSMutableAttributedString* text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@ ", self.text]];
    [self setAttributes:self.colorScheme.normal andPattern:self.languagePattern.normal To:&text];
    [self setAttributes:self.colorScheme.grammar andPattern:self.languagePattern.grammar To:&text];
    [self setAttributes:self.colorScheme.keyword andPattern:self.languagePattern.keyword To:&text];
    [self setAttributes:self.colorScheme.symbol andPattern:self.languagePattern.symbol To:&text];
    [self setAttributes:self.colorScheme.number andPattern:self.languagePattern.number To:&text];
    [self setAttributes:self.colorScheme.character andPattern:self.languagePattern.character To:&text];
    [self setAttributes:self.colorScheme.string andPattern:self.languagePattern.string To:&text];
    [self setAttributes:self.colorScheme.comment andPattern:self.languagePattern.comment To:&text];
    [self setAttributedText:[text attributedSubstringFromRange:NSMakeRange(1, text.length-2)]];
    [self setSelectedRange:selectedRange];
}

- (void)textViewDidChange:(UITextView *)textView {
//    NSLog(@"will reloadData");
    [self reloadData];
}

@end
