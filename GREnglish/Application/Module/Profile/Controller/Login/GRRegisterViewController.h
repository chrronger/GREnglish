//
//  GRRegisterViewController.h
//  GREnglish
//
//  Created by sen on 2016/9/27.
//  Copyright © 2016年 sen. All rights reserved.
//

#import "GRBaseLoginViewController.h"

@protocol GRRegisterViewControllerDelegate <NSObject>

- (void)registerSuccessWithUsername:(NSString *)username psw:(NSString *)psw;

@end

@interface GRRegisterViewController : GRBaseLoginViewController

@property(nonatomic,assign)id <GRRegisterViewControllerDelegate>delegate;

@end
