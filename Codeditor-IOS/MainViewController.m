//
//  MainViewController.m
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import "MainViewController.h"
#import "Codeditor.h"

@implementation MainViewController

- (instancetype)init {
    if(self = [super init]) {
        [self setTitle:@"Codeditor"];
        self.textView = [[Codeditor alloc] initWithLanguage:CodeditorLanguageCpp];
        [self.view addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
            make.left.equalTo(self.view.mas_left);
        }];
        [self.textView setText:@"#include <cstdio>\nint main() {\n\tprintf(\"hello world!\");\n\treturn 0;\n}\n"];
        [self.textView reloadData];
    }
    return self;
}

@end
