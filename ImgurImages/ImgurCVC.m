//
//  ImgurCVC.m
//  ImgurImages
//
//  Created by Ronald Hernandez on 9/16/15.
//  Copyright (c) 2015 Hardcoder. All rights reserved.
//

#import "ImgurCVC.h"
#import "ImageCustomCell.h"
#import "ImageDataDownLoader.h"

@interface ImgurCVC ()<ImgurImageDataDownloaderDelegate>

@property NSMutableArray *imageURLsArray;
@property ImageDataDownLoader *downloader;

@end

@implementation ImgurCVC

static NSString const *apiURLString = @"";
static NSString const *reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
//    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    // Do any additional setup after loading the view.i


    // hange the Nav Title and set it to white.
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    titleView.font = [UIFont fontWithName:@"Helvetica Bold" size:22];
    titleView.text = @"T";
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.textColor = [UIColor redColor];
    [self.navigationItem setTitleView:titleView];

    //We need to allocate and initiaate our array which will contian the urls of the images.

    self.imageURLsArray = [NSMutableArray new];

    // initialize and allocate the downloader objects.
    self.downloader = [ImageDataDownLoader new];
    self.downloader.parentVC = self;
    [self.downloader downloadImagesWithImgurApi:apiURLString];

}

-(void)gotImageData:(NSArray *)array{

    NSLog(@"%@", array);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    [self.collectionView.collectionViewLayout invalidateLayout];
    UICollectionViewCell *__weak cell = [self.collectionView cellForItemAtIndexPath:indexPath]; // Avoid retain cycles
    void (^animateChangeWidth)() = ^()
    {
        CGRect frame = cell.frame;
        frame.size = cell.intrinsicContentSize;
        cell.frame = frame;
    };

    // Animate

    [UIView transitionWithView:cell duration:0.1f options: UIViewAnimationOptionCurveLinear animations:animateChangeWidth completion:nil];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
