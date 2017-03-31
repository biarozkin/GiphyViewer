//
//  SettingsViewController.m
//  GiphyViewer
//
//  Created by Igor Biarozkin on 27.03.17.
//  Copyright © 2017 Igor Biarozkin. All rights reserved.
//

#import "SettingsViewController.h"
#import "SearchGifsViewController.h"
#import "NSUserDefaults+Defined.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


#pragma mark - Actions

- (IBAction)doneButtonAction:(UIBarButtonItem *)sender {
    
    ParentControl control = self.ratingControl.selectedSegmentIndex;
    NSLog(@"self.ratingControl.selectedSegmentIndex: %lu", control);
    [NSUserDefaults standardUserDefaults].parentControl = control;

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
@end
