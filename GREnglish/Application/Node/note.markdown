#Node

一.NSUserDefualt 方法封装成宏
1.readFromPlist(key) 从plist中读取值
2.writeToPlist(dic)  将字典写入plist
3.deleteInPlish(key) 删除plist中的值

二.SDAutoLayout使用注意事项
1.添加子视图的顺序要和设置约束的顺序一致
2.模型数据要在传给cell的设置Model方法之前修改,因为[tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[GRTweetListCell class] contentViewWidth:[self cellContentViewWith]]方法是基于给的的模型数据类计算的cell高度.

