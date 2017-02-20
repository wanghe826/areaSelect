# AreaSelect(地区选择)

这是一个关于地区选择列表的小Demo。功能不复杂，但是比较实用.该功能的实现当中唯一有点麻烦的问题就是关于地区的复选框的选中和反选状态的处理。


效果如下：



![image](https://github.com/wanghe826/areaSelect/blob/master/selectAreaPreview.gif)



使用:
AreaSelectViewController实图里面的数据源--->

1, _switches  //保存列表中每个分区是否处于展开状态的数组。存储的类型是NSNumber（YES 或者NO）。

2, _headerDatasources //保存列表所有的区域名，例如：华东，华南...    _headerDatasources.count应等于_switches.count。

3, _datasources //保存列表里面所有地区的名称，例如：湖北，湖南...  
    该字典的个数应等于 _headerDatasources.count等于_switches.count, 该字典的键对应_headerDatasources的元素。
    
4，_statusDatasources //所有地区（除了总区域）是否被选中的状态保存。

5，_allSectionsStatus;  //所有分区是否被选中的状态保存。
