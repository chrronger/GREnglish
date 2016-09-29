//
//  GRAccountModel.m
//  GREnglish
//
//  Created by sen on 2016/9/27.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRAccountModel.h"

@interface GRAccountModel()<NSCoding>

@property(nonatomic,strong)GRAccountModel *accountModel;

@end

@implementation GRAccountModel

//注册
+ (void)registerAccountWithType:(NSString *)type username:(NSString *)username psw:(NSString *)psw resultBlock:(void (^)(NSDictionary *data, NSError *error))resultBlock
{
    NSDictionary *parames = @{@"type":type, @"identifier":username,@"credential":psw};
    [FGNetworking requsetWithPath:REGISTERURL params:parames method:Post handleBlcok:^(id response, NSError *error) {
         NSDictionary *dic = (NSDictionary *)response;
        GRLog(@"--------------------注册-----------------%@",dic);
        if ([dic[@"status"] isEqualToString:@"success"]) {
            resultBlock(dic,nil);
        }else{
            resultBlock(dic,error);
        }
        
    }];
    
}

//普通账号登录
+ (void)loginAccountWithType:(NSString *)type username:(NSString *)username psw:(NSString *)psw resultBlock:(void (^)(NSDictionary *data, NSError *error))resultBlock;
{
    NSDictionary *parames = @{@"type":type, @"identifier":username,@"credential":psw};
    [FGNetworking requsetWithPath:LOGINURL params:parames method:Post handleBlcok:^(id response, NSError *error) {
        NSDictionary *dic = (NSDictionary *)response;
        GRLog(@"--------------------用户登录-----------------%@",dic);
        if ([dic[@"status"] isEqualToString:@"success"]) {
            GRAccountModel *model = [GRAccountModel mj_objectWithKeyValues:dic[@"result"]];
            [model saveUserInfo];
            resultBlock(dic,nil);
  
        }else{
            resultBlock(dic,error);
        }
    }];
}

//邮箱找回密码
+ (void)findPswWithUsername:(NSString *)username email:(NSString *)email resultBlock:(void (^)(NSDictionary *data, NSError *error))resultBlock
{
    //绑定的邮箱
    NSDictionary *parames = @{@"identifier":username,@"email":email};
    [FGNetworking requsetWithPath:FINDPSW params:parames method:Post handleBlcok:^(id response, NSError *error) {
        NSDictionary *dic = (NSDictionary *)response;
        GRLog(@"--------------------邮箱找回密码-----------------%@",dic);
        if ([dic[@"status"] isEqualToString:@"success"]) {
            
            resultBlock(dic,nil);
            
        }else{
            resultBlock(dic,error);
        }
    }];

}

+ (instancetype)shareAccount
{
    static GRAccountModel *_account;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _account = [[self alloc]init];
        
        [self mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"Id":@"id"};
        }];
    });
    return _account;
}

//
- (GRAccountModel *)unarchiverAccount
{
    if (self.accountModel == nil) {
        self.accountModel = [NSKeyedUnarchiver unarchiveObjectWithFile:[self accountPath]];
        return self.accountModel;
    }else{
        return self.accountModel;
    }
    
}

- (BOOL)isLogin
{
    //func isLogin(controller: UIViewController) -> Bool {
    
//    if JFAccountModel.isLogin() {
//        return true
//    } else {
//        let loginVc = JFNavigationController(rootViewController: JFLoginViewController(nibName: "JFLoginViewController", bundle: nil))
//        controller.presentViewController(loginVc, animated: true, completion: {
//            print("弹出登录界面")
//        })
//        return false
//    }


    return [self unarchiverAccount] != nil;
}

- (void)logout
{
    
}
//
- (void)saveUserInfo
{
    self.accountModel = self;
    [self saveAccountInfo];
}


//归档用户数据
- (void)saveAccountInfo
{
    [NSKeyedArchiver archiveRootObject:self toFile:[self accountPath]];
}
// 归档账号的路径
- (NSString *)accountPath
{
    return  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingString:@"account.plist"];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.token forKey: @"token_key"];
    [aCoder encodeObject:self.expiryTime forKey: @"expiry_time_key"];
    [aCoder encodeInt:self.Id forKey: @"id_key"];
    [aCoder encodeObject:self.nickname forKey: @"nickname_key"];
    [aCoder encodeObject:self.say forKey: @"say_key"];
    [aCoder encodeObject:self.avatar forKey: @"avatar_key"];
    [aCoder encodeObject:self.mobile forKey: @"mobile_key"];
    [aCoder encodeObject:self.email forKey: @"email_key"];
    [aCoder encodeInt:self.sex forKey: @"sex_key"];
    [aCoder encodeInt:self.adDsabled forKey: @"ad_dsabled_key"];
    [aCoder encodeInt:self.qqBinding forKey: @"qq_binding_key"];
    [aCoder encodeInt:self.weixinBinding forKey: @"weixin_binding_key"];
    [aCoder encodeInt:self.weiboBinding forKey: @"weibo_binding_key"];
    [aCoder encodeInt:self.emailBinding forKey: @"email_binding_key"];
    [aCoder encodeInt:self.mobileBinding forKey: @"mobile_binding_key"];
    [aCoder encodeInt:self.followersCount forKey: @"followers_count_key"];
    [aCoder encodeInt:self.followingCount forKey: @"following_count_key"];
    [aCoder encodeObject:self.registerTime forKey: @"register_time_key"];
    [aCoder encodeObject:self.lastLoginTime forKey: @"last_login_time"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.token = [aDecoder decodeObjectForKey:@"token_key"];
        self.expiryTime = [aDecoder decodeObjectForKey:@"expiry_time_key"];
        self.Id = [aDecoder decodeIntForKey:@"id_key"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname_key"];
        self.say = [aDecoder decodeObjectForKey:@"say_key"];
        self.avatar = [aDecoder decodeObjectForKey:@"avatar_key"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile_key"];
        self.email = [aDecoder decodeObjectForKey:@"email_key"];
        self.sex =[aDecoder decodeIntForKey:@"sex_key"];
        self.adDsabled = [aDecoder decodeIntForKey:@"ad_dsabled_key"];
        self.qqBinding = [aDecoder decodeIntForKey:@"qq_binding_key"];
        self.weixinBinding = [aDecoder decodeIntForKey:@"weixin_binding_key"];
        self.weiboBinding = [aDecoder decodeIntForKey:@"weibo_binding_key"];
        self.emailBinding = [aDecoder decodeIntForKey:@"email_binding_key"];
        self.mobileBinding = [aDecoder decodeIntForKey:@"mobile_binding_key"];
        self.followersCount = [aDecoder decodeIntForKey:@"followers_count_key"];
        self.followingCount = [aDecoder decodeIntForKey:@"following_count_key"];
        self.registerTime = [aDecoder decodeObjectForKey:@"register_time_key"];
        self.lastLoginTime = [aDecoder decodeObjectForKey:@"last_login_time"];
        
    }
    return self;
}

@end
