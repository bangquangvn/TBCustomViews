//
//  TBCircularProgress.m
//  TBCustomViews
//
//  Created by trongbangvp@gmail.com on 6/13/16.
//  Copyright © 2016 trongbangvp@gmail.com. All rights reserved.
//

#import "TBCircularProgress.h"

@interface TBCircularProgress()
@property(nonatomic,strong) CAShapeLayer *shapeLayer;
@property(nonatomic) TBProgressMode mode;
@property(nonatomic) int direction;
@property(nonatomic) float pieRadius;
@end

@implementation TBCircularProgress

-(id) initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.clipsToBounds = YES;
        float w = frame.size.width;
        float h = frame.size.height;
        float maxDimension = MAX(w,h);
        if(_mode == MODE_CIRCLE)
        {
            _pieRadius = maxDimension/2.0;
            self.layer.cornerRadius = MIN(w,h)/2;
        } else
        {
            _pieRadius = sqrtf(w*w/4 + h*h/4);
        }
        
        CGPoint arcCenter=self.center;
#if 0
        UIBezierPath *_bezierpath=[UIBezierPath   bezierPathWithArcCenter:arcCenter
                                                                    radius:_pieRadius
                                                                startAngle:-M_PI_2
                                                                  endAngle:M_PI * 2 -M_PI_2
                                                                 clockwise:YES];
        [_bezierpath addLineToPoint:self.center];
        [_bezierpath closePath];
#else
        UIBezierPath *_bezierpath = [UIBezierPath new];
        [_bezierpath moveToPoint:CGPointMake(arcCenter.x, arcCenter.y - _pieRadius)];
        [_bezierpath addArcWithCenter:arcCenter radius:_pieRadius startAngle:-M_PI_2 endAngle:-M_PI_2 + M_PI*2 clockwise: (_direction==0)? YES:NO];
#endif
        
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.fillColor=[UIColor clearColor].CGColor;
        _shapeLayer.opacity = 0.5;
        _shapeLayer.path = _bezierpath.CGPath;
        _shapeLayer.strokeColor = [[UIColor greenColor] CGColor];
        _shapeLayer.lineWidth = _pieRadius * 2;
        _shapeLayer.actions = @{@"strokeEnd": [NSNull null]};
        _shapeLayer.position = CGPointMake(-self.center.x+self.frame.size.width/2,-self.center.y+self.frame.size.height/2);
        [self.layer addSublayer:_shapeLayer];
    }
    return self;
}

-(instancetype) initWithFrame:(CGRect)frame color:(UIColor*)color image:(UIImage*)img shapeMode:(TBProgressMode)mode direction:(int)direction
{
    _mode = mode;
    _direction = direction;
    if(self = [self initWithFrame:frame])
    {
        _shapeLayer.strokeColor = color.CGColor;
        self.layer.contents = (id)img.CGImage;
        self.layer.contentsGravity = @"resizeAspectFill";
    }
    return self;
}

-(void) setPercent:(float)p
{
    NSLog(@"%s : %f", __func__, p);
    if(_direction == 0)
    {
        _shapeLayer.strokeEnd = p;
    } else
    {
        _shapeLayer.strokeEnd = 1.0 - p;
    }
}

@end
