//
//  FileViewController.h
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/19.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileModel.h"

@interface FileViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<FileModel*>* files;

@end
