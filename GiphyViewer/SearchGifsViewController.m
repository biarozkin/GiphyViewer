//
//  SearchGifsViewController.m
//  GiphyViewer
//
//  Created by Igor Biarozkin on 27.03.17.
//  Copyright © 2017 Igor Biarozkin. All rights reserved.
//

#import "SearchGifsViewController.h"
#import "SettingsViewController.h"
#import "ServerManager.h"
#import "GifCell.h"

@interface SearchGifsViewController ()
@property (strong,nonatomic) NSMutableArray *searchGifsArray;
@end

@implementation SearchGifsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchGifsArray = [[NSMutableArray alloc]init];
    [self searchGifs];
    
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Settings"
                                       style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(settingsButtonPressed)];
    self.navigationItem.rightBarButtonItem = settingsButton;
    
}

#pragma mark - Actions

-(void)settingsButtonPressed {
    
    SettingsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SettingsViewController class])];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
    
}

#pragma mark - API

-(void)searchGifs {
    
    [[ServerManager sharedManager]requestGifsWithPhrase:@"cat"
                                              andRating:nil
                                              inCountOf:20
                                            withSuccess:^(NSArray *gifs) {
                                                
                                                [self.searchGifsArray addObjectsFromArray:gifs];
                                                [self.collectionView reloadData];

                                            } orFailure:^(NSError *error, NSInteger statusCode) {
                                                  
#warning - rewrite message log
                                                  NSLog(@"SMTH HAPPENED WHILE retrieveing from server");
                                                  
                                            }];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.searchGifsArray count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

#warning - check with CollectionViewCell identifier
    GifCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell2" forIndexPath:indexPath];
    cell.gif = [self.searchGifsArray objectAtIndex:indexPath.row];
    
//    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell2" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    
    return cell;
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
