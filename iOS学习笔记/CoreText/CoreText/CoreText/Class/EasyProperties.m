//
//  EasyProperties.m
//  EasyUI
//
//  Created by mc on 2019/8/2.
//  Copyright © 2019 mc. All rights reserved.
//

#import "EasyProperties.h"
#import <objc/runtime.h>
#import <objc/message.h>


@implementation EasyProperties

- (EasyProperties * _Nonnull (^)(UIView * subView))addSubview{
    
    return  ^(UIView *subView){


        NSString *aSelector = [NSStringFromSelector(_cmd) stringByAppendingString:@":"];
        SEL cmd = NSSelectorFromString(@"v@:alpha");
        
        NSMethodSignature *methodSignature =[[self.view class] instanceMethodSignatureForSelector:cmd];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        [invocation setTarget:self.view];
        
        [invocation setSelector:cmd];
        //签名中方法参数的个数，内部包含了self和_cmd，所以参数从第3个开始
        NSInteger  signatureParamCount = methodSignature.numberOfArguments - 2;
        NSInteger requireParamCount = 1;
        NSInteger resultParamCount = MIN(signatureParamCount, requireParamCount);
        for (NSInteger i = 0; i < resultParamCount; i++)
        {
           id  obj = subView;
           [invocation setArgument:&obj atIndex:i+2];
        }
        [invocation invoke];

    return self;
    };
}



- (EasyProperties * _Nonnull (^)(CGFloat))alpha{
    
    return ^(CGFloat alpha){
        
        return self;
    };
}


- (EasyProperties * _Nonnull (^)(UIColor *))backgroundColor{
    
    return ^(UIColor *color){

        return self;
    };
}


@end
