//
//  ViewController.m
//  Demo
//
//  Created by ysq on 14/7/1.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

#import "ViewController.h"
#import "YSQImagePicker.h"
@interface ViewController ()

@end

@implementation ViewController{
    NSMutableArray *_selectedAssetArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _selectedAssetArray = [[NSMutableArray alloc]init];
    
}

//Demo
- (IBAction)pressPicker:(id)sender {
    YSQImagePickerViewController *picker = [[YSQImagePickerViewController alloc]init];
    picker.maxSelectImageCount = 10;   //Set max count  .  Default is 9
    picker.selectedImageArray = _selectedAssetArray;   //Set selected image
    [self presentImagePickerController:picker animated:YES completion:nil finish:^(NSMutableArray *array) {
        _selectedAssetArray = array;
        [self resetScrollView];
    }];
}

-(void)resetScrollView{
    for (UIView *v in self.showView.subviews) {
        [v removeFromSuperview];
    }

    
    for (int i=0; i<[_selectedAssetArray count]; i++) {
        ALAsset *object = _selectedAssetArray[i];
        UIImageView *imageView = [[UIImageView alloc]init];
        UIImage *img = [ASSETHELPER getAssetThumbnail:object];
        imageView.image = img;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(i%4*60 , i/4*60, 60, 60);
        [self.showView addSubview:imageView];
    }

    self.showView.contentSize = CGSizeMake(240 , 60*([_selectedAssetArray count]/4 + 1));
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
