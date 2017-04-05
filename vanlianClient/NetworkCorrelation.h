//
//  NetworkCorrelation.h
//  Customer
//
//  Created by SU on 2016/11/19.
//  Copyright © 2016年 VKLJ_SU. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络请求类型
 */
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    /**
     *  get请求
     */
    HttpRequestTypeGet = 0,
    /**
     *  post请求
     */
    HttpRequestTypePost
};

typedef void (^SuccessBlock)(id responseObject,BOOL isExistData);
typedef void (^FailureBlock)(NSError *error);

@interface NetworkCorrelation : NSObject

@property (nonatomic,strong) MBProgressHUD *hud;

/**
 *  发送网络请求
 *
 *  @param URLString   请求的网址
 *  @param parameters  请求的参数
 *  @param type        请求的类型
 *  @param  refreshState 是否刷新
 *  @param  success 请求成功回调
 *  @param  failure 请求失败回调
 
 */
-(void)requestWithURLString:(NSString *)URLString
                  parameters:(id)parameters
                        type:(HttpRequestType)type
                refreshState:(BOOL)refreshState
               hudSuperView:(UIViewController *)hViewController
                     success:(SuccessBlock)success
                     failure:(FailureBlock)failure;

-(void)startloadanimation:(UIViewController *)hViewController;

-(void)finshloadanimation;

-(BOOL)isMobile:(NSString *)mobileNumber;

@property(nonatomic,copy)NSString *checkVersion;
@end
