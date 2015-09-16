//
//  ImageDataDownLoader.h
//  ImgurImages
//
//  Created by Ronald Hernandez on 9/16/15.
//  Copyright (c) 2015 Hardcoder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//create protocol
@protocol ImgurImageDataDownloaderDelegate <NSObject>

-(void)gotImageData:(NSArray *)array;

@end

@interface ImageDataDownLoader : NSObject

@property id<ImgurImageDataDownloaderDelegate>parentVC;

-(void)downloadImagesWithImgurApi:(NSString *)apiString;

@end
