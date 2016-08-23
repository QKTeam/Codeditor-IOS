//
//  FileModel.m
//  Codeditor-IOS
//
//  Created by PZH on 16/8/19.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import "FileModel.h"
#import "TimeModel.h"

@implementation FileModel

NSString* filePath(NSString* filename) {
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path=[docPath stringByAppendingPathComponent:filename];
//    NSLog(@"path = [%@]",path);
    return path;
}

- (instancetype)initWithFilename:(NSString*)filename
                     createdTime:(NSDate*)createdTime
                     updatedTime:(NSDate*)updatedTime
                         content:(NSString*)content {
    if(self = [super init]) {
        self.filename = filename;
        self.createdTime = createdTime;
        self.updatedTime = updatedTime;
        self.content = content;
    }
    return self;
}
- (instancetype)initWithFilename:(NSString*)filename
                         content:(NSString*)content {
    if(self = [self initWithFilename:filename
                         createdTime:now()
                         updatedTime:now()
                             content:content]) {
    }
    return self;
}


# pragma mark override setContent & setFilename to automatically setUpdatedTime
- (void)renewUpdatedTime {
    [self setUpdatedTime:now()];
}
- (void)renewContent:(NSString *)content {
    [self renewUpdatedTime];
    [self setContent:content];
}
- (BOOL)renewFilename:(NSString *)filename {
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath(filename)]) {
        return NO;
    }
    [self renewUpdatedTime];
    [self setFilename:filename];
    return YES;
}

#pragma mark file read
+ (NSArray<FileModel*>*)fileList {
    NSArray<NSString*>* filenames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filePath(@"") error:nil];
    NSMutableArray<FileModel*>* files = [[NSMutableArray alloc] init];
    for (NSString* filename in filenames) {
        NSDictionary* properties = [[NSFileManager defaultManager] attributesOfItemAtPath:[filePath(@"") stringByAppendingPathComponent:filename] error:nil];
        NSDate* createdTime = [properties objectForKey:NSFileCreationDate];
        NSDate* updatedTime = [properties objectForKey:NSFileModificationDate];
        FileModel* file = [[FileModel alloc] initWithFilename:filename createdTime:createdTime updatedTime:updatedTime content:@""];
        [files addObject:file];
    }
    [files sortUsingComparator:^NSComparisonResult(FileModel*  _Nonnull obj1, FileModel*  _Nonnull obj2) {
        if(obj1.updatedTime == obj2.updatedTime && obj1.createdTime == obj2.createdTime) {
            return [obj1.filename localizedCompare:obj2.filename];
        }
        if(obj1.updatedTime == obj2.updatedTime) {
            return -[obj1.createdTime compare:obj2.createdTime];
        }
        return -[obj1.updatedTime compare:obj2.updatedTime];
    }];
    return files;
}

+ (instancetype)fileWithFilename:(NSString*)filename {
    NSString* path = filePath(filename);
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    FileModel* file = [[FileModel alloc] initWithFilename:filename content:content];
    return file;
}

#pragma mark file modify
- (void)saveFile {
    NSString* path = filePath(self.filename);
    [self.content writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)deleteFile {
    [[self class] deleteFileWithFilename:self.filename];
}
+ (void)deleteFileWithFilename:(NSString*)filename {
    if ([[NSFileManager defaultManager] isDeletableFileAtPath:filePath(filename)]) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath(filename) error:nil];
    }
}

@end
