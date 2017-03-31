//
//  ServerManager.m
//  GiphyViewer
//
//  Created by Igor Biarozkin on 27.03.17.
//  Copyright © 2017 Igor Biarozkin. All rights reserved.
//

#import "ServerManager.h"
#import "AFNetworking.h"
#import "GifModel.h"

@interface ServerManager()
@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
@end

@implementation ServerManager

static NSString * const publicAPIKey = @"dc6zaTOxFJmzC";

+ (ServerManager*) sharedManager {
    
    static ServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ServerManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSURL *url = [NSURL URLWithString:@"https://api.giphy.com/v1/gifs/"];
        self.sessionManager = [[AFHTTPSessionManager manager] initWithBaseURL:url];
        
    }
    return self;
}

-(void) requestTrendGifsInCountOf:(NSInteger) count
                      withSuccess:(void(^)(NSArray *gifs)) success
                        orFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    //http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC&limit=10
    //    //limit (optional) limits the number of results returned. By default returns 25 results.
    //    rating - limit results to those rated (y,g, pg, pg-13 or r).
    //    fmt - (optional) return results in html or json format (useful for viewing responses as GIFs to debug/test)
    
    NSDictionary *prms = [NSDictionary dictionaryWithObjectsAndKeys:
                          publicAPIKey,     @"api_key",
                          @(count),         @"limit",
                          nil];
    
    [self.sessionManager GET:@"trending"
                  parameters:prms
                    progress:^(NSProgress * _Nonnull downloadProgress) {
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        //NSLog(@"JSON: %@", responseObject);
                        NSArray *dictsArray = [responseObject objectForKey:@"data"];
                        NSMutableArray *objectsArray = [NSMutableArray array];
                        for (NSDictionary *dict in dictsArray) {
                            GifModel *gifObject = [[GifModel alloc]initWithServerResponse:dict];
                            [objectsArray addObject:gifObject];
                        }
                        
                        if (success) {
                            success(objectsArray);
                        }
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        
                        NSLog(@"Error: %@", error);
                        
                        if (failure) {
                            failure(error, [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode]);
                        }
                        
                    }];
}

-(void) requestGifsWithPhrase:(NSString*)phrase
                    andRating:(ParentControl)rating
                    inCountOf:(NSInteger) count
                  withSuccess:(void(^)(NSArray *gifs)) success
                    orFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    //http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC
    //    q - search query term or phrase
    //    limit - (optional) number of results to return, maximum 100. Default 25.
    //    rating - (optional) limit results to those rated (y,g, pg, pg-13 or r).
    
    NSDictionary *prms = [NSDictionary dictionaryWithObjectsAndKeys:
                          publicAPIKey,                     @"api_key",
                          @(count),                         @"limit",
                          phrase == nil ? @"" : phrase,     @"q",
                          stringFromParentControl(rating),  @"rating",
                          nil];
    
    [self.sessionManager GET:@"search"
                  parameters:prms
                    progress:^(NSProgress * _Nonnull downloadProgress) {
                        
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        //NSLog(@"JSON: %@", responseObject);
                        NSArray *dictsArray = [responseObject objectForKey:@"data"];
                        NSMutableArray *objectsArray = [NSMutableArray array];
                        for (NSDictionary *dict in dictsArray) {
                            GifModel *gifObject = [[GifModel alloc]initWithServerResponse:dict];
                            [objectsArray addObject:gifObject];
                        }
                        
                        if (success) {
                            success(objectsArray);
                        }
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        
                        NSLog(@"Error: %@", error);
                        
                        if (failure) {
                            failure(error, [[[error userInfo] objectForKey:AFNetworkingOperationFailingURLResponseErrorKey] statusCode]);
                        }
                        
                    }];
}

@end
