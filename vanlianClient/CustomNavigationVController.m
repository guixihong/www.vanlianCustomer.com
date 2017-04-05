//
//  CustomNavigationVController.m
//  Customer
//
//  Created by SU on 2017/1/12.
//  Copyright © 2017年 VKLJ_SU. All rights reserved.
//

#import "CustomNavigationVController.h"

@interface CustomNavigationVController ()

@end

@implementation CustomNavigationVController

- (id)initWithRootViewController:(UIViewController *)rootViewController{
    
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad{
    
    __weak CustomNavigationVController *weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        
        self.delegate = weakSelf;
    }
    
}

//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    
//    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] || animated == YES ){
//        
//        SLog(@"pushViewController---NO");
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//    
//    [super pushViewController:viewController animated:animated];
//    
//}
//
//- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated{
//    
//    if ( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] || animated == YES ){
//        
//        SLog(@"popToRootViewControllerAnimated---NO");
//
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//    
//    return  [super popToRootViewControllerAnimated:animated];
//    
//}
//
//- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    
//    if( [self respondsToSelector:@selector(interactivePopGestureRecognizer)] ){
//       
//        SLog(@"popToViewController---NO");
//
//        self.interactivePopGestureRecognizer.enabled = NO;
//    }
//    
//    return [super popToViewController:viewController animated:animated];
//}
#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animate {
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if ( gestureRecognizer ==self.interactivePopGestureRecognizer ) {
        
        if ( self.viewControllers.count < 2 || self.visibleViewController == [self.viewControllers objectAtIndex:0]){
            
            return NO;
        }
        
    } return YES; 
}

@end
