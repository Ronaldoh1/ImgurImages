//
//  Image.m
//  ImgurImages
//
//  Created by Ronald Hernandez on 9/16/15.
//  Copyright (c) 2015 Hardcoder. All rights reserved.
//

#import "Image.h"

@implementation Image

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{

    self = [super self];

    self.imageTitle = [dictionary objectForKey:@"title"];
    self.imageURL = [dictionary objectForKey:@"link"];
    


    return self;
}


@end
