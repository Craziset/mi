//
//  SuperOrderModel.h
//  magicCamera
//
//  Created by 宋建 on 2017/11/25.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SuperOrderModel : NSObject
@property(nonatomic,copy)NSString *ImagesStr;//产品图像
@property(nonatomic,copy)NSString *ProductNameStr;//产品的名字
@property(nonatomic,copy)NSString *ProductPriceStr;//产品价格
@property(nonatomic,copy)NSString *ProductStyleStr;//
@property(nonatomic,copy)NSString *ProductNumberStr;//产品的数量
@property(nonatomic,copy)NSString *ProductColour_nameStr;//产品颜色
@property(nonatomic,copy)NSString *ProductSize_nameStr;// 产品寸尺

//订单数据的主体数据属性
@property(nonatomic,copy)NSString *OrderStateStr; //订单的状态
@property(nonatomic,copy)NSString *Ordertotal_priceStr; //订单的价钱
@property(nonatomic,copy)NSString *Ordergood_total_quantityStr; //订单总数量
@property(nonatomic,copy)NSString *Orderorder_idStr; //订单编号






@end
