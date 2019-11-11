//
//  CustomClass.h
//  MsgSendDemo
//
//  Created by 寇忠龙 on 2019/8/4.
//  Copyright © 2019 寇忠龙. All rights reserved.
//


/*
    动态方法解析 Method Resolution
    消息转发机制
    1.在本类中搜索  类方法，如果没有找到 -> 父类 ->....-> NSObject
    2.如果NSObject 没有找到则进入消息转发 执行+(BOOL)resolveClassMethod:(SEL)sel 或+(BOOL)resolveInstanceMethod:(SEL)sel 方法 看有没有办法解决
 */



#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomClass : NSObject






+ (void)runMethodNotExist;

- (void)runInstanceMethodNotExist;
@end

NS_ASSUME_NONNULL_END
