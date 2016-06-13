//
//  TBCircularProgress.h
//  TBCustomViews
//
//  Created by trongbangvp@gmail.com on 6/13/16.
//  Copyright © 2016 trongbangvp@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    MODE_CIRCLE,
    MODE_RECT
} TBProgressMode;

@interface TBCircularProgress : UIView

-(instancetype) initWithFrame:(CGRect)frame color:(UIColor*)color image:(UIImage*)img shapeMode:(TBProgressMode)mode direction:(int)direction;
-(void) setPercent:(float)p;

@end
