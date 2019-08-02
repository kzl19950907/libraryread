//
//  EasyProperties.h
//  EasyUI
//
//  Created by mc on 2019/8/2.
//  Copyright © 2019 mc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EasyProperties : NSObject

@property (nonatomic, weak) UIView *view;




- (EasyProperties* (^) (UIView *))addSubview;
- (EasyProperties* (^) (CGRect))frame;
- (EasyProperties* (^) (CGRect))bounds;
- (EasyProperties* (^) (CGPoint))center;
- (EasyProperties* (^) (CGAffineTransform))transform;
- (EasyProperties* (^) (CATransform3D))transform3D;
- (EasyProperties* (^) (BOOL))multipleTouchEnabled;
- (EasyProperties* (^) (BOOL))exclusiveTouch;
- (EasyProperties* (^) (BOOL))clipsToBounds;
- (EasyProperties* (^) (CGFloat))alpha;
- (EasyProperties* (^) (UIColor *))backgroundColor;
- (EasyProperties* (^) (BOOL))hidden;

- (void)install;
@end

NS_ASSUME_NONNULL_END
