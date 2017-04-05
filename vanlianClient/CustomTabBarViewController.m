#import "CustomTabBarViewController.h"

@interface CustomTabBarViewController ()

@end

@implementation CustomTabBarViewController

-(UIViewController *)addViewControllerWithString:(NSString *)viewCon title:(NSString *)title andImage:(NSString *)image andSlectedImage:(NSString *)image2{
    
    Class viewController = NSClassFromString(viewCon);
    UIViewController *myViewCon = [[viewController alloc]init];
    myViewCon.title = title;
    UIImage * image1 = [UIImage imageNamed:image];
    UIImage * lImage = [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * image3 = [UIImage imageNamed:image2];
    UIImage * lImage3 = [image3 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myViewCon.tabBarItem.image = lImage;
    myViewCon.tabBarItem.selectedImage = lImage3;
    [myViewCon.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: COLOR(252, 107, 73, 1)} forState:UIControlStateSelected];
    [myViewCon.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: COLOR(74, 74, 74, 1)} forState:UIControlStateNormal];
    CustomNavigationVController *nav = [[CustomNavigationVController alloc]initWithRootViewController:myViewCon];
    nav.navigationBar.tintColor = [UIColor blackColor];
    nav.navigationBar.translucent = NO;
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.viewControllers];
    [array addObject:nav];
    self.viewControllers = array;
    return myViewCon;
    
}

-(CustomTabBarViewController *)createUI{
    
//    CustomTabBarViewController *tbvc = [[CustomTabBarViewController alloc]init];
    self.tabBar.tintColor = [UIColor blackColor];
    self.tabBar.translucent = NO;
    [self addViewControllerWithString:@"HomeController" title:@"首页" andImage:@"tab_Data_n"  andSlectedImage:@"tab_Data_s"];
    [self addViewControllerWithString:@"ProductCenterController" title:@"产品中心" andImage:@"tab_Data_n"  andSlectedImage:@"tab_Data_s"];
    [self addViewControllerWithString:@"MyFamilyController" title:@"我的家" andImage:@"tab_Data_n"  andSlectedImage:@"tab_Data_s"];
    [self addViewControllerWithString:@"DiscoveryController" title:@"发现" andImage:@"tab_Data_n"  andSlectedImage:@"tab_Data_s"];
    [self addViewControllerWithString:@"MyController" title:@"我的" andImage:@"tab_Data_n"  andSlectedImage:@"tab_Data_s"];
    //    tbvc.selectedIndex = 2;
    
    return  self;
}

/**
 Tabbar点击时候小动画
 */
//-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
//
//    NSInteger index = [self.tabBar.items indexOfObject:item];
//    if (self.selectedIndex != index) {
//        
//        [self animationWithIndex:index];
//    }
//}
//
//-(void)animationWithIndex:(NSInteger)index{
//
//    NSMutableArray *tabbarBtnArr = [NSMutableArray array];
//    for (UIView *tabbarBtn in self.tabBar.subviews) {
//        
//        if ([tabbarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
//            
//            [tabbarBtnArr addObject:tabbarBtn];
//        }
//    }
//    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    pulse.duration = 0.1;
//    pulse.repeatCount = 1;
//    pulse.autoreverses = YES;
//    pulse.fromValue = [NSNumber numberWithFloat:0.7];
//    pulse.toValue = [NSNumber numberWithFloat:1.3];
//    [[tabbarBtnArr[index] layer] addAnimation:pulse forKey:nil];
//    self.selectedIndex = index;
//}

@end
