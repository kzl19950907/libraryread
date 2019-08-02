//
//  CustomView.m
//  CoreText
//
//  Created by mc on 2019/7/22.
//  Copyright © 2019 mc. All rights reserved.
//

#import "CustomView.h"
#import <CoreText/CoreText.h>

@implementation CustomView

- (void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    
    CGPathAddRect(path, NULL, self.bounds);
    
    //    CGPathAddArc(path, NULL, 2*M_PI,200,400, 100, 2*M_PI, true);
    
    //    CGContextLine
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"CoreText是需要自己处理绘制，不像UILabel等最上层的控件 ，所以我们必须在drawRect中绘制，为了更好地使用，我们稍微封装一下，自定义一个UIView。" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attr);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attr length]), path, NULL);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
//    1.普通绘制

//    CTFrameDraw(frame, context);
//
//    CFRelease(frame);
//    CFRelease(path);
//    CFRelease(framesetter);

    
//    2.CTLine绘制
    CFArrayRef lines = CTFrameGetLines(frame);
    CFIndex  count = CFArrayGetCount(lines);
//    CFArrayRef temp = (__bridge CFArrayRef)[[NSArray alloc] initWithObjects:CGPointZero count:count];

    CGPoint origins[count];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    

    for (CFIndex lineIndex = 0; lineIndex < count; lineIndex++) {
        
        CGPoint lineOrigin = origins[lineIndex];
        
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines, lineIndex);
        
        CGFloat descent = 0.f, ascent = 0.f, lineLeading = 0.f;
        
        CTLineGetTypographicBounds(lineRef, &ascent, &descent, &lineLeading);
        
        CGFloat penOffset = CTLineGetPenOffsetForFlush(lineRef, NSTextAlignmentLeft, rect.size.width);
        CGFloat y = lineOrigin.y - descent - [[UIFont systemFontOfSize:17] descender];
        CGContextSetTextPosition(context, penOffset /*+ self.xOffset*/, y /*- self.yOffset*/);
        

        CTLineDraw(lineRef, context);

    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
