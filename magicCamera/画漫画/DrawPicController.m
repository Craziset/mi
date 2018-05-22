//
//  DrawPicController.m
//  miliu
//
//  Created by hibo on 2017/11/14.
//  Copyright © 2017年 hibo. All rights reserved.
//



#import "DrawPicController.h"
#import "DrawOptionView.h"
#import "DrawBoardView.h"
#import "SelectKindController.h"
#import "ZZMerchandiseViewController.h"
#import "RectTextView.h"
#import "RectImageView.h"
#import "XXDrawBoardView.h"
#import "DCBezierPaintBoard.h"

@interface DrawPicController ()<UIGestureRecognizerDelegate,rectTextViewDelegate>
{
    UIImageView *backImageView;
//    DrawBoardView *drawBoard;//画板
//    XXDrawBoardView *drawBoard;
    DCBezierPaintBoard *drawBoard;
    DrawOptionView *drawView;
    NSMutableArray *buttonArr;
    
    UIButton *cur_button;//当前选择的按钮
    BOOL addWordFlag;//添加文字标识
    CGFloat wordFont;//字体大小
    UIColor *wordColor;//字体颜色
    BOOL wordSFlag;//字体粗细
    float wordAlpha;//字体透明度
    BOOL wordAnyWay; //横向切换
    BOOL wordShadow;//字体阴影
    NSInteger textAlignment;//对齐方式
    
    UIImage *_sourceImage;//素材图片
    NSString *_imageUrl; //图片地址
    NSString *_thumbnailStr;// 缩略图地址
    NSData *_imagedata;
    dispatch_group_t _group;
    
    UITapGestureRecognizer *addWordGesture;
    
    //点击素材隐藏按钮
    BOOL isClickMaterial;
}

@property (nonatomic, assign) NSInteger btnTag;

@property (nonatomic, strong) NSMutableArray *labelArray;
//@property (nonatomic, strong) UIImageView *imgv;

@end

@implementation DrawPicController

-(void)nextBtn:(UIButton *)button{
//    backImageView.backgroundColor = [UIColor clearColor];
//    drawBoard.backgroundColor = [UIColor clearColor];
//    backImageView.backgroundColor = [UIColor clearColor];
    _sourceImage = [self createImg:backImageView];
//    backImageView.backgroundColor = [ui]
    
    _imagedata = UIImagePNGRepresentation(_sourceImage);
    if ([[ZZUserManager shareManager].isLogin isEqual:@YES]) {
        [ZJProgressHUD showProgress];
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            _group = dispatch_group_create();
            dispatch_group_async(_group, queue, ^{
                [self uploadToImage];
            });
            
            dispatch_group_notify(_group, queue, ^{
                [self sourceCommonUpload];
            });
        });
    }else {
        
        [ZJProgressHUD showProgress];
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            _group = dispatch_group_create();
            dispatch_group_async(_group, queue, ^{
                [self uploadToImage];
            });
            
            dispatch_group_notify(_group, queue, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    ZZMerchandiseViewController *selectC = [[ZZMerchandiseViewController alloc] init];
                    selectC.selectImage =  _sourceImage;
                    selectC.tagModel = self.tagModel;
                    selectC.picModel = self.picModel;
                    selectC.imageUrl = _imageUrl;
                    selectC.thumbnailStr = _thumbnailStr;
                    [self.navigationController pushViewController:selectC animated:YES];
                });
            });
        });
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    isClickMaterial = YES;
    buttonArr = [NSMutableArray array];
    wordFont = 16*rateh;
    wordAlpha = 1.0;
    wordColor = [UIColor blackColor];
    textAlignment = 0;
    self.btnTag = 0;
    [self.nextButton addTarget:self action:@selector(nextBtn:) forControlEvents:UIControlEventTouchUpInside];
    //设置图片展示
    backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,NAVHEIGHT+40*rateh, Width, Height-NAVHEIGHT-40*rateh-160*rateh)];
    backImageView.image = _selectImage;
    backImageView.userInteractionEnabled = YES;
//    backImageView.backgroundColor = [UIColor clearColor];
    backImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:backImageView];
    
    drawBoard  = [[DCBezierPaintBoard alloc] initWithFrame:CGRectMake(0, 0, Width, Height-NAVHEIGHT-40*rateh-160*rateh)];
    [backImageView addSubview:drawBoard];
    //添加手势加文字
    addWordGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    [drawBoard addGestureRecognizer:addWordGesture];
    //选项
    drawView = [[DrawOptionView alloc] initWithFrame:CGRectMake(0, Height-220*rateh, Width, 100*rateh)];
    drawView.alpha = 0;
    drawView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:drawView];
    //屏风
    UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(0, Height-100*rateh, Width, 100*rateh)];
    backview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backview];
    //选项按钮
    NSArray *titleArr = @[@"素材",@"笔画",@"文字",@"橡皮擦"];
    NSArray *imgArr = @[@"drawpic",@"drawpen",@"drawword",@"brush_3_default"];
    for (int i=0; i<titleArr.count; i++) {
        UIButton *button = [MyBaseView myButtonFrame:CGRectMake(i*Width/4, Height-120*rateh, Width/4, 60*rateh) text:titleArr[i] textColor:[UIColor blackColor] backgroudColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:12*rateh]];
        button.titleEdgeInsets = UIEdgeInsetsMake(35*rateh, 0, 0, 0);
        [self.view addSubview:button];
        UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake((Width/4-30*rateh)/2, 5*rateh, 30*rateh, 30*rateh)];
        imagev.image = [UIImage imageNamed:imgArr[i]];
        [button addSubview:imagev];
        button.tag=i;


        [button addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        [buttonArr addObject:button];
    }
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, Height-60*rateh, WIDTH, 1)];
    lab.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:lab];
    [self.view addSubview:self.nextButton];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
//按钮监听事件
-(void)btn:(UIButton *)button{
    
    drawBoard.isErase = NO;
    
    if (button.tag==1||button.tag==3) {
        drawBoard.stateFlag = YES;
    }else{
        drawBoard.stateFlag = NO;
    }
    addWordFlag = button.tag==2?YES:NO;
    for (UIButton *btn in buttonArr) {
        if (![button isEqual:btn]) {
            btn.backgroundColor = [UIColor whiteColor];
        }
    }
    //    if (button.tag==0||button.tag==1||button.tag==2) {
    if ([button.backgroundColor isEqual:[UIColor whiteColor]]) {
        button.backgroundColor = RGB(240, 240, 240);
        drawView.alpha = 1;
        drawView.frame = CGRectMake(0, Height-220*rateh+100*rateh, Width, 0);
        [UIView animateWithDuration:0.3 animations:^{
            drawView.frame = CGRectMake(0, Height-220*rateh, Width, 100*rateh);
        } completion:^(BOOL finished) {}];
    }else{
        button.backgroundColor = [UIColor whiteColor];
        drawView.frame = CGRectMake(0, Height-220*rateh, Width, 100*rateh);
        [UIView animateWithDuration:0.3 animations:^{
            drawView.frame = CGRectMake(0, Height-220*rateh+100*rateh, Width, 0);
        } completion:^(BOOL finished) {
            drawView.alpha = 0;
        }];
    }
    //    }
    if (button.tag==0) {//素材
        __weak DrawPicController *drawC = self;
        __block int i=0;
        [drawView setMaterialWithResult:^(id result) {//添加素材至画板上
            if (i>0)
            {
                RectImageView *rectImageV = [RectImageView initImageViewWithUrl:result[@"thumbnail"] SuperView:drawBoard point:CGPointMake(100, 100) tag:90];
                
            }
            
            //                [drawC addMaterial:result[@"thumbnail"]];
            i++;
        }];
    }else if (button.tag == 1) {//画笔
        addWordGesture.enabled = NO;
        drawBoard.lineColor = [UIColor blackColor];
        
        __weak DCBezierPaintBoard *board = drawBoard;
        [drawView setPenWithResult:^(id result) {//设置粗细
            NSLog(@"画笔：%@",result);
            
            CGFloat R, G, B;
            
            UIColor *uiColor = result[@"color"];
            CGColorRef color = [uiColor CGColor];
            int numComponents = CGColorGetNumberOfComponents(color);
            if (numComponents == 4)
            {
                const CGFloat *components = CGColorGetComponents(color);
                R = components[0];
                G = components[1];
                B = components[2];
                UIColor *alphaColor = [UIColor colorWithRed:R green:G blue:B alpha:[result[@"trans"] floatValue]];
                board.lineColor = alphaColor;
                board.lineWidth = [result[@"font"] floatValue]*10.0;
            }else {
                UIColor *alphaColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:[result[@"trans"] floatValue]];
                board.lineColor = alphaColor;
                board.lineWidth = [result[@"font"] floatValue]*10.0;
            }
        }];
    }else if (button.tag==2) {//文字
        addWordGesture.enabled = YES;
        MJWeakSelf
        [drawView setWordWithResult:^(id result) {
            NSLog(@"%@",result);
            wordColor = result[@"color"];
            wordAlpha = [result[@"process"] floatValue];
            wordSFlag = [result[@"wordSFlag"] intValue];
            textAlignment = [result[@"textAli"] integerValue];
            wordAnyWay = [result[@"anyWay"] boolValue];
            wordShadow = [result[@"shadow"] boolValue];
            
            for (UILabel *label in weakSelf.labelArray) {
                label.textColor = result[@"color"];
                label.alpha = [result[@"process"] floatValue];
                NSInteger alignemnt = [result[@"textAli"] integerValue];
                if (alignemnt == 0) {
                    label.textAlignment = NSTextAlignmentLeft;
                }else if (alignemnt == 1) {
                    label.textAlignment = NSTextAlignmentCenter;
                }else if (alignemnt == 2) {
                    label.textAlignment = NSTextAlignmentRight;
                }
                NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:label.text];
                if ([result[@"shadow"] boolValue]) {
                    NSShadow *shadow = [[NSShadow alloc]init];
                    shadow.shadowBlurRadius = 4.0;
                    shadow.shadowOffset = CGSizeMake(0, 0);
                    shadow.shadowColor = [UIColor blackColor];
                    [attributedStr addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(0, label.text.length)];
                   
                    if ([result[@"wordSFlag"] intValue] == 0) {
                        [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, label.text.length)];
                       
                    }else {
                        [attributedStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:15] range:NSMakeRange(0, label.text.length)];
                    }
                    
                }else {
                    NSShadow *shadow = [[NSShadow alloc]init];
                    shadow.shadowBlurRadius = 0.0;
                    shadow.shadowOffset = CGSizeMake(0, 0);
                    shadow.shadowColor = [UIColor whiteColor];
                    [attributedStr addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(0, label.text.length)];
                    if ([result[@"wordSFlag"] intValue] == 0) {
                        
                        [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, label.text.length)];
                    }else {
                        [attributedStr addAttribute:NSFontAttributeName value: [UIFont fontWithName:@"Helvetica-Bold" size:15] range:NSMakeRange(0, label.text.length)];
                    }
                }
                
                label.attributedText = attributedStr;
                if ([result[@"anyWay"] boolValue]) {
                    
                    CGFloat vh = backImageView.bounds.size.height - label.superview.frame.origin.y-70*rateh-30;
                    CGFloat vw = 17;
                    
                    RectTextView *textView = (RectTextView *)label.superview;
                    
                    textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, vw+35, vh+35);
                    textView.frameBlock(CGSizeMake(vw+35, vh+35));
                    [textView resetAllArrows];
                    
                }else {
                    CGFloat textH = [self HeightWithTxt:label.text width:SCR_WIDTH*0.6]+4;
                    CGFloat textW = SCR_WIDTH*0.6 > (label.text.length)*17 ?(label.text.length)*17:SCR_WIDTH*0.6;
                    RectTextView *textView = (RectTextView *)label.superview;
                    
                    textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textW+35, textH+35);
                    textView.frameBlock(CGSizeMake(textW+35, textH+35));
                    [textView resetAllArrows];
                    
                }
            }
            
            
            
            
        }];
    }else if (button.tag==3) {//橡皮擦
        drawView.alpha = 1;
        drawBoard.lineColor = [UIColor colorWithWhite:1 alpha:0];
        
        //        [drawBoard undoAction];
        drawBoard.isErase = YES;
        __weak XXDrawBoardView *board = drawBoard;
        
        [drawView setEraserResult:^(id result) {
            
//            board.lineColor = result[@"color"];
//            result[@"trans"] //透明度
            board.lineWidth = [result[@"font"] floatValue]*10.0;
        }];
    }
}

#warning 高度计算方法（一段文本按照固定宽度 所占得矩形区域）
- (CGFloat)HeightWithTxt:(NSString *)txt width:(CGFloat)w
{
    //参数1.预期尺寸范围
    CGSize size = CGSizeMake(w, 1200);
    //参数2.绘制选项
    //参数3.文本属性（字体， 字号）
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    //参数4。没用
    CGRect r = [txt boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil];
    return r.size.height;
}


//添加素材
-(void)addMaterial:(NSString *)url_string{
    NSURL *url = [NSURL URLWithString:url_string];
    
//    BaseMoveView *basView =[ [BaseMoveView alloc] initWithFrame:CGRectMake((Width-100*rateh)/2, 0, 180*rateh, 180*rateh)];
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake((Width-100*rateh)/2, 0, 180*rateh, 180*rateh)];
    imgv.userInteractionEnabled = YES;
    imgv.contentMode = UIViewContentModeScaleAspectFit;
    [imgv sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"common_nopic"]];

//    basView.backgroundColor = [UIColor colorWithPatternImage:imgv.image];
//    basView.contentMode = UIViewContentModeScaleToFill;
    imgv.userInteractionEnabled = YES;
    [drawBoard addSubview:imgv];
    
    UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
    deleteBtn.backgroundColor = [UIColor redColor];
    deleteBtn.layer.cornerRadius = 8;
    deleteBtn.clipsToBounds = YES;
    [deleteBtn setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
//    [deleteBtn setImage:[UIImage imageNamed:@"deleted.png"] forState:UIControlStateSelected];
    [deleteBtn addTarget:self action:@selector(deleteEvent:) forControlEvents:UIControlEventTouchUpInside];
    [imgv addSubview:deleteBtn];
    
    UIButton *spinBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(imgv.frame)-16, 0, 16, 16)];
    spinBtn.backgroundColor = [UIColor redColor];
    [spinBtn setImage:[UIImage imageNamed:@"spin.png"] forState:UIControlStateNormal];
    [spinBtn setImage:[UIImage imageNamed:@"spined.png"] forState:UIControlStateSelected];
    spinBtn.layer.cornerRadius = 8;
    spinBtn.clipsToBounds = YES;
    [spinBtn addTarget:self action:@selector(spinEvent:) forControlEvents:UIControlEventTouchUpInside];
    [imgv addSubview:spinBtn];
    
    UIButton *dragBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(imgv.frame)-16, CGRectGetHeight(imgv.frame)-16, 16, 16)];
    dragBtn.backgroundColor = [UIColor redColor];
    dragBtn.layer.cornerRadius = 8;
    dragBtn.clipsToBounds = YES;
    [dragBtn setImage:[UIImage imageNamed:@"drag.png"] forState:UIControlStateNormal];
    [dragBtn setImage:[UIImage imageNamed:@"draged.png"] forState:UIControlStateSelected];
    [dragBtn addTarget:self action:@selector(dragEvent:) forControlEvents:UIControlEventTouchUpInside];
    [imgv addSubview:dragBtn];
    
    
    //添加拖动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(removeTap:)];
    [imgv addGestureRecognizer:pan];
    //双击
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleEvent:)];
    doubleTapGesture.numberOfTapsRequired =2;
//    [imgv addGestureRecognizer:doubleTapGesture];
    //点击
    UITapGestureRecognizer *TapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(oneTapEvent:)];
    doubleTapGesture.numberOfTapsRequired =1;
    [imgv addGestureRecognizer:TapGesture];
    //捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)];
    [imgv addGestureRecognizer:pinch];
    //旋转手势
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(handleRotation:)];
    [imgv addGestureRecognizer:rotation];
    
//    [self addBorderToLayer:imgv];
}


//view加虚线边框
- (void)addBorderToLayer:(UIView *)view
{
    CAShapeLayer *border = [CAShapeLayer layer];
    //  线条颜色
    border.strokeColor = [UIColor blueColor].CGColor;
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
    
    border.frame = view.bounds;
    
    // 不要设太大 不然看不出效果
    border.lineWidth = 1;
    
    border.lineCap = @"square";
    
    //  第一个是 线条长度   第二个是间距    nil时为实线
    border.lineDashPattern = @[@9, @4];
    
    [view.layer addSublayer:border];
}

//捏合
-(void)handlePinch:(UIPinchGestureRecognizer *)recognizer{
    CGFloat scale = recognizer.scale;
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, scale, scale); //在已缩放大小基础下进行累加变化；区别于：使用 CGAffineTransformMakeScale 方法就是在原大小基础下进行变化
    recognizer.scale = 1.0;
}
//旋转
-(void)handleRotation:(UIRotationGestureRecognizer *)recognizer{
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0.0;
    
}
//-(void)spinDrag:(UIButton *)btn{
//    btn.superview.transform = CGAffineTransformRotate(btn.superview.transform, 10);
////    btn.rotation = 10;
//}

//添加文字
-(void)tapEvent:(UITapGestureRecognizer *)tap{
    if (!addWordFlag) return;


    
    if (![[UIResponder currentFirstResponder] isKindOfClass:[UITextView class]]) {
        
        NSLog(@"%@",[UIResponder currentFirstResponder]);
        NSLog(@"%@",tap.view.subviews);
        
        if (tap.view.subviews.count <= 0) {
            CGPoint point = [tap locationInView:drawBoard];
            
            RectTextView *retextView = [RectTextView initTextViewWithText:@"请输入文字请输入文字" superView:drawBoard point:point tag:self.btnTag];
            retextView.delegate  =self;
            retextView.textField.textColor = wordColor;
            retextView.textField.font = [UIFont systemFontOfSize:wordFont];
            retextView.textField.alpha = wordAlpha;
            
            retextView.textField.textAlignment = textAlignment;
            MJWeakSelf
            retextView.selectBlock = ^(NSInteger tag, BOOL select,UILabel *textLabel) {
                if (select) {
                    [weakSelf.labelArray addObject:textLabel];
                }else {
                    [weakSelf.labelArray removeObject:textLabel];
                }
            };
            self.btnTag ++;
            
        }else{
            
            NSMutableArray *viewsArr = [[NSMutableArray alloc]init];
        for (UIView *vi in tap.view.subviews) {
            if ([vi isKindOfClass:[RectTextView class]]) {
                
                RectTextView * RectVi = ( RectTextView *)vi;
                NSLog(@"%d",RectVi.cleanBtn.isHidden);
                if (RectVi.cleanBtn.isHidden == NO) {
                    
                    [viewsArr addObject:RectVi];
                }
                
            }

        }
            if (viewsArr.count == 0) {
                CGPoint point = [tap locationInView:drawBoard];
                
                RectTextView *retextView = [RectTextView initTextViewWithText:@"请输入文字请输入文字" superView:drawBoard point:point tag:self.btnTag];
                retextView.delegate  =self;
                retextView.textField.textColor = wordColor;
                retextView.textField.font = [UIFont systemFontOfSize:wordFont];
                retextView.textField.alpha = wordAlpha;
                
                retextView.textField.textAlignment = textAlignment;
                MJWeakSelf
                retextView.selectBlock = ^(NSInteger tag, BOOL select,UILabel *textLabel) {
                    if (select) {
                        [weakSelf.labelArray addObject:textLabel];
                    }else {
                        [weakSelf.labelArray removeObject:textLabel];
                    }
                };
                self.btnTag ++;
    

            }
        }

       
    }
    
}

- (void)deletePressViewTag:(NSInteger)tag label:(UILabel *)label {
    [self.labelArray removeObject:label];
}



//移动手势
-(void)removeTap:(UIPanGestureRecognizer *)recognizer{
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint newCenter = CGPointMake(recognizer.view.center.x+ translation.x,
                                    recognizer.view.center.y + translation.y);//    限制屏幕范围：
    newCenter.y = newCenter.y;//MAX(recognizer.view.frame.size.height/2, newCenter.y);
    newCenter.y = newCenter.y;//MIN(drawBoard.frame.size.height - recognizer.view.frame.size.height/2,newCenter.y);
    newCenter.x = newCenter.x;//MAX(recognizer.view.frame.size.width/2, newCenter.x);
    newCenter.x = newCenter.x;//MIN(self.view.frame.size.width - recognizer.view.frame.size.width/2,newCenter.x);
    recognizer.view.center = newCenter;
    [recognizer setTranslation:CGPointZero inView:self.view];
}

-(void)spinEvent:(UIButton *)btn{
    
  
    btn.selected = !btn.selected;
    for (UIGestureRecognizer *ges in btn.superview.gestureRecognizers) {
        if ([ges isKindOfClass:[UIRotationGestureRecognizer class]]) {
            ges.enabled = !btn.selected;

        }
    }
    
}
-(void)dragEvent:(UIButton *)btn{
    btn.selected = !btn.selected;
    NSLog(@"%@",btn.superview.gestureRecognizers);
    
    for (UIGestureRecognizer *ges in btn.superview.gestureRecognizers) {
        if ([ges isKindOfClass:[UIPinchGestureRecognizer class]]) {
            ges.enabled = !btn.selected;
            
        }
    }
   

//    [btn.superview removeFromSuperview];
}
-(void)deleteEvent:(UIButton *)btn{
    
    [btn.superview removeFromSuperview];
}

-(void)oneTapEvent:(UITapGestureRecognizer*)recognizer{
    isClickMaterial = !isClickMaterial;
    
    for (UIButton *btn in recognizer.view.subviews) {
        btn.hidden = !isClickMaterial;
    }
//    NSLog(@"%@",recognizer.view.subviews);
    
    
}
//双击手势
-(void)doubleEvent:(UITapGestureRecognizer*)recognizer{
    [recognizer.view removeFromSuperview];
}


//生成图片
-(UIImage *)createImg:(UIView *)view{
    for (UIView *view in drawBoard.subviews) {
        if ([view isKindOfClass:[RectImageView class]]) {
            RectImageView *baseView = (RectImageView *)view;
            baseView.isShowLine = NO;
            [baseView hiddenLine];
            [baseView removeSetupUI];
            
        }
    }

    CGSize size = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数。
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- 上传素材

- (void)uploadToImage {
    
    dispatch_group_enter(_group);
    [HWHttpTool post:API_ImageUpload params:@{@"height":@"200",@"width":@"200"} fileDatas:@[_imagedata] name:@"image" fileNames:@[@"finished.png"] mimeTypes:@[@"image/png"] success:^(id json) {
        NSLog(@"%@",json);
        
        if ([json[@"state"] isEqualToString:@"M00000"]) {
            NSString *imageUrl = [NSString stringWithFormat:@"%@",json[@"result"][@"original_image"]];
            _imageUrl = imageUrl;
            _thumbnailStr = [NSString stringWithFormat:@"%@",json[@"result"][@"original_image"]];
            dispatch_group_leave(_group);
        }else {
            dispatch_group_leave(_group);
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZJProgressHUD hideHUD];
            });
            [ZJProgressHUD showStatus:json[@"message"] andAutoHideAfterTime:1.1];
        }
        
    } failure:^(NSError *error) {
        dispatch_group_leave(_group);
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJProgressHUD hideHUD];
        });
        NSLog(@"%@",error);
    }];
    
}

- (void)sourceCommonUpload {
    MJWeakSelf
    [HWHttpTool post:API_CommonUpload params:@{@"image_url":_imageUrl,@"thumbnail":_thumbnailStr,@"user_id":USER_ID} success:^(id json) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJProgressHUD hideHUD];
        });
        if ([json[@"state"] isEqualToString:@"M00000"]) {
            NSDictionary *sourceDic = json[@"result"][0];
            
            ZZMerchandiseViewController *selectC = [[ZZMerchandiseViewController alloc] init];
            
            selectC.selectImage = _sourceImage;
            selectC.tagModel = weakSelf.tagModel;
            selectC.picModel = weakSelf.picModel;
            selectC.creative_id = sourceDic[@"creative_id"];
            [weakSelf.navigationController pushViewController:selectC animated:YES];
        }else {
            [ZJProgressHUD showStatus:json[@"message"] andAutoHideAfterTime:1.1];
        }
    
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ZJProgressHUD hideHUD];
        });
    }];
}


- (NSMutableArray *)labelArray {
    if (!_labelArray) {
        _labelArray = [NSMutableArray array];
    }
    return _labelArray;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

