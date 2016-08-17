//
//  CodeditorColorAttribute.h
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/16.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeditorColorAttribute : NSObject

@property (nonatomic, strong) NSDictionary* attributesDictionary;
@property (nonatomic, strong) UIColor* color;
@property (nonatomic) BOOL bold;
@property (nonatomic) CGFloat size;
@property (nonatomic) BOOL underline;
@property (nonatomic) BOOL italic;


+ (instancetype)initWithColor:(UIColor*)color
                         bold:(BOOL)bold
                       italic:(BOOL)italic;
+ (instancetype)initWithColor:(UIColor*)color
                         bold:(BOOL)bold;
+ (instancetype)initWithColor:(UIColor*)color
                       italic:(BOOL)italic;
+ (instancetype)initWithColor:(UIColor*)color;

@end
