//
//  CustomVC
//
//  Created by Kuan-Wei on 2016/8/11.
//  Copyright © 2016年 TaiwanMobile. All rights reserved.
//

#import "UIViewShadow.h"

@implementation UIViewShadow

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self.layer setShadowOffset:CGSizeMake(1, 1)];
        [self.layer setShadowColor:[[UIColor grayColor] CGColor]];
        [self.layer setShadowRadius:1.0];
        [self.layer setShadowOpacity:0.5];
        [self.layer setMasksToBounds:NO];
    }
    return self;
}

@end
