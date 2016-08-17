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
        self.topPadding = self.rightPadding = self.bottomPadding = 5;
        self.leftPadding = 30;
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

#pragma mark Attributes
- (void)setAttributes:(CodeditorColorAttribute*)attributes andPattern:(NSArray<CodeditorPattern*>*)patterns inRange:(NSRange)range {
    for (CodeditorPattern* pattern in patterns) {
        NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern.pattern options:NSRegularExpressionAnchorsMatchLines error:nil];
        [regex enumerateMatchesInString:self.textStorage.string options:0 range:range usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
//            NSLog(@"(%ld, %ld) = %@ -- %@", result.range.location, result.range.length, [self.textStorage.string substringWithRange:result.range], attributes.attributesDictionary);
            [self.textStorage setAttributes:attributes.attributesDictionary range:NSMakeRange(result.range.location + pattern.leftOffset, result.range.length - pattern.leftOffset - pattern.rightOffset)];
        }];
    }
}

- (void)reloadData {
    [self reloadDataInRange:NSMakeRange(0, self.textStorage.string.length)];
}
- (void)reloadDataInRange:(NSRange)range {
//    NSRange selectedRange = self.selectedRange;
    [self setAttributes:self.colorScheme.normal andPattern:self.languagePattern.normal inRange:range];
    [self setAttributes:self.colorScheme.grammar andPattern:self.languagePattern.grammar inRange:range];
    [self setAttributes:self.colorScheme.keyword andPattern:self.languagePattern.keyword inRange:range];
    [self setAttributes:self.colorScheme.symbol andPattern:self.languagePattern.symbol inRange:range];
    [self setAttributes:self.colorScheme.number andPattern:self.languagePattern.number inRange:range];
    [self setAttributes:self.colorScheme.character andPattern:self.languagePattern.character inRange:range];
    [self setAttributes:self.colorScheme.string andPattern:self.languagePattern.string inRange:range];
    [self setAttributes:self.colorScheme.comment andPattern:self.languagePattern.comment inRange:range];
//    [self setSelectedRange:selectedRange];
//    [self calculateLineNumbers];
}
- (void)calculateLineNumbers {
    [self setTextContainerInset:UIEdgeInsetsMake(self.topPadding, self.leftPadding, self.bottomPadding, self.rightPadding)];
}

# pragma mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    // NSLog(@"will reloadData")
//    NSLog(@"editedRange (%ld, %ld)", self.editedRange.location, self.editedRange.length);
    NSRange paragaphRange = [self.textStorage.string paragraphRangeForRange:self.editedRange];
//    NSLog(@"\n(%ld, %ld) = %@", paragaphRange.location, paragaphRange.length, [self.text substringWithRange:paragaphRange]);
    [self reloadDataInRange:paragaphRange];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    self.editedRange = NSMakeRange(range.location, text.length);
    return YES;
}


@end
