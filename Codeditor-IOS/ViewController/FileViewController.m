//
//  FileViewController.m
//  Codeditor-IOS
//
//  Created by GuessEver on 16/8/19.
//  Copyright © 2016年 QKTeam. All rights reserved.
//

#import "FileViewController.h"
#import "CodeViewController.h"
#import "TimeModel.h"

@implementation FileViewController

- (instancetype)init {
    if(self = [super init]) {
        [self setTitle:@"Codeditor"];
        self.navigationItem.rightBarButtonItems = @[
                                                    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadFileList)],
                                                    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newCodeFile)]
                                                    ];
        UICollectionViewFlowLayout *collectionLayout = [[UICollectionViewFlowLayout alloc] init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:collectionLayout];
        [self.collectionView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.left.equalTo(self.view.mas_left);
            make.width.equalTo(self.view.mas_width);
            make.height.equalTo(self.view.mas_height);
        }];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
        [self.collectionView setDelegate:self];
        [self.collectionView setDataSource:self];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newCodeFileWithData:) name:@"newCodeWithData" object:nil];
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self reloadFileList];
}

- (void)reloadFileList {
    self.files = [FileModel fileList];
    [self.collectionView reloadData];
}

- (void)newCodeFile {
    [self.navigationController pushViewController:[[CodeViewController alloc] init] animated:YES];
}
- (void)newCodeFileWithData:(NSNotification*)notification {
    CodeViewController* editor = [[CodeViewController alloc] init];
    [editor.codeView loadText:[notification.userInfo objectForKey:@"code"]];
    [editor.filenameInput setText:[notification.userInfo objectForKey:@"filename"]];
    [editor.filenameInput becomeFirstResponder];
    [self.navigationController pushViewController:editor animated:YES];
}

# pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FileModel* file = [FileModel fileWithFilename:self.files[indexPath.row].filename];
    CodeViewController* editor = [[CodeViewController alloc] initWithCodeData:file];
    [self.navigationController pushViewController:editor animated:YES];
}

# pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.files.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    [cell.layer setBorderColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor];
    [cell.layer setBorderWidth:1];
    
    UILabel* updatedTime = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 130, 30)];
    [updatedTime setText:timeString(self.files[indexPath.row].updatedTime)];
    [updatedTime setTextColor:[UIColor grayColor]];
    [updatedTime setFont:[UIFont systemFontOfSize:10]];
    [updatedTime setTextAlignment:NSTextAlignmentCenter];
    [cell.contentView addSubview:updatedTime];
    
    UILabel* suffix = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 130, 70)];
    NSString* type = getSuffix(self.files[indexPath.row].filename);
    if(!type || [type isEqualToString:@""]) type = @"plain";
    type = [type uppercaseString];
    [suffix setText:type];
    [suffix setTextColor:[UIColor colorWithRed:219/255.0 green:50/255.0 blue:54/255.0 alpha:1.0]];
    [suffix setTextAlignment:NSTextAlignmentCenter];
    [suffix setFont:[UIFont fontWithName:@"Menlo" size:20]];
    [cell.contentView addSubview:suffix];
    
    UIView* splitLine = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 130, 1)];
    [splitLine setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5]];
    [cell.contentView addSubview:splitLine];
    
    UILabel* filename = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 130, 60)];
    [filename setText:self.files[indexPath.row].filename];
    [filename setTextAlignment:NSTextAlignmentCenter];
    [filename setFont:[UIFont fontWithName:@"Menlo" size:[UIFont systemFontSize]]];
    [filename setNumberOfLines:0];
    [cell.contentView addSubview:filename];
    
    return cell;
}

# pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(150, 150);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(20, 30, 0, 30);
}

@end
