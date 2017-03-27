//
//  TrendingGifsViewController.m
//  GiphyViewer
//
//  Created by Igor Biarozkin on 27.03.17.
//  Copyright © 2017 Igor Biarozkin. All rights reserved.
//

#import "TrendingGifsViewController.h"
#import "SearchGifsViewController.h"
#import "SearchCollectionReusableView.h"
#import "ServerManager.h"
#import "GifCell.h"

@interface TrendingGifsViewController ()
@property (strong,nonatomic) NSMutableArray *gifsArray;
@end

@implementation TrendingGifsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gifsArray = [NSMutableArray array];
    [self getTrendingGIFS];
    
}

#pragma mark - API

-(void) getTrendingGIFS {
    
    [[ServerManager sharedManager]requestTrendGifsInCountOf:20 withSuccess:^(NSArray *gifs) {
        
        [self.gifsArray addObjectsFromArray:gifs];
        [self.collectionView reloadData];
        
    } orFailure:^(NSError *error, NSInteger statusCode) {
        
#warning - rewrite message log
        NSLog(@"SMTH HAPPENED WHILE retrieveing from server");
        
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.gifsArray count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        
    GifCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    cell.gif = [self.gifsArray objectAtIndex:indexPath.row];
    
    return cell;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionViewHeader" forIndexPath:indexPath];
        
        return headerView;
    }
    return nil;
}


#pragma mark - UISearchBarDelegate

#warning (undone) - to sent keyWord to SearchGifsViewController
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
 
    SearchGifsViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SearchGifsViewController class])];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(150, 150);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


//#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
