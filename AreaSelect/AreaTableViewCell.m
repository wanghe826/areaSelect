//
//  AreaTableViewCell.m
//  ShopManager
//
//  Created by wanghe on 16/8/24.
//  Copyright © 2016年 cn.wanghe. All rights reserved.
//

#import "AreaTableViewCell.h"

@implementation AreaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.statusBtn addTarget:self action:@selector(changeStatus:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
    }
    return self;
}


- (void) changeStatus:(UIButton*)sender{
    if(!self.isSelected){
        [sender setImage:[UIImage imageNamed:@"areaSelect1"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"areaSelect0"] forState:UIControlStateNormal];
    }
    self.isSelected = !self.selected;
    _selectBlock();
}
@end
