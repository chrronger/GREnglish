//
//  GRUrl.h
//  GREnglish
//
//  Created by Waki on 16/9/27.
//  Copyright © 2016年 sen. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 基URL
#define BASE_URL @"http://english.6ag.cn/"

/// 发送手机验证码
#define SEND_CODE @"api/auth/seedCode.api"

/// 注册
#define REGISTER @"api/auth/register.api"

/// 登录
#define LOGIN @"api/auth/login.api"

/// 修改用户密码
#define MODIFY_USER_PASSWORD @"api/auth/modifyUserPassword.api"

/// 重置密码邮件
#define RETRIEVE_PASSWORD_EMAIL @"api/auth/retrievePasswordWithSendEmail.api"

/// 获取所有分类信息
#define GET_ALL_CATEGORIES @"api/getAllCategories.api"

/// 搜索视频信息列表
#define SEARCH_VIDEO_INFO_LIST @"api/searchVideoInfoList.api"

/// 根据分类id查询视频信息列表
#define GET_VIDEO_INFOS_LIST @"api/getVideoInfosList.api"

/// 获取视频信息
#define GET_VIDEO_INFO_DETAIL @"api/getVideoInfoDetail.api"

/// 根据视频信息id查询视频播放列表
#define GET_VIDEO_LIST @"api/getVideoList.api"

/// 解析m3u8地址
#define PARSE_YOUKU_VIDEO @"api/playVideo.api"

/// 获取单个视频的视频分段列表地址
#define GET_VIDEO_DOWNLOAD_LIST @"api/getVideoDownloadList.api"

/// 获取动弹列表
#define GET_TWEETS_LIST @"api/getTweetsList.api"

/// 获取动弹详情
#define GET_TWEETS_DETAIL @"api/getTweetsDetail.api"

/// 发布动弹
#define POST_TWEETS @"api/postTweets.api"

/// 获取评论列表
#define GET_COMMENT_LIST @"api/getCommentList.api"

/// 发布评论
#define POST_COMMENT @"api/postComment.api"

/// 获取语法手册
#define GET_GRAMMAR_MANUAL @"api/getManual.api"

/// 获取朋友关系列表 粉丝、关注
#define GET_FRIEND_LIST @"api/getFriendList.api"

/// 添加或取消赞
#define ADD_OR_CANCEL_LIKE_RECORD @"api/addOrCancelLikeRecord.api"

/// 获取收藏列表
#define GET_COLLECTION_LIST @"api/getCollectionList.api"

/// 添加或删除视频收藏
#define ADD_OR_CANCEL_COLLECTION @"api/addOrCancelCollectVideoInfo.api"

/// 上传用户头像
#define UPLOAD_USER_AVATAR @"api/uploadUserAvatar.api"

/// 获取自己的用户信息
#define GET_SELF_USER_INFOMATION @"api/getSelfUserInfomation.api"

/// 获取他人的用户信息
#define GET_OTHER_USER_INFOMATION @"api/getOtherUserInfomation.api"

/// 更新用户信息
#define UPDATE_USER_INFOMATION @"api/updateUserInfomation.api"

/// 购买去除广告接口
#define BUY_DISLODGE_AD @"api/buyDislodgeDdvertisement.api"

/// 添加或删除朋友
#define ADD_OR_CANCEL_FRIEND @"api/addOrCancelFriend.api"

/// 提交反馈信息
#define POST_FEEDBACK @"api/postFeedback.api"

/// 获取播放节点
#define GET_PALY_NODE @"api/getPlayNode.api"

/// 获取消息列表
#define GET_MESSAGE_LIST @"api/getMessageList.api"

/// 获取未读消息数量
#define GET_UNLOOKED_MESSAGE_COUNT @"api/getUnlookedMessageCount.api"

/// 清理未读消息数量
#define CLEAR_UNLOOKED_MESSAGE @"api/clearUnlookedMessage.api"
