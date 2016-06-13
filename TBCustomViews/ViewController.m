//
//  ViewController.m
//  TBCustomViews
//
//  Created by trongbangvp@gmail.com on 6/13/16.
//  Copyright © 2016 trongbangvp@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import "TBCircularProgress.h"

@interface ViewController ()
{
    TBCircularProgress* pieView;
}
@property(nonatomic) CAShapeLayer* timerLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
#if 1
    float w = self.view.frame.size.width;
    float h = self.view.frame.size.height;
    pieView = [[TBCircularProgress alloc] initWithFrame:CGRectMake(0, 0, 200, 200) color:[UIColor whiteColor] image:[UIImage imageNamed:@"199113988000201.jpg"] shapeMode:MODE_CIRCLE direction:1];
    [self.view addSubview:pieView];
    pieView.center = CGPointMake(w/2, h/2);
    
    [NSTimer scheduledTimerWithTimeInterval:0.033 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
#else
    [self addPieShapeToView:self.view];
    [self animationForPieShape];
#endif
}

-(void) updateProgress
{
    static float p = 0;
    p += 0.004;
    if(p>1) p = 0;
    [pieView setPercent:p];
}

- (void)addPieShapeToView:(UIView *) view
{
    int thickness = 40;
    int x = view.bounds.size.width  / 2;
    int y = view.bounds.size.height / 2;
    int r = (x < y ? x : y) - thickness / 2;
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(x, y - r)];
    [path addArcWithCenter:CGPointMake(x, y) radius:r startAngle:-M_PI_2 endAngle:2.88 clockwise:YES];
    
    UIColor *blue = [UIColor blueColor];
    UIColor *clear = [UIColor clearColor];
    
    self.timerLayer = [CAShapeLayer new];
    self.timerLayer.frame = view.bounds;
    self.timerLayer.path = [path CGPath];
    self.timerLayer.strokeColor = [blue CGColor];
    self.timerLayer.fillColor = [clear CGColor];
    self.timerLayer.lineWidth = thickness;
    self.timerLayer.strokeEnd = 0;
    
    [view.layer addSublayer:self.timerLayer];
}

- (void)animationForPieShape
{
    CABasicAnimation *timerAnimation;
    timerAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    timerAnimation.duration = 1;
    timerAnimation.fromValue = @0.00;
    timerAnimation.toValue   = @0.43;
    self.timerLayer.strokeEnd = 0.43;
    [self.timerLayer addAnimation:timerAnimation forKey:nil];
}
@end
