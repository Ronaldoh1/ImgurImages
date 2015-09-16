//
//  Image.h
//  ImgurImages
//
//  Created by Ronald Hernandez on 9/16/15.
//  Copyright (c) 2015 Hardcoder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject
@property NSString *imageTitle;
@property NSString *imageURL;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
