//
//  ViewController.m
//  AreaSelect
//
//  Created by wanghe on 16/8/29.
//  Copyright © 2016年 areaSelect.he.wang. All rights reserved.
//

#import "ViewController.h"
#import "AreaSelectViewController.h"

@interface ViewController ()
{
    UITextView* _tv;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _tv = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    _tv.backgroundColor = [UIColor greenColor];
    _tv.textColor = [UIColor blackColor];
    [self.view addSubview:_tv];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goViewController:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(100, 100, 200, 100);
    button.center = self.view.center;
    [button setTitle:@"go" forState:UIControlStateNormal];
    [self.view addSubview:button];
}
- (void) goViewController:(id)sender{
    AreaSelectViewController* vc = [AreaSelectViewController new];
    vc.selectComplete = ^(NSString* str){
        _tv.text = str;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
