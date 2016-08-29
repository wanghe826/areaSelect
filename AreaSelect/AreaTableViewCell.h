//
//  AreaTableViewCell.h
//  ShopManager
//
//  Created by wanghe on 16/8/24.
//  Copyright © 2016年 cn.wanghe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, strong) void (^selectBlock)(void);

@end
