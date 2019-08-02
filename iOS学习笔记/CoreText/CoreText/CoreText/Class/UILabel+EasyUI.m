//
//  UILabel+EasyUI.m
//  EasyUI
//
//  Created by mc on 2019/8/1.
//  Copyright © 2019 mc. All rights reserved.
//

#import "UILabel+EasyUI.h"


#import <objc/runtime.h>

@implementation UILabel (EasyUI)

+ (void)load{
    
    Class class = object_getClass((id)self);
       Method imgNameMethod = class_getClassMethod(class, @selector(description));
       Method ym_imgNameMethod = class_getClassMethod(class, @selector(easy_description))
       ;
       //
       BOOL didAddMethod = class_addMethod(class, @selector(description), method_getImplementation(ym_imgNameMethod), method_getTypeEncoding(ym_imgNameMethod));
       if  (didAddMethod) {
           class_replaceMethod(class, @selector(easy_description), method_getImplementation(imgNameMethod), method_getTypeEncoding(imgNameMethod));
       }else{
           method_exchangeImplementations(imgNameMethod, ym_imgNameMethod);
       }
}

- (NSString *)easy_description{
    
    return @"hhh";
}

@end
