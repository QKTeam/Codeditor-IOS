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

@property NSRange editedRange;
@property (nonatomic, strong) CodeditorColorScheme* colorScheme;
@property (nonatomic, strong) CodeditorLanguagePattern* languagePattern;
@property CGFloat topPadding, rightPadding, bottomPadding, leftPadding;


- (instancetype)initWithLanguage:(CodeditorLanguageType)type andColorScheme:(CodeditorColorSchemeType)colorScheme;
- (instancetype)initWithLanguage:(CodeditorLanguageType)type;
- (void)reloadData;

@end
