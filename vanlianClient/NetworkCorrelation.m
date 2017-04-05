//
//  NetworkCorrelation.m
//  Customer
//
//  Created by SU on 2016/11/19.
//  Copyright © 2016年 VKLJ_SU. All rights reserved.
//

#import "NetworkCorrelation.h"

@implementation NetworkCorrelation

-(void)requestWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                       type:(HttpRequestType)type
               refreshState:(BOOL)refreshState
               hudSuperView:(UIViewController *)hViewController
                    success:(SuccessBlock)success
                    failure:(FailureBlock)failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//使用这个将得到的是NSData
    
    /**
     *  请求队列的最大并发数
     */
    manager.operationQueue.maxConcurrentOperationCount = 5;
    /**
     *  请求超时的时间
     */
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 5.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];

    /**
     *  可以接受的类型
     :@"text/html",@"application/json",@"application/x-www-form-urlencoded",@"charset=utf-8"
     */
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",@"application/x-www-form-urlencoded",@"charset=utf-8",nil];
    /**
     *  请求头设置------------test!!!!!!!!!!!!!!!!!!
     */
//    [manager.requestSerializer setValue:@"4b5527ead123e9afc8f37d8f214d168d"forHTTPHeaderField:@"token"];
    
    if (refreshState) {
        
        [self startloadanimation:hViewController];
    }
    
    switch (type) {
            
        case HttpRequestTypeGet:
        {
            [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                
                if (refreshState) {
                    
                    [self finshloadanimation];
                }
                
                NSDictionary *dic = [self parseJSONDataToNSDictionary:responseObject];
                if (_checkVersion) {
                    success(dic,YES);
                    return;
                }
                //??
                if(responseObject){
                    
                    success(@"ok",YES);
                    
                }
                if ([dic[@"returncode"] isEqualToString:@"0"]) {//成功
                    
                    success(dic[@"result"],YES);
                    
                }else if ([dic[@"returncode"] isEqualToString:@"1"]){//失败
                    
                    success(dic,NO);
                    
                }else if ([dic[@"returncode"] isEqualToString:@"-2"]){//未登录
                    //------------test!!!!!!!!!!!!!!!!!!
                    //                    LoginController *loginView = [[LoginController alloc]init];
                    //                    [hViewController presentViewController:loginView animated:YES completion:nil];
                    //------------test!!!!!!!!!!!!!!!!!!
                    success(dic,NO);
                }
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                
                if (refreshState) {
                    
                    [self finshloadanimation];
                }
                
                failure(error);
                
            }];
            
        }
            break;
            
        case HttpRequestTypePost:
        {
            [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                //------------test!!!!!!!!!!!!!!!!!!
                NSDictionary *dic = [self parseJSONDataToNSDictionary:responseObject];
                success(dic,YES);
                //------------test!!!!!!!!!!!!!!!!!!
                
                
                
                //            if (refreshState) {
                //
                //                [self finshloadanimation];
                //            }
                //
                //            NSDictionary *dic = [self parseJSONDataToNSDictionary:responseObject];
                //            if (_checkVersion) {
                //                success(dic,YES);
                //                return;
                //            }
                //            if ([dic[@"returncode"] isEqualToString:@"0"]) {//成功
                //
                //                success(dic[@"result"],YES);
                //
                //            }else if ([dic[@"returncode"] isEqualToString:@"1"]){//失败
                //
                //                success(dic,NO);
                //
                //            }else if ([dic[@"returncode"] isEqualToString:@"-2"]){//未登录
                //
                //                success(dic,NO);
                //            }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (refreshState) {
                    
                    [self finshloadanimation];
                }
                
                failure(error);
            }];
            
        }
            break;
    }
}

-(NSDictionary *)parseJSONDataToNSDictionary:(NSData *)jsonData {
    
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    return responseJSON;
}

-(void)startloadanimation:(UIViewController *)hViewController{
    
    _hud = [[MBProgressHUD alloc]init];
    _hud = [MBProgressHUD showHUDAddedTo:hViewController.view animated:YES];
    _hud.mode = MBProgressHUDModeIndeterminate;
    _hud.label.text = @"拼命加载中";
    [hViewController.view addSubview:_hud];
}

-(void)finshloadanimation{
    
    [_hud hideAnimated:YES];
}

/**
 *  手机号码验证
 *
 *  @param mobileNumber 传入的手机号码
 *
 *  @return 格式正确返回true  错误 返回fals
 */
-(BOOL)isMobile:(NSString *)mobileNumber{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181(增加)
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumber]
         || [regextestcm evaluateWithObject:mobileNumber]
         || [regextestct evaluateWithObject:mobileNumber]
         || [regextestcu evaluateWithObject:mobileNumber])) {
        
        return YES;
    }
    
    return NO;
}


@end
