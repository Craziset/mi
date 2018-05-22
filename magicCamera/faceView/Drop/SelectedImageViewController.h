//
//  SelectedImageViewController.h
//  FaceImage
//
//  Created by 徐征 on 2017/10/28.
//  Copyright © 2017年 徐征. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedImageViewController : UIViewController
{
    
    UIImageView *dotBlueArea1,*dotBlueArea2,*dotBlueArea3,*dotBlueArea4,*dotBlueArea5,*dotBlueArea6,*dotBlueArea7,*dotBlueArea8,*dotBlueArea9;
    BOOL isDotBlueAreatouch1,isDotBlueAreatouch2,isDotBlueAreatouch3,isDotBlueAreatouch4,isDotBlueAreatouch5,isDotBlueAreatouch6,isDotBlueAreatouch7,isDotBlueAreatouch8,isDotBlueAreatouch9;
    
    BOOL isSelecteObjectRemove,isSelectObjectMove,isObjectSelect,isTouchDotArea,isGroup;
    CGPoint touch1,touch2;
    int tagcntr;
}
@end
