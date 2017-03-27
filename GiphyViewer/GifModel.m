//
//  GifModel.m
//  GiphyViewer
//
//  Created by Igor Biarozkin on 27.03.17.
//  Copyright © 2017 Igor Biarozkin. All rights reserved.
//

#import "GifModel.h"

@implementation GifModel

-(id)initWithServerResponse:(NSDictionary*) responseObject
{
    self = [super init];
    if (self) {
        
        NSArray *arrayOfImagesTypes = [responseObject objectForKey:@"images"];
        NSDictionary *arrayOfFixedHeightSmallObject = [arrayOfImagesTypes valueForKey:@"fixed_height_small"];
        NSString *urlString = [arrayOfFixedHeightSmallObject valueForKey:@"url"];
        self.url = [NSURL URLWithString:urlString];
        
    }
    return self;
}

@end
