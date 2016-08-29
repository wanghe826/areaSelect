//
//  AreaTableHeaderView.h
//  ShopManager
//
//  Created by wanghe on 16/8/25.
//  Copyright © 2016年 cn.wanghe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaTableHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *arrow;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;


@property (nonatomic, strong) void (^collapse) (void);
@property (nonatomic, strong) void (^selectSection) (void);
@end
