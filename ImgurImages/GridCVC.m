//
//  ImgurCVC.m
//  ImgurImages
//
//  Created by Ronald Hernandez on 9/16/15.
//  Copyright (c) 2015 Hardcoder. All rights reserved.
//

#import "GridCVC.h"
#import "GridImageCustomCell.h"
#import "ImageDataDownLoader.h"
#import "Image.h"
#import "FullScreenImageCVC.h"

@interface GridCVC ()<ImgurImageDataDownloaderDelegate, UICollectionViewDelegateFlowLayout>

@property  NSMutableArray *imageUrlsArray;
@property ImageDataDownLoader *downloader;

@end


#define kCellsPerRow 3 //this will contain how many cell we want to present.

@implementation GridCVC

static NSString *const apiURLString = @"https://api.imgur.com/3/gallery/random/random/1";
static NSString *const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];

    //based on the number of cells we want to present, use UICollectionViewFlowLayout to properly display them so spacing is fixed for eac screen.
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    CGFloat availableWidthForCells = CGRectGetWidth(self.collectionView.frame) - flowLayout.sectionInset.left - flowLayout.sectionInset.right - flowLayout.minimumInteritemSpacing * (kCellsPerRow - 1);
    CGFloat cellWidth = availableWidthForCells / kCellsPerRow;
    flowLayout.itemSize = CGSizeMake(cellWidth, flowLayout.itemSize.height);



    // hange the Nav Title and set it to white.
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    titleView.font = [UIFont fontWithName:@"Helvetica Bold" size:22];
    titleView.text = @"Random Images";
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.textColor = [UIColor redColor];
    [self.navigationItem setTitleView:titleView];

    //We need to allocate and initiaate our array which will contian the urls of the images.

    self.imageUrlsArray = [NSMutableArray new];

    // initialize and allocate the downloader objects.
    self.downloader = [ImageDataDownLoader new];
    self.downloader.parentVC = self;
    [self.downloader downloadImagesWithImgurApi:apiURLString];

}
//Custom Delegate Method to get image data.
//For each dictionary obtain the Image URL and Image Title.

-(void)gotImageData:(NSArray *)array{

    for (NSDictionary *dict in array) {


        Image *image = [[Image alloc] initWithDictionary:dict];

        [self.imageUrlsArray addObject:image];
    }

    [self.collectionView reloadData];

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.imageUrlsArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GridImageCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    Image *tempImage = (Image *)[self.imageUrlsArray objectAtIndex:indexPath.row];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^{
                       //get the image url and get data in background 

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


    // Configure the cell

    return cell;
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GridImageCustomCell* cell = (GridImageCustomCell *)[collectionView cellForItemAtIndexPath:indexPath];

    UIImage *imageForFullScreen = (UIImage *)cell.image.image;

    UIImageView *imageView = [UIImageView new];
    imageView.image = imageForFullScreen;

    [self.collectionView addSubview: imageView];

    [UIView animateWithDuration:1 animations:^{

        //if u want to move it to center before you make it big use all code
      //  cell.image.center = self.view.center;

    } completion:^(BOOL finished) {

        [UIView animateWithDuration:1 animations:^{

            //just use this if you want it to move to full screen
            cell.image.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];      
    }];

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    FullScreenImageCVC *destVC = (FullScreenImageCVC *)segue.destinationViewController;

    if ([segue.identifier isEqualToString:@"toFullScreen"]) {

      destVC.imageUrlsArray = [NSMutableArray arrayWithArray:self.imageUrlsArray.mutableCopy];

    }





}


@end
