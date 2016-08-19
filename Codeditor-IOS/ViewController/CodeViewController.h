//
//  CodeViewController.h
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/19.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Codeditor.h"
#import "Masonry.h"
#import "FileModel.h"

@interface CodeViewController : UIViewController <UITextFieldDelegate>

NSString* getSuffix(NSString* filename);

@property (nonatomic, strong) UITextField* filenameInput;
@property (nonatomic, strong) Codeditor* codeView;
@property (nonatomic, strong) FileModel* code;
@property (nonatomic) BOOL deleted;

- (instancetype)initWithCodeData:(FileModel*)code;

@end
