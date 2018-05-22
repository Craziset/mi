//
//  QuartView.m
//  magicCamera
//
//  Created by corepass on 2018/5/19.
//  Copyright © 2018年 XXX. All rights reserved.
//

#import "QuartView.h"

@implementation QuartView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing codeCGContextClip(ctx);
    if (self.A1Arr.count != 0) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
//        CGContextSetLineWidth(ctx, 2);
//        /**
//         *使用指定的颜色来设置 CGContextRef 的线条的颜色
//         */
//        CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
//        /**
//         *使用指定的颜色来设置 CGContextRef 的填充颜色
//         */
        CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);
        
        for (NSInteger i = 0;i<self.A1Arr.count;i++)
        {
            NSString* zuoStr = self.A1Arr[i];
            NSArray* zuoArr = [zuoStr componentsSeparatedByString:@","];
            float xZuobiao = [zuoArr[0] floatValue]*_xishu;
            float yZuobiao = [zuoArr[1] floatValue]*_xishu;
            if (i == 0)
            {
                CGContextMoveToPoint(ctx, xZuobiao, yZuobiao);
                self.A1X = xZuobiao;
                self.A1Y = yZuobiao;
            }else
            {
                CGContextAddLineToPoint(ctx, xZuobiao, yZuobiao);
            }
            
        }
        
        CGContextClosePath(ctx);
        
        for (NSInteger i = 0;i<self.A2Arr.count;i++)
        {
            NSString* zuoStr = self.A2Arr[i];
            NSArray* zuoArr = [zuoStr componentsSeparatedByString:@","];
            float xZuobiao = [zuoArr[0] floatValue]*_xishu;
            float yZuobiao = [zuoArr[1] floatValue]*_xishu;
            if (i == 0)
            {
                CGContextMoveToPoint(ctx, xZuobiao, yZuobiao);
                self.A2X = xZuobiao;
                self.A2Y = yZuobiao;
            }else
            {
                CGContextAddLineToPoint(ctx, xZuobiao, yZuobiao);
            }
            
        }
        
        
        CGContextClosePath(ctx);
//        CGContextStrokePath(ctx);
//        CGContextTranslateCTM(ctx, 0, self.frame.size.height);
//
//        CGContextScaleCTM(ctx, 1.0, -1.0);
        CGContextClip(ctx);
//        CGContextDrawImage(ctx, CGRectMake(_A1X, _A1Y, _width, _height), self.image.CGImage);
//        CGContextDrawImage(ctx, CGRectMake(_A2X, _A2Y, _width, _height), self.image.CGImage);
        [self.image drawInRect:CGRectMake(_A1X, _A1Y, _width/_xishu, _height/_xishu)];
        [self.image drawInRect:CGRectMake(_A2X, _A2Y, _width/_xishu, _height/_xishu)];
        
        
       
    }
    
}


@end
