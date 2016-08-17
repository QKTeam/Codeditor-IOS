//
//  CodeditorLayoutManager.h
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/17.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CodeditorLineNumberColumnWidth 40

@interface CodeditorLayoutManager : NSLayoutManager

@property (nonatomic) CGFloat codeditorLineNumberColumnWidth;
@property (nonatomic, strong) UIColor* lineNumberColor;
@property (nonatomic) NSUInteger lastParaLocation;
@property (nonatomic) NSUInteger lastParaNumber;


- (instancetype)initWithLineNumberColor:(UIColor*)lineNumberColor;

@end
