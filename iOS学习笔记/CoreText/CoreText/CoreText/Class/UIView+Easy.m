//
//  UIView+Easy.m
//  EasyUI
//
//  Created by mc on 2019/8/1.
//  Copyright © 2019 mc. All rights reserved.
//

#import "UIView+Easy.h"
#import <objc/runtime.h>



static char kEasy_propertiesKey;

@implementation UIView (Easy)


- (void)setEasy_properties:(EasyProperties *)easy_properties{
    
    objc_setAssociatedObject(self, &kEasy_propertiesKey, easy_properties, OBJC_ASSOCIATION_RETAIN);
    
}


- (EasyProperties *)easy_properties{
    
    if (objc_getAssociatedObject(self, &kEasy_propertiesKey) == nil) {
        
        EasyProperties *temp = [[EasyProperties alloc] init];
        temp.view = self;
        objc_setAssociatedObject(self, &kEasy_propertiesKey, temp, OBJC_ASSOCIATION_RETAIN);
    }
    return objc_getAssociatedObject(self, &kEasy_propertiesKey);
}

- (EasyProperties *)easySet{
    
    return [self easy_properties];
}
@end
