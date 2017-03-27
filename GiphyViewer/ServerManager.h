//
//  ServerManager.h
//  GiphyViewer
//
//  Created by Igor Biarozkin on 27.03.17.
//  Copyright © 2017 Igor Biarozkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerManager : NSObject

+ (ServerManager*) sharedManager;

-(void) requestTrendGifsInCountOf:(NSInteger) count
                      withSuccess:(void(^)(NSArray *gifs)) success
                        orFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

-(void) requestGifsWithPhrase:(NSString*)phrase
                    andRating:(NSString*)rating
                    inCountOf:(NSInteger) count
                  withSuccess:(void(^)(NSArray *gifs)) success
                    orFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

@end
