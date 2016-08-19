//
//  CodeditorLanguage.h
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodeditorLanguage : NSObject

typedef enum {
    CodeditorLanguageC = 0,
    CodeditorLanguageCpp,
    CodeditorLanguagePascal,
    CodeditorLanguageJava,
    CodeditorLanguagePlain
} CodeditorLanguageType;


+ (CodeditorLanguageType)getLanguageByFileSuffixName:(NSString*)suffix;

@end
