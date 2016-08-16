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
    CodeditorLanguagePlain = 0,
    CodeditorLanguageCpp,
    CodeditorLanguagePascal,
    CodeditorLanguageJava,
} CodeditorLanguageType;

@end
