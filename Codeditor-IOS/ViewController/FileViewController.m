//
//  FileViewController.m
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/19.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import "FileViewController.h"
#import "CodeViewController.h"

@implementation FileViewController

- (instancetype)init {
    if(self = [super init]) {
        [self setTitle:@"Codeditor"];
        self.navigationItem.rightBarButtonItems = @[
                                                    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadFileList)],
                                                    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newCodeFile)]
                                                    ];
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated {
    [self reloadFileList];
}

- (void)reloadFileList {
    self.files = [FileModel fileList];
    [self.tableView reloadData];
}

- (void)newCodeFile {
    [self.navigationController pushViewController:[[CodeViewController alloc] init] animated:YES];
}

# pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FileModel* file = [FileModel fileWithFilename:self.files[indexPath.row].filename];
    CodeViewController* editor = [[CodeViewController alloc] initWithCodeData:file];
    [self.navigationController pushViewController:editor animated:YES];
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // UITableViewCellEditingStyleDelete
    [FileModel deleteFileWithFilename:self.files[indexPath.row].filename];
    [self reloadFileList];
}

# pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.files.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell.textLabel setText:self.files[indexPath.row].filename];
    return cell;
}

@end
