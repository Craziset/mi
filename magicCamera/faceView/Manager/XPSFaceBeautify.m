//
//  XPSFaceBeautify.m
//  XPSFaceBeautify
//
//  Created by 徐征 on 2017/11/2.
//  Copyright © 2017年 徐征. All rights reserved.
//

#import "XPSFaceBeautify.h"

@implementation XPSFaceBeautify


static id facebeautitf = nil;
+ (instancetype)shareFace {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        facebeautitf = [[XPSFaceBeautify alloc]init];
    });
    return facebeautitf;
}

///边缘淡化模糊
+ (UIImage *)applyGaussianSelectiveBlur:(UIImage *)image {
    return [[XPSFaceBeautify shareFace]applyGaussianSelectiveBlur:image];
}

- (UIImage *)applyGaussianSelectiveBlur:(UIImage *)image {
    GPUImageGaussianSelectiveBlurFilter *filter = [[GPUImageGaussianSelectiveBlurFilter alloc] init];
    
    //15
    filter.blurRadiusInPixels = 7;
    //0.6
    filter.excludeBlurSize = 0.33;
    //0.48
    filter.excludeCircleRadius = 0.45;
    
    [filter forceProcessingAtSize:image.size];
    
    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:image];
    
    [pic addTarget:filter];
    
    [pic processImage];
    
    [filter useNextFrameForImageCapture];
    return [filter imageFromCurrentFramebuffer];
}

+ (UIImage *)whiteningWithImage:(UIImage *)image {
    return [[XPSFaceBeautify shareFace]whiteningWithImage:image];
}
//美白
- (UIImage *)whiteningWithImage:(UIImage *)image {
    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:image];
    // 美白滤镜
    GPUImageBrightnessFilter *filter1 = [[GPUImageBrightnessFilter alloc] init];
    
    //设置美白参数
    filter1.brightness = 0.08;
    
    [filter1 forceProcessingAtSize:image.size];
    
    [pic addTarget:filter1];
    
    [pic processImage];
    
    [filter1 useNextFrameForImageCapture];
    image = [filter1 imageFromCurrentFramebuffer];
    
    return image;
}
//磨皮
- (UIImage *)exfoliatingWithImage:(UIImage *)image {
    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:image];
    CGFloat level = 18;
    //磨皮滤镜
    GPUImageBilateralFilter *filter = [[GPUImageBilateralFilter alloc] init];
    
    //设置磨皮参数
    [filter setDistanceNormalizationFactor:level];
    
    [filter forceProcessingAtSize:image.size];
    
    [pic addTarget:filter];
    
    [pic processImage];
    
    [filter useNextFrameForImageCapture];
    
    image = [filter imageFromCurrentFramebuffer];
    return image;
}


//素描
+ (UIImage *)applySketchFilter:(UIImage *)image {
    return [[XPSFaceBeautify shareFace]applySketchFilter:image];
}
- (UIImage *)applySketchFilter:(UIImage *)image
{
    GPUImageToonFilter *filter = [[GPUImageToonFilter alloc]init];
    //    GPUImageSketchFilter *filter = [[GPUImageSketchFilter alloc] init];
    /*过滤强度属性影响滤波器的动态范围。高值可以使边缘更加明显,但会导致饱和。默认为1.0。*/
    //    filter.edgeStrength = .6;
    filter.threshold = 0.5;
    filter.quantizationLevels = 10;
    [filter forceProcessingAtSize:image.size];
    GPUImagePicture *pic = [[GPUImagePicture alloc] initWithImage:image];
    [pic addTarget:filter];
    [pic processImage];
    [filter useNextFrameForImageCapture];
    
    return [filter imageFromCurrentFramebuffer];
}


+ (UIImage *)cuttingBackgroundImage:(UIImage *)image withInfo:(NSArray *)array {
    return [[XPSFaceBeautify shareFace]cuttingBackgroundImage:image withInfo:array];
}
- (UIImage *)cuttingBackgroundImage:(UIImage *)image withInfo:(NSArray *)array{
    
    NSArray *pointArray = @[@"left_eyebrow_upper_right_quarter",@"left_eyebrow_upper_middle",@"left_eyebrow_upper_left_quarter",@"left_eyebrow_left_corner",@"left_eye_left_corner",@"left_eye_bottom",@"nose_left",@"mouth_left_corner",@"mouth_lower_lip_left_contour2",@"mouth_lower_lip_left_contour3",@"mouth_lower_lip_bottom",@"mouth_lower_lip_right_contour3",@"mouth_lower_lip_right_contour2",@"mouth_right_corner",@"nose_right",@"right_eye_left_corner",@"right_eye_bottom",@"right_eye_lower_right_quarter",@"right_eyebrow_right_corner",@"right_eyebrow_upper_right_quarter",@"right_eyebrow_upper_middle"];
    NSArray *pointArray1 = @[@"left_eyebrow_upper_middle",@"left_eyebrow_upper_left_quarter",@"left_eyebrow_left_corner",@"contour_left1",@"contour_left2",@"contour_left3",@"contour_left4",@"contour_left5",@"contour_left6",@"contour_left7",@"contour_left8",@"contour_left9",@"contour_chin",@"contour_right9",@"contour_right9",@"contour_right8",@"contour_right7",@"contour_right6",@"contour_right5",@"contour_right4",@"contour_right3",@"contour_right2",@"contour_right1",@"right_eyebrow_right_corner",@"right_eyebrow_upper_right_quarter",@"right_eyebrow_upper_middle"];
    
    NSArray *poArray = @[@"contour_left1",@"contour_left2",@"contour_left3",@"contour_left4",@"contour_left5",@"contour_left6",@"contour_left7",@"contour_left8",@"contour_left9",@"contour_chin",@"contour_right9",@"contour_right9",@"contour_right8",@"contour_right7",@"contour_right6",@"contour_right5",@"contour_right4",@"contour_right3",@"contour_right2",@"contour_right1"];
    //左脸点
    NSArray *poLeftArr = @[@"contour_left1",@"contour_left2",@"contour_left3",@"contour_left4",@"contour_left5",@"contour_left6"];
    //右脸点
    NSArray *poRightArr = @[@"contour_right6",@"contour_right5",@"contour_right4",@"contour_right3",@"contour_right2",@"contour_right1"];
    
    NSArray *pointArray2 = @[@"left_eyebrow_right_corner",@"left_eyebrow_upper_right_quarter",@"left_eyebrow_upper_right_quarter",@"left_eyebrow_upper_middle",@"left_eyebrow_upper_left_quarter",@"left_eyebrow_left_corner",@"left_eye_left_corner",@"left_eye_bottom",@"left_eye_lower_right_quarter",@"left_eye_right_corner",@"nose_contour_left1",@"nose_contour_left2",@"nose_left",@"nose_contour_left3",@"nose_contour_lower_middle",@"mouth_upper_lip_top",@"mouth_upper_lip_left_contour1",@"mouth_upper_lip_left_contour2",@"mouth_left_corner",@"mouth_lower_lip_left_contour2",@"mouth_lower_lip_left_contour3",@"mouth_lower_lip_bottom",@"mouth_lower_lip_right_contour3",@"mouth_lower_lip_right_contour2",@"mouth_right_corner",@"mouth_upper_lip_right_contour2",@"mouth_upper_lip_right_contour1",@"mouth_upper_lip_top",@"nose_contour_lower_middle",@"nose_contour_right3",@"nose_right",@"nose_contour_right2",@"nose_contour_right1",@"right_eye_left_corner",@"right_eye_lower_left_quarter",@"right_eye_bottom",@"right_eye_lower_right_quarter",@"right_eye_right_corner",@"right_eyebrow_right_corner",@"right_eyebrow_upper_right_quarter",@"right_eyebrow_upper_middle",@"right_eyebrow_upper_left_quarter",@"right_eyebrow_left_corner",@"left_eyebrow_right_corner"];
    UIGraphicsBeginImageContext(image.size);
    
    [image drawAtPoint:CGPointZero];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (NSDictionary *dic in array) {
        NSDictionary *rect = dic[@"face_rectangle"];
        CGFloat fw = [rect[@"width"] floatValue];
        CGFloat fh = [rect[@"height"] floatValue];
        
        for (int i = 0 ; i < poLeftArr.count + 2; i ++) {
            if (i < 2) {
                if (i == 0) {
                    NSDictionary *pointDic = [dic[@"landmark"] valueForKey:poLeftArr[0]];// 120 347
                    CGFloat x = [pointDic[@"x"] floatValue]+fw*(40/317.0);
                    CGFloat y = [pointDic[@"y"] floatValue] -fh*(100/317.0);
                    CGContextMoveToPoint(context, x, y);
                }else
                {
                    NSDictionary *pointDic = [dic[@"landmark"] valueForKey:poLeftArr[0]];
                    CGFloat x = [pointDic[@"x"] floatValue]+fw*(20/317.0);
                    CGFloat y = [pointDic[@"y"] floatValue] -fh*(50/317.0);
                    CGContextAddLineToPoint(context, x, y);
                }
                
            }else {
                NSDictionary *pointDic = [dic[@"landmark"] valueForKey:poLeftArr[i - 2]];
                CGFloat x = [pointDic[@"x"] floatValue]+fw*(i-2)*5/317.0;
                CGFloat y = [pointDic[@"y"] floatValue];
                CGContextAddLineToPoint(context, x, y);
            }
        }
        
        NSDictionary *btmleftDic = [dic[@"landmark"] valueForKey:poLeftArr[poLeftArr.count -1]];
        NSDictionary *btmrightDic = [dic[@"landmark"] valueForKey:poRightArr[0]];
        CGFloat blx = [btmleftDic[@"x"] floatValue] +fw*(20/317.0);
        CGFloat bly = [btmleftDic[@"y"] floatValue];
        CGFloat brx = [btmrightDic[@"x"] floatValue]- fw*(20/317.0);
        CGFloat bry = [btmrightDic[@"y"] floatValue];
        CGContextAddQuadCurveToPoint(context,blx +(brx - blx)/2, bry + fh*(120/317.0), brx, bry);//设置贝塞尔曲线的控制点坐标和终点坐
        
        for (int i = 0 ; i < poRightArr.count+2; i ++) {
            if (i < poRightArr.count ) {
                NSDictionary *pointDic = [dic[@"landmark"] valueForKey:poRightArr[i]];
                CGFloat x = [pointDic[@"x"] floatValue]-fw*(4-i)*5/317.0;
                CGFloat y = [pointDic[@"y"] floatValue];
                CGContextAddLineToPoint(context, x, y);
            }else {
                if (i == poRightArr.count) {
                    NSDictionary *pointDic = [dic[@"landmark"] valueForKey:poRightArr[poRightArr.count - 1]];
                    CGFloat x = [pointDic[@"x"] floatValue]-fw*(20/317.0);
                    CGFloat y = [pointDic[@"y"] floatValue] -fh*(50/317.0);
                    CGContextAddLineToPoint(context, x, y);
                }else {
                    NSDictionary *pointDic = [dic[@"landmark"] valueForKey:poRightArr[poRightArr.count - 1]];
                    CGFloat x = [pointDic[@"x"] floatValue]-fw*(40/317.0);
                    CGFloat y = [pointDic[@"y"] floatValue] -fh*(100/317.0);
                    CGContextAddLineToPoint(context, x, y);
                }
            }
        }
        
//        for (int i = 0; i < poArray.count+4; i ++) {
//
//            if (i < 2) {
//                if (i == 0) {
//                    NSDictionary *pointDic = [dic[@"landmark"] valueForKey:poArray[0]];// 120 347
//                    CGFloat x = [pointDic[@"x"] floatValue]+fw*(20/317.0);
//                    CGFloat y = [pointDic[@"y"] floatValue] -fh*(100/317.0);
//                    CGContextMoveToPoint(context, x, y);
//                }else
//                {
//                    NSDictionary *pointDic = [dic[@"landmark"] valueForKey:poArray[0]];
//                    CGFloat x = [pointDic[@"x"] floatValue]+fw*(10/317.0);
//                    CGFloat y = [pointDic[@"y"] floatValue] -fh*(50/317.0);
//                    CGContextAddLineToPoint(context, x, y);
//                }
//
//            }else if(i > 0 && i <poArray.count+2)
//            {
//                NSDictionary *pointDic = [dic[@"landmark"] valueForKey:poArray[i - 2]];
//                CGFloat x = [pointDic[@"x"] floatValue];
//                CGFloat y = [pointDic[@"y"] floatValue];
//
//                CGContextAddLineToPoint(context, x, y);
//            }else {
//                if (i == poArray.count+2) {
//                    NSDictionary *pointDic = [dic[@"landmark"] valueForKey:poArray[poArray.count - 1]];
//                    CGFloat x = [pointDic[@"x"] floatValue]-fw*(10/317.0);
//                    CGFloat y = [pointDic[@"y"] floatValue] -fh*(50/317.0);
//                    CGContextAddLineToPoint(context, x, y);
//                }else {
//                    NSDictionary *pointDic = [dic[@"landmark"] valueForKey:poArray[poArray.count - 1]];
//                    CGFloat x = [pointDic[@"x"] floatValue]-fw*(20/317.0);
//                    CGFloat y = [pointDic[@"y"] floatValue] -fh*(100/317.0);
//                    CGContextAddLineToPoint(context, x, y);
//                }
//
//            }
//
////            [pointDicArray addObject:pointDic];
//        }
        
        
        NSDictionary *topleftDic = [dic[@"landmark"] valueForKey:poArray[0]];
        NSDictionary *toprightDic = [dic[@"landmark"] valueForKey:poArray[poArray.count - 1]];
        CGFloat lx = [topleftDic[@"x"] floatValue];
        CGFloat ly = [topleftDic[@"y"] floatValue];
        CGFloat rx = [toprightDic[@"x"] floatValue];
        CGFloat ry = [toprightDic[@"y"] floatValue];

        CGContextAddQuadCurveToPoint(context,lx +(rx - lx)/2, ry - fh*(200/317.0), lx+fw*(40/317.0), ly-fh*(100/317.0));//设置贝塞尔曲线的控制点坐标和终点坐
    }
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 0, image.size.height);
    CGContextAddLineToPoint(context, image.size.width, image.size.height);
    CGContextAddLineToPoint(context, image.size.width, 0);
    CGContextAddLineToPoint(context, 0, 0);
    
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    //    CGContextEOFillPath(<#CGContextRef  _Nullable c#>);
    //    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    //按照前面的设置绘制
    //CGContextFillPath(context);
    CGContextEOFillPath(context);
    
    UIImage *temp = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //    temp = [self imageToTransparent:temp];
    
    //截取脸部
    for (NSDictionary *dic in array) {
        NSDictionary *rect = dic[@"face_rectangle"];
        CGFloat x = [rect[@"left"] floatValue];
        CGFloat y = [rect[@"top"] floatValue];
        CGFloat w = [rect[@"width"] floatValue];
        CGFloat h = [rect[@"height"] floatValue];
        
        //图片裁剪
        CGImageRef imageRef = CGImageCreateWithImageInRect([temp CGImage], CGRectMake(x+w*10/317.0, y - h*100/317.0, w-w*20/317.0, h + h*100/317.0));
        UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
        temp = croppedImage;
    }
    
    temp = [self imageToTransparent:temp];
    
    //美白磨皮
    temp = [self whiteningWithImage:temp];
    //素描
//    temp = [self applySketchFilter:temp];
    //淡化边缘
    temp = [self applyGaussianSelectiveBlur:temp];
    
    return temp;
}




//去除图片的绿色背景
+ (UIImage *) imageToFaceHandleImage:(UIImage *) image isTransparent:(BOOL)t
{
    if (t == NO) {
        return [[XPSFaceBeautify shareFace]imageToFaceHandle:image];
    }else
    return [[XPSFaceBeautify shareFace]imageToTransparent:image];
}
- (UIImage *) imageToTransparent:(UIImage *) image
{
    // 分配内存
    const int imageWidth = image.size.width;

    const int imageHeight = image.size.height;

    size_t bytesPerRow = imageWidth * 4;

    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);

    // 创建context

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,

                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);

    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);

    // 遍历像素

    int pixelNum = imageWidth * imageHeight;

    uint32_t* pCurPtr = rgbImageBuf;

    for (int i = 0; i < pixelNum; i++, pCurPtr++)

    {


        //接近白色

        //将像素点转成子节数组来表示---第一个表示透明度即ARGB这种表示方式。ptr[0]:透明度,ptr[1]:R,ptr[2]:G,ptr[3]:B

        //分别取出RGB值后。进行判断需不需要设成透明。

        uint8_t* ptr = (uint8_t*)pCurPtr;

        //(ptr[1] > 220 && ptr[2] > 220 && ptr[3] > 220)||
        //        NSLog(@"%d,%d,%d,%hhu",ptr[1],ptr[2],ptr[3],ptr[0]);
        if ((ptr[1] < 50) && (ptr[2] > 200) && (ptr[3] < 50) && (ptr[0] == 255)) {
            //透明色
            ptr[0] = 0;
        }
//        else if ((ptr[1] > 120 && ptr[2] > 120 && ptr[3] > 100) && (ptr[1] <=255  && ptr[2] <= 255 && ptr[3] <= 255)) {
//
//            //当RGB值都大于240则比较接近白色的都将透明度设为0.-----即接近白色的都设置为透明。某些白色背景具有杂质就会去不干净，用这个方法可以去干净
//            ptr[0] = 0.9;
//            ptr[1] = 167;  //蓝
//            ptr[2] = 204; //绿
//            ptr[3] = 233; //红
//
//        }
        //        int w = imageHeight - (i % imageHeight);
        //        bool shouldFade = (w <= 40.0);
        //
        //        if (shouldFade) {
        //            uint8_t *ptr = (uint8_t *)pCurPtr;
        //            ptr[0] = 0;
        //        }

    }

    // 将内存转成image

    CGDataProviderRef dataProvider =CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, nil);



    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight,8, 32, bytesPerRow, colorSpace,

                                        kCGImageAlphaLast |kCGBitmapByteOrder32Little, dataProvider,

                                        NULL, true,kCGRenderingIntentDefault);

    CGDataProviderRelease(dataProvider);

    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];

    // 释放
    CGImageRelease(imageRef);

    CGContextRelease(context);

    CGColorSpaceRelease(colorSpace);

    return resultUIImage;

}

- (UIImage *)imageToFaceHandle:(UIImage *) image
{
    // 分配内存
    const int imageWidth = image.size.width;
    
    const int imageHeight = image.size.height;
    
    size_t bytesPerRow = imageWidth * 4;
    
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    // 创建context
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 遍历像素
    
    int pixelNum = imageWidth * imageHeight;
    
    uint32_t* pCurPtr = rgbImageBuf;
    
    for (int i = 0; i < pixelNum; i++, pCurPtr++)
        
    {
        
        
        //接近白色
        
        //将像素点转成子节数组来表示---第一个表示透明度即ARGB这种表示方式。ptr[0]:透明度,ptr[1]:R,ptr[2]:G,ptr[3]:B
        
        //分别取出RGB值后。进行判断需不需要设成透明。
        
        uint8_t* ptr = (uint8_t*)pCurPtr;
        
        //(ptr[1] > 220 && ptr[2] > 220 && ptr[3] > 220)||
        //        NSLog(@"%d,%d,%d,%hhu",ptr[1],ptr[2],ptr[3],ptr[0]);
        if ((ptr[1] > 240 ) && (ptr[2] > 240) && (ptr[3] > 240) ) {
            //透明色
            ptr[0] = 0;
        }
        else if ((ptr[1] > 80 && ptr[2] > 80 && ptr[3] > 120) && (ptr[1] <=255  && ptr[2] <= 255 && ptr[3] <= 255)) {
            
            //当RGB值都大于240则比较接近白色的都将透明度设为0.-----即接近白色的都设置为透明。某些白色背景具有杂质就会去不干净，用这个方法可以去干净
            ptr[0] = 150;
            ptr[1] = 167;  //蓝
            ptr[2] = 204; //绿
            ptr[3] = 233; //红
      
        }
        
        //        int w = imageHeight - (i % imageHeight);
        //        bool shouldFade = (w <= 40.0);
        //
        //        if (shouldFade) {
        //            uint8_t *ptr = (uint8_t *)pCurPtr;
        //            ptr[0] = 0;
        //        }
        
    }
    
    // 将内存转成image
    
    CGDataProviderRef dataProvider =CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, nil);
    
    
    
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight,8, 32, bytesPerRow, colorSpace,
                                        
                                        kCGImageAlphaLast |kCGBitmapByteOrder32Little, dataProvider,
                                        
                                        NULL, true,kCGRenderingIntentDefault);
    
    CGDataProviderRelease(dataProvider);
    
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 释放
    CGImageRelease(imageRef);
    
    CGContextRelease(context);
    
    CGColorSpaceRelease(colorSpace);
    
    return resultUIImage;
    
}

///美白图片
+ (UIImage *)whiteImage:(UIImage *)image
              Whiteness:(int)whiteness {
    
    if (!whiteness || whiteness < 10 ||  whiteness > 150) {
        return image;
    }
    
    // 1.拿到图片，获取宽高
    CGImageRef imageRef =image.CGImage;
    NSInteger width = CGImageGetWidth(imageRef);
    NSInteger height = CGImageGetHeight(imageRef);
    
    // 2:创建颜色空间（灰色空间， 彩色空间）->  开辟一块内存空间
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    
    // 3:创建图片上下文
    // 为什么是UInt32类型，即是无符号32为int型 取值范围就是0-255之间
    // inputPixels是像素点集合的首地址
    UInt32 * inputPixels = (UInt32*)calloc(width * height, sizeof(UInt32));
    
    CGContextRef contextRef = CGBitmapContextCreate(inputPixels,
                                                    width,
                                                    height,
                                                    8, // 固定写法  8位
                                                    width * 4, // 每一行的字节  宽度 乘以32位 = 4字节
                                                    colorSpaceRef,
                                                    kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big); // 自己查咯
    
    // 4:根据图片上线纹绘制图片
    CGContextDrawImage(contextRef, CGRectMake(0, 0, width, height), imageRef);
    
    // 5：循环遍历每个像素点进行修改
    for (int i = 0; i < height; i ++) {
        for (int j = 0; j <  width; j ++) {
            UInt32 * currentPixels = inputPixels + (i * width) + j; // 改变指针的指向  每一个像素点都能遍历到了
            UInt32 color = *currentPixels;
            
            UInt32 colorA,colorR,colorG,colorB;
            
            colorR = R(color);   // 此处宏定义  计算RGBA的值  是通过位运算算的  自己百度咯
            colorR = colorR + whiteness;
            colorR = colorR > 255 ? 255 : colorR;
            
            colorG = G(color);
            colorG = colorG + whiteness;
            colorG = colorG > 255 ? 255 : colorG;
            
            colorB = B(color);
            colorB = colorB + whiteness;
            colorB = colorB > 255 ? 255 : colorB;
            
            colorA = A(color);
            *currentPixels = RGBAMake(colorR, colorG, colorB, colorA);
        }
    }
    
    
    // 6：创建Image对象
    CGImageRef newImageRef = CGBitmapContextCreateImage(contextRef);
    UIImage * newImage = [UIImage imageWithCGImage:newImageRef];
    
    // 7：释放内存
    CGColorSpaceRelease(colorSpaceRef);
    CGContextRelease(contextRef);
    CGImageRelease(newImageRef);
    free(inputPixels);
    
    return newImage;
}



@end

