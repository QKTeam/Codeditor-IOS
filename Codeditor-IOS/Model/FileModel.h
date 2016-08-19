//
//  FileModel.h
//  Codeditor-IOS
//
//  Created by PZH on 16/8/19.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileModel : NSObject

NSDate* now();

@property (nonatomic, strong) NSString* filename;
@property (nonatomic, strong) NSDate* createdTime;
@property (nonatomic, strong) NSDate* updatedTime;
@property (nonatomic, strong) NSString* content;


- (instancetype)initWithFilename:(NSString*)filename
                         content:(NSString*)content;
+ (NSArray<FileModel*>*)fileList;
+ (instancetype)fileWithFilename:(NSString*)filename;
- (void)saveFile;
- (void)deleteFile;
+ (void)deleteFileWithFilename:(NSString*)filename;


- (void)renewContent:(NSString *)content;
- (BOOL)renewFilename:(NSString *)filename;

@end
