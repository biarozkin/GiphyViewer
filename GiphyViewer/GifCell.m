//
//  GifCell.m
//  GiphyViewer
//
//  Created by Igor Biarozkin on 27.03.17.
//  Copyright © 2017 Igor Biarozkin. All rights reserved.
//

#import "GifCell.h"
#import "UIView+WebCache.h"
#import "FLAnimatedImageView+WebCache.h"

@implementation GifCell

- (void)setGif:(GifModel *)gif {
    _gif = gif;
    [self updateGif];
}

- (void)updateGif {
    
    [self.imageView sd_setShowActivityIndicatorView:YES];
    [self.imageView sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [self.imageView sd_setImageWithURL:self.gif.url];
    
}

@end
