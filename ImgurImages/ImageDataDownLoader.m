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


-(void)downloadImagesWithImgurApi:(NSString *)apiUrlString{

    //1. Create a URL with API String.

    NSURL *url = [NSURL URLWithString:apiUrlString];

    //2. We need to create a Request with the url we created.

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    [request setHTTPMethod:@"GET"];
    [request addValue:@"Client-Id bd3dcc5a4141802" forHTTPHeaderField:@"Authorization"];


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

-(void)processImageData:(NSData *)data{


    //We need to process the data and store the items in an array.
    NSDictionary *rawDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

    //get the dictionary that contain the image informations

    NSDictionary *imageDictionary = [rawDictionary objectForKey:@"data"];


    //convert to an array of dictionaries (these dicitonaries contian the image information).
    //
    NSMutableArray *tempImageArray = [NSMutableArray new];


    for (NSDictionary *imageDict in imageDictionary){


        [tempImageArray addObject:imageDict];

    }

    [self.parentVC gotImageData:tempImageArray];


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
