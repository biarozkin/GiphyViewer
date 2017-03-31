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
#import "NSUserDefaults+Defined.h"

@interface SearchGifsViewController ()
@property (strong,nonatomic) NSMutableArray *searchGifsArray;
@end

@implementation SearchGifsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchGifsArray = [[NSMutableArray alloc]init];
    
    self.navigationItem.title = self.searchTerm;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self searchGifs];
    
}

#pragma mark - Actions

-(void)settingsButtonPressed {
    
    SettingsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SettingsViewController class])];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
    
//#warning - try to do that way - dispatch?
//    self.searchGifsArray = nil;
//    [self.collectionView reloadData];
    
    
}

#pragma mark - API

-(void)searchGifs {
    
    [[ServerManager sharedManager]requestGifsWithPhrase:self.searchTerm
                                              andRating:[NSUserDefaults standardUserDefaults].parentControl
                                              inCountOf:20
                                            withSuccess:^(NSArray *gifs) {
                                                
                                                [self.searchGifsArray addObjectsFromArray:gifs];
                                                
                                                if ([self.searchGifsArray count] == 0) {
                                                    [self noAnyResults];
                                                }
                                                
                                                [self.collectionView reloadData];

                                            } orFailure:^(NSError *error, NSInteger statusCode) {
                                                
                                                NSLog(@"error = %@, code = %ld", [error localizedDescription], statusCode);
                                                  
                                            }];
    
}

-(void)noAnyResults {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:@"No any GIFs were found"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.searchGifsArray count];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {


    GifCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchGifsViewControllerCell" forIndexPath:indexPath];
    cell.gif = [self.searchGifsArray objectAtIndex:indexPath.row];

    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(150, 150);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


@end
