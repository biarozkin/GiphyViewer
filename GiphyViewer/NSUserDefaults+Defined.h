//
//  NSUserDefaults+Defined.h
//  GiphyViewer
//
//  Created by Igor Biarozkin on 29.03.17.
//  Copyright © 2017 Igor Biarozkin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    ParentControlU = 0,
    ParentControlG,
    ParentControlPG,
    ParentControlPG13,
    ParentControlR
} ParentControl;

@interface NSUserDefaults (Defined)
@property (nonatomic, assign) ParentControl parentControl;
@end

NSString* stringFromParentControl(ParentControl control);


