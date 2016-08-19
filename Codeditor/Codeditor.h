//
//  Codeditor.h
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodeditorColorScheme.h"
#import "CodeditorLanguagePattern.h"

@interface Codeditor : UITextView <UITextViewDelegate>

@property (nonatomic, strong) CodeditorColorScheme* colorScheme;
@property (nonatomic, strong) CodeditorLanguagePattern* languagePattern;

@property (nonatomic) NSRange editedRange; // for optimize range for rerender data attributes

@property (nonatomic, strong) NSString* lastTypedString; // for judge whether should remove indent


- (void)setLanguageType:(CodeditorLanguageType)languageType;
- (instancetype)initWithLanguage:(CodeditorLanguageType)type andColorScheme:(CodeditorColorSchemeType)colorScheme;
- (instancetype)initWithLanguage:(CodeditorLanguageType)type;
- (void)reloadData;
- (void)loadText:(NSString*)text;

@end
