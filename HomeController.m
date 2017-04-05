//
//  HomeController.m
//  vanlianClient
//
//  Created by SU on 2017/4/5.
//  Copyright © 2017年 VKLJ_SU. All rights reserved.
//

#import "HomeController.h"

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    NetworkCorrelation *nvc = [[NetworkCorrelation alloc]init];
    [nvc requestWithURLString:@"http://10.30.32.79/spCustomer/checkCustomerByPhone" parameters:@{@"phone":@"1352024400"} type:HttpRequestTypePost complicate:^(id object, BOOL success) {
        
        NSLog(@"%@",object);
        
    } refreshState:NO noDataState:YES noDataView:self.view sController:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
