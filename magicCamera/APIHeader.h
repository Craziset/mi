
//
//  APIHeader.h
//  magicCamera
//
//  Created by 徐征 on 2018/1/9.
//  Copyright © 2018年 张展展. All rights reserved.
//

#ifndef APIHeader_h
#define APIHeader_h

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


//#define SongMainUrl @"http://diymi6.taichirain.com/api/v2/"

#define SongMainUrl @"http://www.nicway.cn/api/v2/"
//#define SongMainUrl @"http://lz-geli.xin/api/v2/"


#define API_ImageURL(x)[NSString stringWithFormat:@"http://mi6.wulinnet.com/images/%@",x]
#define API_UploadImageURL(x)[NSString stringWithFormat:@"http://mi6.wulinnet.com%@",x]

//登录
#define API_Login  [SongMainUrl stringByAppendingString:@"user/login"]
//找回密码
#define API_ForgetPasswd  [SongMainUrl stringByAppendingString:@"user/forgetPasswd"]

#define API_Captcha  [SongMainUrl stringByAppendingString:@"user/send-captcha"]

#define API_CheckCaptcha [SongMainUrl stringByAppendingString:@"user/check-captcha"]

//订单部分

#define API_OrderAll  [SongMainUrl stringByAppendingString:@"order/user-order-all"]
#define API_OrderCancle [SongMainUrl stringByAppendingString:@"order/order-cancel"]
//售后
#define API_OrderAftermark [SongMainUrl stringByAppendingString:@"order/user-order-aftermark"]

//获取所有模板
#define API_Producttemplates [SongMainUrl stringByAppendingString:@"product-temp/product-templates"]
//获取尺寸
#define API_Producttemplateizes [SongMainUrl stringByAppendingString:@"product-temp/product-template-sizes"]

//获取颜色
#define API_ProducTemplateColors [SongMainUrl stringByAppendingString:@"product-temp/product-template-colors"]


//待支付订单
#define API_OrderUnpay [SongMainUrl stringByAppendingString:@"order/user-order-unpay"]


//待收货列表
#define API_OrderUnsign [SongMainUrl stringByAppendingString:@"order/user-order-unsign"]

//待发货列表
#define API_OrderUnsend [SongMainUrl stringByAppendingString:@"order/user-order-unsend"]
//
//用户
//优惠券
#define API_Coupons [SongMainUrl stringByAppendingString:@"coupons/my-coupons"]
//立即购买使用的优惠券
#define API_BuyCoupons [SongMainUrl stringByAppendingString:@"coupons/buy-immediately-coupons"]
//添加购物车
#define API_AddShoppingCar [SongMainUrl stringByAppendingString:@"shopcar/add-shopping-car"]
//购物车列表
#define API_ShoppingCarList [SongMainUrl stringByAppendingString:@"shopcar/shop-car-list"]
//购物车选中
#define API_ShopCarSelect [SongMainUrl stringByAppendingString:@"shopcar/car-select"]
//购物车全选或取消
#define API_ShopCarCheckAll [SongMainUrl stringByAppendingString:@"shopcar/shop-car-check-all-or-cancel-all"]
//购物车结算页
#define API_ShopCarSubmit [SongMainUrl stringByAppendingString:@"shopcar/shop-car-submit"]
//从购物车生成订单
#define API_ShopCarOrder [SongMainUrl stringByAppendingString:@"order/create-order-by-shop-car"]
//从购物车删除
#define API_ShopCarDelete [SongMainUrl stringByAppendingString:@"shopcar/delete-shop-car"]

//结算
#define API_ShoppingCarSubmit [SongMainUrl stringByAppendingString:@"shopcar/shop-car-submit"]

//创建产品
#define API_CreateProduct [SongMainUrl stringByAppendingString:@"products/create-product"]

//上传图片
#define API_ImageUpload [SongMainUrl stringByAppendingString:@"img/save"]

//素材
#define API_GetSource [SongMainUrl stringByAppendingString:@"source-pic/get-source"]

/** 立即购买 */
//立即购买生成订单
#define API_BuyImmediately [SongMainUrl stringByAppendingString:@"order/create-order-by-buy-immediately"]
//店铺
#define API_Stores [SongMainUrl stringByAppendingString:@"stores"]

//个人信息
#define API_GetUserInfo [SongMainUrl stringByAppendingString:@"user/userinfo"]

//修改头像
#define API_ChangeHeaderView [SongMainUrl stringByAppendingString:@"user/modify-avatar"]

//修改昵称
#define API_ChangeNickName [SongMainUrl stringByAppendingString:@"user/modify-nickname"]

//修改性别
#define API_ChangeGender [SongMainUrl stringByAppendingString:@"user/modify-gender"]

//修改邮箱
#define API_ChangeEmail [SongMainUrl stringByAppendingString:@"user/modify-email"]

//修改区域
#define API_ChangeArea [SongMainUrl stringByAppendingString:@"user/modify-area"]

//修改个性签名
#define API_ChangeSign [SongMainUrl stringByAppendingString:@"user/modify-sign"]

//修改生日
#define API_ChangeBirthday [SongMainUrl stringByAppendingString:@"user/modify-birthday"]

//关于我们
#define API_AboutUS [SongMainUrl stringByAppendingString:@"other/about"]

//获取我的作品
#define API_GetMyWorkList [SongMainUrl stringByAppendingString:@"collection/list"]
//支付宝
#define API_AliPay [SongMainUrl stringByAppendingString:@"pay/alipay"]
//微信
#define API_WXPay [SongMainUrl stringByAppendingString:@"pay/wx-pay"]

//收货地址列表
#define API_AddressList [SongMainUrl stringByAppendingString:@"address/address-list"]
//国家区号列表
#define API_CountryIdList [SongMainUrl stringByAppendingString:@"user/country"]
//添加收货地址
#define API_AddAddress [SongMainUrl stringByAppendingString:@"address/add-address"]
//设置默认地址
#define API_SetDefaultAddress [SongMainUrl stringByAppendingString:@"address/set-default"]
//删除收货地址
#define API_DeleteAddress [SongMainUrl stringByAppendingString:@"address/delete-address"]
//修改收货地址
#define API_EditAddress [SongMainUrl stringByAppendingString:@"address/edit-address"]


//获取所有标签列表
#define API_getTagList [SongMainUrl stringByAppendingString:@"source-pic/get-tag-list"]

//根据标签获取素材列表
#define API_getSourcePicByTag [SongMainUrl stringByAppendingString:@"source-pic/get-source-pic-by-tag"]

//素材工具列表
#define API_MaterialsList [SongMainUrl stringByAppendingString:@"materials/list"]
//获取素材工具
#define API_MaterialsByTag [SongMainUrl stringByAppendingString:@"materials/get-material-by-tag"]

//获取商品列表
#define API_ProductsList [SongMainUrl stringByAppendingString:@"products/list"]

//获取商品基本信息
#define API_ProductsBasicInfo [SongMainUrl stringByAppendingString:@"product-temp/product-basic-info"]
//商品信息
#define API_ProductsTempInfo [SongMainUrl stringByAppendingString:@"product-temp/product-temp-info"]


//生成商品
#define API_ProductsCreation [SongMainUrl stringByAppendingString:@"products/common-user-creation"]
//发布产品
#define API_ProductsPublication [SongMainUrl stringByAppendingString:@"products/common-user-save-publication"]
//商品信息
#define API_ProductDetail [SongMainUrl stringByAppendingString:@"products/product-detail"]


//上传素材
#define API_CommonUpload [SongMainUrl stringByAppendingString:@"source-pic/common-upload"]

//系统素材
#define API_SystemSource [SongMainUrl stringByAppendingString:@"source-pic/get-system-source-pic"]
//我的素材
#define API_UserSource [SongMainUrl stringByAppendingString:@"source-pic/get-user-source-pic"]
//删除用户素材
#define API_DeleteUserSource [SongMainUrl stringByAppendingString:@"source-pic/delete-user-creative"]



#endif /* APIHeader_h */
