//
//  FullScreenImageCVC.m
//  ImgurImages
//
//  Created by Ronald Hernandez on 9/18/15.
//  Copyright © 2015 Hardcoder. All rights reserved.
//

#import "FullScreenImageCVC.h"
#import "FullScreenCustomCell.h"
#import "Image.h"
@interface FullScreenImageCVC ()

@end
#define kCellsPerRow 1
@implementation FullScreenImageCVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;

    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;

    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [flowLayout setMinimumInteritemSpacing:0.0f];
    [flowLayout setMinimumLineSpacing:0.0f];
    [self.collectionView setPagingEnabled:YES];
    [flowLayout setItemSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)];
    [self.collectionView setCollectionViewLayout:flowLayout];




}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageUrlsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FullScreenCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    Image *tempImage = (Image *)[self.imageUrlsArray objectAtIndex:indexPath.row];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       //get the image url

                       NSURL *imageURL = [NSURL URLWithString:tempImage.imageURL];
                       NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                       UIImage *image = [UIImage imageWithData:imageData];




                       //Set the image for each cell on the main thread.
                       dispatch_sync(dispatch_get_main_queue(), ^{

                           if(imageData != nil){
                               cell.image.alpha = 0;

                               //Animate the loading of the image.
                               [UIView animateWithDuration:0.5 animations:^{



                                   cell.image.alpha = 1.0;
                                   cell.image.image = image;
                                   
                               }];
                               
                               
                           }
                           
                           
                           
                           
                       });
                   });

    // hange the Nav Title and set it to white.
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    titleView.font = [UIFont fontWithName:@"Helvetica Bold" size:20];
    titleView.adjustsFontSizeToFitWidth = YES;
    titleView.text = tempImage.imageTitle;
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.textColor = [UIColor redColor];
    [self.navigationItem setTitleView:titleView];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

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
