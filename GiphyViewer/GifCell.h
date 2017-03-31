//
//  GifCell.h
//  GiphyViewer
//
//  Created by Igor Biarozkin on 27.03.17.
//  Copyright © 2017 Igor Biarozkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GifModel.h"
#import <FLAnimatedImageView.h>

@interface GifCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet FLAnimatedImageView *imageView;
@property (strong, nonatomic) GifModel* gif;

@end
