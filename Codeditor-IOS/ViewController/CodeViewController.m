//
//  CodeViewController.m
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/19.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import "CodeViewController.h"

@implementation CodeViewController

NSString* getSuffix(NSString* filename) {
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"\\.((?!\\.).)*?$" options:0 error:nil];
    __block NSString* suffix;
    [regex enumerateMatchesInString:filename options:0 range:NSMakeRange(0, filename.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        suffix = [filename substringWithRange:NSMakeRange(result.range.location + 1, result.range.length - 1)];
        *stop = YES;
    }];
    return suffix;
}

- (instancetype)initWithCodeData:(FileModel*)code {
    if(self = [super init]) {
        self.code = code;
        self.deleted = NO;
        
        self.navigationItem.rightBarButtonItems = @[
                                                    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteCode)]
                                                    ];
        self.navigationItem.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
        self.filenameInput = [[UITextField alloc] init];
        [self.filenameInput setAutocorrectionType:UITextAutocorrectionTypeNo];
        [self.filenameInput setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [self.filenameInput setTextAlignment:NSTextAlignmentCenter];
        [self.navigationItem.titleView addSubview:self.filenameInput];
        [self.filenameInput mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.navigationItem.titleView.mas_top);
            make.left.equalTo(self.navigationItem.titleView.mas_left);
            make.width.equalTo(self.navigationItem.titleView.mas_width);
            make.height.equalTo(self.navigationItem.titleView.mas_height);
        }];
        [self.filenameInput setText:self.code.filename];
        [self.filenameInput setDelegate:self];
        
        CodeditorLanguageType languageType = [CodeditorLanguage getLanguageByFileSuffixName:getSuffix(self.code.filename)];
        self.codeView = [[Codeditor alloc] initWithLanguage:languageType];
        [self.view addSubview:self.codeView];
        [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
            make.left.equalTo(self.view.mas_left);
        }];
        [self.codeView loadText:self.code.content];
    }
    return self;
}
- (instancetype)init {
    if(self = [self initWithCodeData:[[FileModel alloc] initWithFilename:[NSString stringWithFormat:@"%@", now()] content:@""]]) {
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    if(!self.deleted) {
        [self.code renewContent:self.codeView.text];
        [self.code saveFile];
    }
}

- (void)deleteCode {
    [self.code deleteFile];
    self.deleted = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.code deleteFile];
    while(![self.code renewFilename:self.filenameInput.text]) {
        [self.filenameInput setText:[NSString stringWithFormat:@"Another %@", self.filenameInput.text]];
    }
    [self.code saveFile];
    CodeditorLanguageType languageType = [CodeditorLanguage getLanguageByFileSuffixName:getSuffix(self.code.filename)];
    [self.codeView setLanguageType:languageType];
}

@end
