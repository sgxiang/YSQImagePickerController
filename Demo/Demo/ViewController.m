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

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    YSQImagePickerViewController *picker = [[YSQImagePickerViewController alloc]init];
    picker.maxSelectImageCount = 10;
    [self presentImagePickerController:picker animated:YES completion:nil finish:^(NSArray *array) {
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
