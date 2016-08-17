//
//  Codeditor.m
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import "Codeditor.h"
#import "CodeditorLayoutManager.h"

@implementation Codeditor

- (instancetype)initWithLanguage:(CodeditorLanguageType)languageType andColorScheme:(CodeditorColorSchemeType)colorScheme {
    self.languagePattern = [CodeditorLanguagePattern initWithLanguage:languageType];
    self.colorScheme = [CodeditorColorScheme colorSchemeWithColorSchemeType:colorScheme];
    
    NSTextStorage* textStorage = [[NSTextStorage alloc] init];
    CodeditorLayoutManager* layoutManager = [[CodeditorLayoutManager alloc] initWithLineNumberColor:self.colorScheme.lineNumberColor];
    NSTextContainer* textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    [textContainer setWidthTracksTextView:YES];
    [textContainer setExclusionPaths:@[[UIBezierPath bezierPathWithRect:CGRectMake(0.0, 0.0, CodeditorLineNumberColumnWidth, CGFLOAT_MAX)]]];
    [layoutManager addTextContainer:textContainer];
    
    [textStorage removeLayoutManager:textStorage.layoutManagers.firstObject];
    [textStorage addLayoutManager:layoutManager];
    // code above for line numbers
    if(self = [super initWithFrame:CGRectZero textContainer:textContainer]) {
        [self setBackgroundColor:self.colorScheme.backgroundColor];
        [self setAutocorrectionType:UITextAutocorrectionTypeNo];
        [self setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [self setDelegate:self];
    }
    return self;
}

- (instancetype)init { // with default language type and default color scheme
    if(self = [self initWithLanguage:CodeditorLanguagePlain andColorScheme:CodeditorColorSchemeDefault]) {
    }
    return self;
}

- (instancetype)initWithLanguage:(CodeditorLanguageType)languageType { // with default color scheme
    if(self = [self initWithLanguage:languageType andColorScheme:CodeditorColorSchemeDefault]) {
    }
    return self;
}

#pragma mark Attributes
- (void)setAttributes:(CodeditorColorAttribute*)attributes andPattern:(NSArray<CodeditorPattern*>*)patterns inRange:(NSRange)range {
    for (CodeditorPattern* pattern in patterns) {
        // NSRegularExpressionAnchorsMatchLines: match it with every single line
        NSRegularExpressionOptions option = NSRegularExpressionDotMatchesLineSeparators;//NSRegularExpressionAnchorsMatchLines;
//        if(pattern.globalMatch) option = NSRegularExpressionDotMatchesLineSeparators;
        NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern.pattern options:option error:nil];
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
    if(self.languagePattern.language == CodeditorLanguagePlain) return;
    // NSRange selectedRange = self.selectedRange;
    // the order represents the priorities, so do not change it if you're not sure about it!
    [self setAttributes:self.colorScheme.normal andPattern:self.languagePattern.normal inRange:range];
    [self setAttributes:self.colorScheme.grammar andPattern:self.languagePattern.grammar inRange:range];
    [self setAttributes:self.colorScheme.keyword andPattern:self.languagePattern.keyword inRange:range];
    [self setAttributes:self.colorScheme.symbol andPattern:self.languagePattern.symbol inRange:range];
    [self setAttributes:self.colorScheme.number andPattern:self.languagePattern.number inRange:range];
    [self setAttributes:self.colorScheme.character andPattern:self.languagePattern.character inRange:range];
    [self setAttributes:self.colorScheme.string andPattern:self.languagePattern.string inRange:range];
    [self setAttributes:self.colorScheme.comment andPattern:self.languagePattern.comment inRange:range];
    // [self setSelectedRange:selectedRange];
}
- (void)textViewDidChange:(UITextView *)textView {
//    NSLog(@"textChanged");
//    NSLog(@"editedRange (%ld, %ld)", self.editedRange.location, self.editedRange.length);
//    NSRange paragaphRange = [self.textStorage.string paragraphRangeForRange:self.editedRange];
//    NSLog(@"\n(%ld, %ld) = %@", paragaphRange.location, paragaphRange.length, [self.text substringWithRange:paragaphRange]);
//    [self reloadDataInRange:paragaphRange];
    // cannot use reloadDataInRange, it may make comment block (/* ..(with '\n') */) error
    [self reloadData];
}
// get the edited range, just rerender the changed part, making it faster
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    self.editedRange = NSMakeRange(range.location, text.length);
    return YES;
}


@end
