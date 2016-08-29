//
//  AreaSelectViewController.h
//  ShopManager
//
//  Created by wanghe on 16/8/24.
//  Copyright © 2016年 cn.wanghe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AreaSelectViewController : UIViewController


@property(nonatomic, strong) void (^selectComplete) (NSString* area);
@end
