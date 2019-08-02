//
//  ViewController.m
//  CoreText
//
//  Created by mc on 2019/7/22.
//  Copyright © 2019 mc. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Easy.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    for (int i = 0; i < 1; i++) {
        
        UIView *a = [[UIView alloc] init];
          
        a.frame = CGRectMake(0, i, 300, 300);
        
        CGFloat hh = (i % 255) / 1000.0;
        UIColor *b = [UIColor redColor];
        a.easySet.backgroundColor([UIColor redColor]);
        self.view.easySet.addSubview(a);
    }
}


@end
