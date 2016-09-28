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
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *say;
@property(nonatomic,copy)NSString *avatar;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *enmail;
@property(nonatomic,assign)int sex;
@property(nonatomic,assign)int qqBinding;
@property(nonatomic,assign)int emailBinding;
@property(nonatomic,assign)int weiboBinding;
@property(nonatomic,assign)int weixinBinding;
@property(nonatomic,assign)int followersCount;
@property(nonatomic,assign)int followingCount;
@property(nonatomic,copy)NSString *registerTime;
@property(nonatomic,copy)NSString *lastLoginTime;


@end


/* 
 "result": {
 "token": "xxxx.xxxxxxx.xxxxxxxx",
 "id": 4,
 "nickname": "佚名",
 "say": null,
 "avatar": "http://www.english.com/uploads/user/avatar.jpg",
 "mobile": null,
 "email": null,
 "sex": 0,
 "qqBinding": 0,
 "weixinBinding": 0,
 "weiboBinding": 0,
 "emailBinding": 0,
 "mobileBinding": 0,
 "followersCount": 32,
 "followingCount": 2,
 "registerTime": "1471685857",
 "lastLoginTime": "1471685891"
 }
*/
