//
//  ZZHeader.h
//  magicCamera
//
//  Created by 张展展 on 2017/9/22.
//  Copyright © 2017年 张展展. All rights reserved.
//

#ifndef ZZHeader_h
#define ZZHeader_h

//屏幕的大小
#define ViewH [UIScreen mainScreen].bounds.size.height
#define ViewW [UIScreen mainScreen].bounds.size.width


#define SCR_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCR_HEIGHT [UIScreen mainScreen].bounds.size.height

#define kNum 20

#define ISLOGIN @"ISLOGIN"
#define USER_ID [[ZZUserManager shareManager] userManager].user_id

#define WeChatAppID  @"wx491a67d951c45c68"
#define WeChatAppSecret  @"07c18abade43c7811c28ed1e1d304ca6"

//接口连接
#define SENDCAPTCHA @"http://diy.cnmi6.com/api/user/send-captcha"
#define LOGAINPARTY @"http://diy.cnmi6.com/api/user/send-captcha"

#define SongMainUrl @"http://mi6.wulinnet.com/"
#define SongMainSecUrl @"http://diy.cnmi6.com/"

#define API_ImageURL(x)[NSString stringWithFormat:@"http://mi6.wulinnet.com/images/%@",x]
#define API_UploadImageURL(x)[NSString stringWithFormat:@"http://mi6.wulinnet.com%@",x]

#define loginurl   @"api/user/login"

#define API_Login  [SongMainSecUrl stringByAppendingString:@"/api/user/login"]
#define API_Captcha  [SongMainSecUrl stringByAppendingString:@"/api/user/send-captcha"]

//订单部分

#define API_OrderAll  [SongMainSecUrl stringByAppendingString:@"/api/order/user-order-all"]
#define API_OrderCancle [SongMainSecUrl stringByAppendingString:@"api/order/order-cancel"]

//用户
//优惠券
#define API_Coupons [SongMainUrl stringByAppendingString:@"api/coupons/my-coupons"]
//立即购买使用的优惠券
#define API_BuyCoupons [SongMainUrl stringByAppendingString:@"api/coupons/buy-immediately-coupons"]
//添加购物车
#define API_AddShoppingCar [SongMainUrl stringByAppendingString:@"api/shopcar/add-shopping-car"]
//购物车列表
#define API_ShoppingCarList [SongMainSecUrl stringByAppendingString:@"api/shopcar/shop-car-list"]
//结算
#define API_ShoppingCarSubmit [SongMainUrl stringByAppendingString:@"api/shopcar/shop-car-submit"]

//创建产品
#define API_CreateProduct [SongMainUrl stringByAppendingString:@"api/products/create-product"]

//上传图片
#define API_ImageUpload [SongMainUrl stringByAppendingString:@"api/img/upload"]

//素材
#define API_GetSource [SongMainSecUrl stringByAppendingString:@"api/source-pic/get-source"]

/** 立即购买 */
//立即购买生成订单
#define API_BuyImmediately [SongMainUrl stringByAppendingString:@"api/order/create-order-by-buy-immediately"]
//店铺
#define API_Stores [SongMainUrl stringByAppendingString:@"api/stores"]

//个人信息
#define API_GetUserInfo [SongMainUrl stringByAppendingString:@"/api/user/userinfo"]

//修改头像
#define API_ChangeHeaderView [SongMainUrl stringByAppendingString:@"/api/user/modify-avatar"]

//修改昵称
#define API_ChangeNickName [SongMainUrl stringByAppendingString:@"/api/user/modify-nickname"]

//修改性别
#define API_ChangeGender [SongMainUrl stringByAppendingString:@"/api/user/modify-gender"]

//修改邮箱
#define API_ChangeEmail [SongMainUrl stringByAppendingString:@"/api/user/modify-email"]

//修改区域
#define API_ChangeArea [SongMainUrl stringByAppendingString:@"/api/user/modify-area"]

//修改个性签名
#define API_ChangeSign [SongMainUrl stringByAppendingString:@"/api/user/modify-sign"]

//修改生日
#define API_ChangeBirthday [SongMainUrl stringByAppendingString:@"/api/user/modify-birthday"]

//关于我们
#define API_AboutUS [SongMainUrl stringByAppendingString:@"/api/other/about"]

//获取我的作品
#define API_GetMyWorkList [SongMainUrl stringByAppendingString:@"/api/collection/list"]




#endif /* ZZHeader_h */
