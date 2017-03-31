//
//  NSUserDefaults+Defined.m
//  GiphyViewer
//
//  Created by Igor Biarozkin on 29.03.17.
//  Copyright © 2017 Igor Biarozkin. All rights reserved.
//

#import "NSUserDefaults+Defined.h"

@implementation NSUserDefaults (Defined)

- (ParentControl)parentControl {
    return [self integerForKey:NSStringFromSelector(@selector(parentControl))];
}

- (void)setParentControl:(ParentControl)parentControl {
    [self setInteger:parentControl forKey:NSStringFromSelector(@selector(parentControl))];
}

@end

NSString* stringFromParentControl(ParentControl control) {
    switch (control) {
        case ParentControlU:
            return @"y";
            
        case ParentControlG:
            return @"g";
            
        case ParentControlPG:
            return @"pg";
            
        case ParentControlPG13:
            return @"pg13";
            
        case ParentControlR:
            return @"r";
            
    }
    return nil;
}
