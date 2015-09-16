//
//  ImageDataDownLoader.m
//  ImgurImages
//
//  Created by Ronald Hernandez on 9/16/15.
//  Copyright (c) 2015 Hardcoder. All rights reserved.
//

#import "ImageDataDownLoader.h"

//1. We need to get the Image information and store it in an array and provide it to the ParentVC (Collection View Controller).

@implementation ImageDataDownLoader


-(void)downloadImagesWithImgurApi:(NSString *)apiString{

    //1. Create a URL with API String.

    NSURL *url = [NSURL URLWithString:apiString];

    //2. We need to create a Request with the url we created.

    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //3. now that we have the request, we need to get the image data from the Imgur Web Service.

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        //check if the connection has failed - this mean data will be nill.

        if (data != nil){

            [self processImageData:data];

        }else{

            [self displayAlertMessage:@"Error Downloading Data" andWith:connectionError.localizedDescription];


        }


    }];


}

-(void)processData:(NSData *)data{

    //Need to store all of the items in an arary.
    //We get back a dictionary of dictionary
    NSDictionary *itemsDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

    NSMutableArray *tempProductsArray = [NSMutableArray new];

    for (NSDictionary *ProductDict in itemsDictionary) {

        [tempProductsArray addObject:ProductDict];

    }

   // [self.parentVC gotToMoProducts:tempProductsArray];
    
}

-(void)processImageData:(NSData *)data{


    //We need to process the data and store the items in an array.


    NSLog(@"%@",data);

}

//Helper Methods to display alert to user.

-(void)displayAlertMessage:(NSString *)title andWith:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title
                                                   message:message
                                                  delegate:self
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil, nil];
    [alert show];
}
@end
