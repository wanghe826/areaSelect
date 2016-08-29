//
//  AreaTableHeaderView.m
//  ShopManager
//
//  Created by wanghe on 16/8/25.
//  Copyright © 2016年 cn.wanghe. All rights reserved.
//

#import "AreaTableHeaderView.h"

@implementation AreaTableHeaderView

- (instancetype) initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self = [[[NSBundle mainBundle] loadNibNamed:@"AreaTableHeaderView" owner:nil options:nil] lastObject];
        self.frame = frame;
    }
    return self;
}

- (void) awakeFromNib{
    [self.statusBtn addTarget:self action:@selector(selectedArea:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _collapse();
}

- (void)selectedArea:(UIButton*)sender{
    _selectSection();
}

@end
