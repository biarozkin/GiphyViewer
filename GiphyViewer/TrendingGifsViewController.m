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

@interface TrendingGifsViewController () <UISearchBarDelegate>
@property (strong,nonatomic) NSMutableArray *gifsArray;
@property (strong,nonatomic) UISearchBar *searchBar;
@end

@implementation TrendingGifsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gifsArray = [NSMutableArray array];
    [self getTrendingGIFS];
    
    //dismiss(?)
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.collectionView addGestureRecognizer:tap];
    
}

-(void)dismissKeyboard {
    [self.searchBar resignFirstResponder];
}

#pragma mark - API

-(void) getTrendingGIFS {
    
    [[ServerManager sharedManager]requestTrendGifsInCountOf:20 withSuccess:^(NSArray *gifs) {
        
        [self.gifsArray addObjectsFromArray:gifs];
        [self.collectionView reloadData];
        
    } orFailure:^(NSError *error, NSInteger statusCode) {
        
        NSLog(@"error = %@, code = %ld", [error localizedDescription], statusCode);
        
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


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        SearchCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionViewHeader" forIndexPath:indexPath];
        self.searchBar = headerView.searchBar;
        
        return headerView;
    }
    return nil;
}


#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if ([searchBar.text length] > 2 ) {
        SearchGifsViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SearchGifsViewController class])];
        vc.searchTerm = searchBar.text;
        [self.navigationController pushViewController:vc animated:YES];
    }

}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(150, 150);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

@end
