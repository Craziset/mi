

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonTool : NSObject

+(void)showAlert:(NSString *)message from:(UIViewController *)viewController;

//默认登录
//+(void)userLogin:(NSString *)phone password:(NSString *)password;
+(void)alertViewController:(NSString *)title message:(NSString *)message from:(UIViewController *)viewController withAMessage:(NSString *)amessage and:(UIView *)view withtag:(NSString *)tag;

+(void)alertViewController:(NSString *)title message:(NSString *)message from:(UIViewController *)viewController;

+(void)alertViewnet:(NSString *)title message:(NSString *)message from:(UIViewController *)viewController;


+(void)alertViewControll:(UIViewController *)viewCone to:(UIViewController *)viewControllertwo;

@end
