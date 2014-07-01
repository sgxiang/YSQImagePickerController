//
//  AssetImageObject.m
//  brandyond
//
//  Created by ysq on 14/6/30.
//  Copyright (c) 2014年 ysq. All rights reserved.
//

#import "AssetImageObject.h"

@implementation AssetImageObject

-(id)initWithAsset:(ALAsset *)asset{
    if (self==[super init]) {
        self.imgURL = [NSString stringWithFormat:@"%@",asset.defaultRepresentation.url];
    }
    return self;
}

@end
