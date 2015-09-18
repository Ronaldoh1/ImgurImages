//
//  FullScreenCustomCell.m
//  ImgurImages
//
//  Created by Ronald Hernandez on 9/18/15.
//  Copyright © 2015 Hardcoder. All rights reserved.
//

#import "FullScreenCustomCell.h"

@implementation FullScreenCustomCell

- (void) prepareForReuse {
    self.image.image = nil;

}

@end
