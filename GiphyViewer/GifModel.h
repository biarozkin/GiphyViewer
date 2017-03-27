//
//  GifModel.h
//  GiphyViewer
//
//  Created by Igor Biarozkin on 27.03.17.
//  Copyright © 2017 Igor Biarozkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GifModel : NSObject

@property (strong, nonatomic) NSURL *url;
-(id)initWithServerResponse:(NSDictionary*) responseObject;

@end
