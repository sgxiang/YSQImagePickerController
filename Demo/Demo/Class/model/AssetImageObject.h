//
//  AssetImageObject.h
//  brandyond
//
//  Created by ysq on 14/6/30.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

//保存相册图片的model
@interface AssetImageObject : NSObject

@property(nonatomic,strong)NSString *imgURL;//图片地址

@property(nonatomic,strong)NSData *smallImageData;

-(id)initWithAsset:(ALAsset *)asset;  //初始化

@end
