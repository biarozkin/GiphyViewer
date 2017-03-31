//
//  SettingsViewController.h
//  GiphyViewer
//
//  Created by Igor Biarozkin on 27.03.17.
//  Copyright © 2017 Igor Biarozkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *ratingControl;

- (IBAction)doneButtonAction:(UIBarButtonItem *)sender;

@end
