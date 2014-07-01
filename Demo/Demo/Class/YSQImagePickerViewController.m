//
//  YSQImagePickerViewController.m
//  Demo
//
//  Created by ysq on 14/7/1.
//  Copyright (c) 2014年 ysq. All rights reserved.
//
#import "YSQImagePickerViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "AssetImageObject.h"
#import "PickerSubViewController.h"

@interface YSQImagePickerViewController ()

@end

@implementation YSQImagePickerViewController{
    NSMutableArray *_groupNameArray;    //保存图片组名
    NSMutableArray *_imageAssetArray;     //保存图片对象
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"Photos";
    
    _groupNameArray = [[NSMutableArray alloc]init];
    _imageAssetArray = [[NSMutableArray alloc]init];
    if (!self.selectedImageArray) {
        self.selectedImageArray = [[NSMutableArray alloc]init];
    }
    
    [self configureNavigation];
    
    [self loadImage];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
    [self.view addSubview:self.tableView];
    
    if (self.maxSelectImageCount==0) {
        self.maxSelectImageCount = DEFAULTMAXSELECTIMAGECOUNT;
    }
    
}

/**
 *  配置头部导航
 */
-(void)configureNavigation{
    UIBarButtonItem *close = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"close"] style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    self.navigationItem.rightBarButtonItem = close;
}
/**
 *  关闭选择图片视图
 */
-(void)close{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  加载读取图片
 */
-(void)loadImage{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc]init];
        __block int groupIndex = -1;
        dispatch_group_t readAsset = dispatch_group_create();
        dispatch_group_enter(readAsset);
        
        [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (!group) {
                dispatch_group_leave(readAsset);
                return;
            }
            groupIndex++;
            NSString *g=[NSString stringWithFormat:@"%@",group];//获取相簿的组
            NSString *groupName = [[[g substringFromIndex:16]componentsSeparatedByString:@","][0]substringFromIndex:5]; //组名
            //保存组名
            [_groupNameArray addObject:groupName];
            [_imageAssetArray addObject:[@[]mutableCopy]];
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {//从group里面
                if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                    __block AssetImageObject *a = [[AssetImageObject alloc]initWithAsset:result];
                    //保存图片对象
                    [_imageAssetArray[groupIndex]addObject:a];
                    if (index==0) {
                        a.smallImageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:result.thumbnail], 0.5);
                    }else{
                        dispatch_async(dispatch_get_global_queue(0, 0), ^{
                            a.smallImageData = UIImageJPEGRepresentation([UIImage imageWithCGImage:result.thumbnail], 0.5);
                        });
                    }
                }
            }];
        } failureBlock:^(NSError *error) {
            NSLog(@"Enumerate the asset groups failed.");
            dispatch_group_leave(readAsset);
            
        }];
        
        dispatch_group_notify(readAsset, dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
    });
    
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_groupNameArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.imageView.image = [UIImage imageWithData:((AssetImageObject *)(_imageAssetArray[indexPath.row][0])).smallImageData];
    cell.textLabel.text = _groupNameArray[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


//推送到选择子视图
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PickerSubViewController *sub = [[PickerSubViewController alloc]initWithNibName:@"PickerSubViewController" bundle:nil];
    sub.imageAssetArray = _imageAssetArray[indexPath.row];
    sub.selectedArray = self.selectedImageArray;
    sub.title = _groupNameArray[indexPath.row];
    sub.subFinishSelectBlock = ^(NSMutableArray *array){
        self.selectedImageArray = [array mutableCopy];
    };
    sub.finishBlock = self.finishBlock;
    sub.maxSelectImageCount = self.maxSelectImageCount;
    [self.navigationController pushViewController:sub animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)setMaxSelectImageCount:(int)maxSelectImageCount{
    _maxSelectImageCount = maxSelectImageCount;
}


@end