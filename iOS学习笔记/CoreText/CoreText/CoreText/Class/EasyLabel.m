//
//  EasyLabel.m
//  EasyUI
//
//  Created by mc on 2019/8/1.
//  Copyright © 2019 mc. All rights reserved.
//

#import "EasyLabel.h"
#import <objc/runtime.h>

@interface EasyLabel ()
{
    
    UILabel *private_label;
}

@end


@implementation EasyLabel
+ (void)load{
    
    Class class = object_getClass((id)self);
    Method imgNameMethod = class_getClassMethod(class, @selector(description));
    Method ym_imgNameMethod = class_getClassMethod(class, @selector(easy_description))
    ;
    //
    BOOL didAddMethod = class_addMethod(class, @selector(description), method_getImplementation(ym_imgNameMethod), method_getTypeEncoding(ym_imgNameMethod));
    if (didAddMethod) {
        class_replaceMethod(class, @selector(easy_description), method_getImplementation(imgNameMethod), method_getTypeEncoding(imgNameMethod));
    }else{
        method_exchangeImplementations(imgNameMethod, ym_imgNameMethod);
    }
}


- (instancetype)init{
    
    if (self = [super init]) {
        
        private_label = [[UILabel alloc] init];
        
    }
    return self;
}

- (NSString *)easy_description{
    
    return @"HHH";
}





@end
