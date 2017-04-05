#import <UIKit/UIKit.h>

@interface CustomTabBarViewController : UITabBarController

-(UIViewController *)addViewControllerWithString:(NSString *)viewCon title:(NSString *)title andImage:(NSString *)image andSlectedImage:(NSString *)image2;
-(CustomTabBarViewController *)createUI;

@end

