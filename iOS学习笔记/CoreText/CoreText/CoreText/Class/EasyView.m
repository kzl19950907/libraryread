//
//  EasyView.m
//  EasyUI
//
//  Created by mc on 2019/8/1.
//  Copyright © 2019 mc. All rights reserved.
//

#import "EasyView.h"

@implementation EasyView

+ (instancetype)easy_makeView:(void (^)(EasyView * _Nonnull))make{
    
    EasyView *a = [[EasyView alloc] init];
    make(a);
    return a;
    
}







@end
