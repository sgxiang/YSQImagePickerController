//
//  SelectMoreImageSubViewController.h
//  brandyond
//
//  Created by ysq on 14/6/30.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YSQImagePickerViewController.h"

@interface PickerSubViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)NSMutableArray *imageAssetArray;   //图片对象
@property(nonatomic,strong)NSMutableArray *selectedArray;  //已经选择的图片对象
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)void(^subFinishSelectBlock)(NSMutableArray *array);

@property(nonatomic,strong)FinishSelectImageBlock finishBlock;  //保存父类关闭的块调用

@property (weak, nonatomic) IBOutlet UIButton *selectImageNumber;

@property(nonatomic,assign)int maxSelectImageCount;  //最多选择的个数

@end
