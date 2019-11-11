//
//  ViewController.m
//  MsgSendDemo
//
//  Created by 寇忠龙 on 2019/8/4.
//  Copyright © 2019 寇忠龙. All rights reserved.
//

#import "ViewController.h"
#import "CustomClass.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [CustomClass runMethodNotExist];

//    CustomClass *temp = [[CustomClass alloc] init];
//    [temp runInstanceMethodNotExist];
}


@end
