//
//  AreaSelectViewController.m
//  ShopManager
//
//  Created by wanghe on 16/8/24.
//  Copyright © 2016年 cn.wanghe. All rights reserved.
//
#import "AreaTableHeaderView.h"
#import "AreaSelectViewController.h"

#import "AreaTableViewCell.h"


@interface AreaSelectViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView* _tableView;
    
    NSMutableArray<NSNumber*>* _switches;       //是否展开的开关
    NSArray* _headerDatasources;
    NSDictionary<NSString*, NSArray*>* _datasources;
    
    NSDictionary<NSString*, NSMutableArray*>* _statusDatasources;   //所有地区（除了总分区）是否被选中的状态保存
    NSMutableArray<NSNumber*>* _allSectionsStatus;  //所有分区是否被选中的状态保存
}
@end

@implementation AreaSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择地区";
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 100, 30);
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btn addTarget:self action:@selector(completeAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
    [self initData];
    [self setupTableView];
}


- (void) completeAction:(UIButton*)sender{
    NSString* str = [self scanForSelectedArea];
    if(str){
        _selectComplete(str);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString*) scanForSelectedArea{      //获取所有选中的地区
    NSMutableString* retStr = [NSMutableString new];
    
    for(int i=0; i<_allSectionsStatus.count; ++i){

        NSNumber* num = _allSectionsStatus[i];
        if([num boolValue]){
            [retStr appendString:_headerDatasources[i]];
            [retStr appendString:@"、"];
            NSLog(@"NNNN-->> %@", retStr);
        }else{
            NSString* key = _headerDatasources[i];
            for(int i=0; i<_statusDatasources[key].count; ++i){
                NSNumber* num = _statusDatasources[key][i];
                if([num boolValue]){
                    [retStr appendString:_datasources[key][i]];
                    [retStr appendString:@"、"];
                }
            }
        }
    }
    if(retStr.length == 0){
        return nil;
    }
    return [retStr substringToIndex:retStr.length-1];
}

- (void) initData{
    _switches = [[NSMutableArray alloc] initWithArray:@[@(NO),@(NO),@(NO),@(NO),@(NO),@(NO),@(NO)]];
    _headerDatasources = @[@"华东", @"华北", @"华南", @"华中",@"西北",@"西南",@"东北"];
    _allSectionsStatus = [[NSMutableArray alloc] initWithArray:@[@(NO),@(NO),@(NO),@(NO),@(NO),@(NO),@(NO)]];
    _datasources = @{@"华东":@[@"上海",@"江苏",@"浙江",@"安徽",@"福建",@"山东"],
                     @"华北":@[@"北京",@"天津",@"河北",@"山西",@"内蒙古"],
                     @"华南":@[@"广东",@"广西",@"海南"],
                     @"华中":@[@"湖北",@"湖南",@"河南",@"江西"],
                     @"西北":@[@"宁夏",@"新疆",@"青海",@"陕西",@"甘肃"],
                     @"西南":@[@"四川",@"云南",@"贵州",@"西藏",@"重庆"],
                     @"东北":@[@"辽宁",@"吉林",@"黑龙江"]};
    
    _statusDatasources = @{ @"华东": [[NSMutableArray alloc] initWithArray:@[@(NO),@(NO),@(NO),@(NO),@(NO),@(NO),]],
                            @"华北": [[NSMutableArray alloc] initWithArray:@[@(NO),@(NO),@(NO),@(NO),@(NO)]],
                            @"华南": [[NSMutableArray alloc] initWithArray:@[@(NO),@(NO),@(NO)]],
                            @"华中": [[NSMutableArray alloc] initWithArray:@[@(NO),@(NO),@(NO),@(NO),]],
                            @"西北": [[NSMutableArray alloc] initWithArray:@[@(NO),@(NO),@(NO),@(NO),@(NO),]],
                            @"西南": [[NSMutableArray alloc] initWithArray:@[@(NO),@(NO),@(NO),@(NO),@(NO),]],
                            @"东北": [[NSMutableArray alloc] initWithArray:@[@(NO),@(NO),@(NO)]]};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 44.f;
    [_tableView registerNib:[UINib nibWithNibName:@"AreaTableViewCell" bundle:nil] forCellReuseIdentifier:@"CellId"];
    [self.view addSubview:_tableView];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AreaTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    NSString* key = _headerDatasources[indexPath.section];
    cell.title.text = _datasources[key][indexPath.row];
    if([_statusDatasources[key][indexPath.row] boolValue]){
        [cell.statusBtn setImage:[UIImage imageNamed:@"areaSelect1"] forState:UIControlStateNormal];
    }else{
        [cell.statusBtn setImage:[UIImage imageNamed:@"areaSelect0"] forState:UIControlStateNormal];
    }
    cell.selectBlock = ^(){
        _statusDatasources[key][indexPath.row] = @(![_statusDatasources[key][indexPath.row] boolValue]);
        [_tableView reloadData];
        
        //如果反选了某个全选分区中的某一项
        if(![_statusDatasources[key][indexPath.row] boolValue]){
            for(int i=0; i<_headerDatasources.count; ++i){
                if([_headerDatasources[i] isEqualToString:key]){
                    if([_allSectionsStatus[i] boolValue]){
                        _allSectionsStatus[i] = @(!([_allSectionsStatus[i] boolValue]));
                        [_tableView reloadData];
                    }
                    break;
                }
            }
        }else{      //如果选中了该分区中最后一个未选中的项
            int index = 0;  //在该分区中选中的索引
            for(int i=0; i<_headerDatasources.count; ++i){
                if([_headerDatasources[i] isEqualToString:key]){
                    index = i;
                    break;
                }
            }
            BOOL isLastUnSelected = YES;
            for(int i=0; i<_statusDatasources[key].count; ++i){
                if(![_statusDatasources[key][i] boolValue] && i!=index){
                    isLastUnSelected = NO;
                    break;
                }
            }
            if(isLastUnSelected){
                if(![_allSectionsStatus[index] boolValue]){
                    _allSectionsStatus[index] = @(!([_allSectionsStatus[index] boolValue]));
                    [_tableView reloadData];
                }
            }
        }
    };
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0f;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AreaTableHeaderView* view = [[AreaTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    view.title.text = _headerDatasources[section];
    
    if([_allSectionsStatus[section] boolValue]){
        [view.statusBtn setImage:[UIImage imageNamed:@"areaSelect1"] forState:UIControlStateNormal];
    }else{
        [view.statusBtn setImage:[UIImage imageNamed:@"areaSelect0"] forState:UIControlStateNormal];
    }
    
    if([_switches[section] boolValue]){
        [view.arrow setImage:[UIImage imageNamed:@"arrowDown"] forState:UIControlStateNormal];
    }else{
        [view.arrow setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    }
    
    __weak typeof (view) weakView = view;
    view.collapse = ^(void){
        _switches[section] = @(![_switches[section] boolValue]);
        
        if([_switches[section] boolValue]){
            [weakView.arrow setImage:[UIImage imageNamed:@"arrowDown"] forState:UIControlStateNormal];
        }else{
            [weakView.arrow setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
        }
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    };
    view.selectSection = ^(){
        _allSectionsStatus[section] = @(![_allSectionsStatus[section] boolValue]);
        NSString* key = _headerDatasources[section];
        [_statusDatasources[key] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([_allSectionsStatus[section] boolValue]){
                _statusDatasources[key][idx] = @(YES);
            }else{
                _statusDatasources[key][idx] = @(NO);
            }
            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
        }];
    };
    return view;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(![_switches[section] boolValue]){
        return 0;
    }
    return [[_datasources valueForKey:_headerDatasources[section]] count];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return _headerDatasources.count;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
