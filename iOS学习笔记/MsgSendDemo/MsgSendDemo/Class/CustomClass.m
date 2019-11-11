//
//  CustomClass.m
//  MsgSendDemo
//
//  Created by 寇忠龙 on 2019/8/4.
//  Copyright © 2019 寇忠龙. All rights reserved.
//

#import "CustomClass.h"
#import <objc/runtime.h>

#import "FastRorwardingClass.h"

@implementation CustomClass


///    动态方法解析 添加方法
/*
 
void fixMethodNotExistBug(id self, SEL sel){
    
    NSLog(@"\n\n\nfixMethodNotExistBug");
}


void fixInstanceMethodNotExistBug(id self, SEL sel){
    
    NSLog(@"\n\n\nfixInstanceMethodNotExistBug");
}


+ (BOOL)resolveClassMethod:(SEL)sel{
    
    NSLog(@"\n\n\n%s",__FUNCTION__);
    if(sel == @selector(runMethodNotExist)){
        ///***********************************************************************************************************************
        /// 此处重点 添加到元类Class
        /// 需要注意的是类方法的解析，动态增加方法时候，需要加到元类上，因为类方法列表是在元类对象中存储的。
        /// *********************************************************************************************************************
        class_addMethod(objc_getMetaClass(object_getClassName(self)), sel, (IMP)fixMethodNotExistBug, "v@:");
        NSLog(@"\n\n\nhh");
        return YES;

    }
    return [super resolveClassMethod:sel];
    
    
}


+ (BOOL)resolveInstanceMethod:(SEL)sel{
    
    NSLog(@"\n\n\n%s",__FUNCTION__);
    if(sel == @selector(runInstanceMethodNotExist)){
        
        class_addMethod(self, sel, (IMP)fixInstanceMethodNotExistBug, "v@:");
        NSLog(@"\n\n\nhh");
        return YES;
        
    }
    return [super resolveInstanceMethod:sel];
}
*/



/// 动态转发
/// 类方法 目前未知
/*

- (id)forwardingTargetForSelector:(SEL)aSelector{
    
    NSLog(@"\n\n\n forwardingTargetForSelector %@", NSStringFromSelector(aSelector));
    return [[FastRorwardingClass alloc] init];
}

 */


///
@end
