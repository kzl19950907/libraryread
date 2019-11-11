//
//  FastRorwardingClass.m
//  MsgSendDemo
//
//  Created by 寇忠龙 on 2019/8/6.
//  Copyright © 2019 寇忠龙. All rights reserved.
//

#import "FastRorwardingClass.h"

@implementation FastRorwardingClass



+ (void)runMethodNotExist{
    
    NSLog(@"\n\n\nFastRorwardingClass %s", __FUNCTION__);
}

- (void)runInstanceMethodNotExist{
    
    NSLog(@"\n\n\nFastRorwardingClass %s", __FUNCTION__);

}

@end
