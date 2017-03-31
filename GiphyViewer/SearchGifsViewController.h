//
//  SearchGifsViewController.h
//  GiphyViewer
//
//  Created by Igor Biarozkin on 27.03.17.
//  Copyright © 2017 Igor Biarozkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingsViewController.h"

@interface SearchGifsViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSString* searchTerm;
@end
