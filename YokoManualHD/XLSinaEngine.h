//
//  XLSinaEngine.h
//  CTCouponProject
//
//  Created by xie liang on 7/17/12.
//  Copyright (c) 2012 pretang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLSinaAuthorizeController.h"
#import "NSObject+SBJson.h"
#import "ASIFormDataRequest.h"

#define SINA_APP_KEY @"4192660145"
#define SINA_APP_SECRET @"093e76b90d812276961679f43ab35423"
#define SINA_REDIRECT_URI @"http://champion.yokohama.com.cn/site/getkey"
#define SINA_AUTHORIZE_URL @"https://api.weibo.com/oauth2/authorize"
#define SINA_ACCESS_TOKEN_URL @"https://api.weibo.com/oauth2/access_token"

@protocol XLSinaEngineDelegate;

@interface XLSinaEngine : NSObject<XLSinaAuthorizeDelegate>
{
    NSString *_uid;
    NSString *_access_token;
    double _expires;
    
    id<XLSinaEngineDelegate> _delegate;
    
    UIViewController *_rootViewController;
}

@property (nonatomic,retain,readonly) NSString *uid;
@property (nonatomic,retain,readonly) NSString *access_token;
@property (nonatomic,assign,readonly) double expires;
@property (nonatomic,assign) id<XLSinaEngineDelegate> delegate;
@property (nonatomic,assign) UIViewController *rootViewController;

- (void)saveSinaInfo:(NSDictionary *)info;
- (BOOL)isLogin;
- (void)loginSina;
- (void)logoutSina;

#pragma mark - sina api
- (void)sendStatus:(NSString *)status;
- (void)sendStatus:(NSString *)status withImage:(UIImage *)image longitude:(float)longitude latitude:(float)latitude;

@end

@protocol XLSinaEngineDelegate <NSObject>

- (void)didLoginSina;
- (void)didFialdLoginSina;
- (void)didFinishShareToSina;
- (void)didFaildShareToSina;

@end
