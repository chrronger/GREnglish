//
//  GRAccountModel.h
//  GREnglish
//
//  Created by sen on 2016/9/27.
//  Copyright © 2016年 sen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRAccountModel : NSObject

@property(nonatomic,copy)NSString *token;
@property(nonatomic,assign)int id;
//是否显示广告 0显示 1不显示
@property(nonatomic,assign)int adDsabled;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *say;
@property(nonatomic,copy)NSString *avatar;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *email;
@property(nonatomic,assign)int sex;
@property(nonatomic,assign)int qqBinding;
@property(nonatomic,assign)int emailBinding;
@property(nonatomic,assign)int weiboBinding;
@property(nonatomic,assign)int weixinBinding;
@property(nonatomic,assign)int mobileBinding;
@property(nonatomic,assign)int followersCount;
@property(nonatomic,assign)int followingCount;
@property(nonatomic,copy)NSString *registerTime;
@property(nonatomic,copy)NSString *lastLoginTime;

@property(nonatomic,copy)NSString *expiryTime;


//解档账号信息
- (void)archiverAccount;

//当前是否登录
- (BOOL)isLogin;


//注册
+ (void)registerAccountWithType:(NSString *)type username:(NSString *)username psw:(NSString *)psw resultBlock:(void (^)(NSDictionary *data, NSError *error))resultBlock;
//普通账号登录
+ (void)loginAccountWithType:(NSString *)type username:(NSString *)username psw:(NSString *)psw resultBlock:(void (^)(NSDictionary *data, NSError *error))resultBlock;
//邮箱找回密码
+ (void)findPswWithUsername:(NSString *)username email:(NSString *)email resultBlock:(void (^)(NSDictionary *data, NSError *error))resultBlock;

@end


/* 
 adDsabled = 0;
 avatar = "http://english.6ag.cn/uploads/user/default/avatar.jpg";
 email = "<null>";
 emailBinding = 0;
 expiryTime = 1477645054;
 followersCount = 0;
 followingCount = 0;
 id = 10327;
 lastLoginTime = 1475053054;
 mobile = "<null>";
 mobileBinding = 0;
 nickname = "\U4f5a\U540d";
 qqBinding = 0;
 registerTime = 1475053045;
 say = "<null>";
 sex = 0;
 token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEwMzI3LCJpc3MiOiJodHRwOlwvXC9lbmdsaXNoLjZhZy5jblwvYXBpXC9hdXRoXC9sb2dpbi5hcGkiLCJpYXQiOjE0NzUwNTMwNTQsImV4cCI6MTQ3NzY0NTA1NCwibmJmIjoxNDc1MDUzMDU0LCJqdGkiOiI3NjBjMzU0NjhmNTU1NTZlZGJlMzY0MGVhODU1NTU0OSJ9.3x5ADBrLxb87WdrkpstcyUitGQ9Jlc9Kfs_7qLGLAsE";
 weiboBinding = 0;
 weixinBinding = 0;
 };
*/
