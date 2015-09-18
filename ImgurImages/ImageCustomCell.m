//
//  ImageCustomCell.m
//  ImgurImages
//
//  Created by Ronald Hernandez on 9/16/15.
//  Copyright (c) 2015 Hardcoder. All rights reserved.
//

#import "ImageCustomCell.h"

@implementation ImageCustomCell


-(void)awakeFromNib{

    //background color
    UIView *bgView =[[UIView alloc] initWithFrame:self.bounds];
    self.backgroundView =bgView;
    self.backgroundView.backgroundColor = [UIColor whiteColor];

    //selected background color

    //    UIView *selectedView =[[UIView alloc] initWithFrame:self.bounds];
    //    self.backgroundView =selectedView;
    //    self.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"square.png"]];
}

@end
