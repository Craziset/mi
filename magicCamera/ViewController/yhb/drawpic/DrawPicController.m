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
@interface DrawPicController ()<UIGestureRecognizerDelegate>
{
    UIImageView *backImageView;
    DrawBoardView *drawBoard;//画板
    DrawOptionView *drawView;
    NSMutableArray *buttonArr;
    
    UIButton *cur_button;//当前选择的按钮
    BOOL addWordFlag;//添加文字标识
    CGFloat wordFont;//字体大小
    UIColor *wordColor;//字体颜色
    BOOL wordSFlag;//字体粗细
    
    UITapGestureRecognizer *addWordGesture;
}

@end

@implementation DrawPicController

-(void)nextBtn:(UIButton *)button{
    ZZMerchandiseViewController *selectC = [[ZZMerchandiseViewController alloc] init];
    selectC.selectImage = [self createImg:backImageView];
    [self.navigationController pushViewController:selectC animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    buttonArr = [NSMutableArray array];
    wordFont = 16*rateh;
    wordColor = [UIColor blackColor];
    [self.nextButton addTarget:self action:@selector(nextBtn:) forControlEvents:UIControlEventTouchUpInside];
    //设置图片展示
    backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,NAVHEIGHT+40*rateh, Width, Height-NAVHEIGHT-40*rateh-160*rateh)];
    backImageView.image = _selectImage;
    backImageView.userInteractionEnabled = YES;
    backImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:backImageView];
    drawBoard  = [[DrawBoardView alloc] initWithFrame:CGRectMake(0, 0, Width, Height-NAVHEIGHT-40*rateh-160*rateh)];
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
        UIButton *button = [MyBaseView myButtonFrame:CGRectMake(i*Width/4, Height-120*rateh, Width/4, 60*rateh) text:titleArr[i] textColor:[UIColor blackColor] backgroudColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14*rateh]];
        button.titleEdgeInsets = UIEdgeInsetsMake(35*rateh, 0, 0, 0);
        [self.view addSubview:button];
        UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake((Width/4-30*rateh)/2, 5*rateh, 30*rateh, 30*rateh)];
        imagev.image = [UIImage imageNamed:imgArr[i]];
        [button addSubview:imagev];
        button.tag=i;
        [button addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        [buttonArr addObject:button];
    }
    [self.view addSubview:self.nextButton];
}
//按钮监听事件
-(void)btn:(UIButton *)button{
    NSLog(@"%@",button.titleLabel.text);
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
            if (i>0) [drawC addMaterial:result[@"original_image"]];
            i++;
        }];
    }else if (button.tag==1) {//画笔
        addWordGesture.enabled = NO;
        __weak DrawBoardView *board = drawBoard;
        [drawView setPenWithResult:^(id result) {//设置粗细
            NSLog(@"画笔：%@",result);
            board.lineColor = result[@"color"];
            board.lineWidth = [result[@"font"] floatValue]*10.0;
        }];
    }else if (button.tag==2) {//文字
        addWordGesture.enabled = YES;
        [drawView setWordWithResult:^(id result) {
            NSLog(@"%@",result);
            wordColor = result[@"color"];
            wordFont = [result[@"process"] floatValue]*32*rateh;
            wordSFlag = [result[@"wordSFlag"] intValue];
        }];
    }else if (button.tag==3) {//橡皮擦
        drawView.alpha = 0;
        [drawBoard undoAction];
        [drawView setEraserResult:^(id result) {
            
        }];
    }
}
//添加素材
-(void)addMaterial:(NSString *)url_string{
    NSURL *url = [NSURL URLWithString:url_string];
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake((Width-100*rateh)/2, 0, 100*rateh, 100*rateh)];
    imgv.userInteractionEnabled = YES;
    imgv.contentMode = UIViewContentModeScaleAspectFit;
    [imgv sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"common_nopic"]];
    imgv.userInteractionEnabled = YES;
    [drawBoard addSubview:imgv];
    //添加拖动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(removeTap:)];
    [imgv addGestureRecognizer:pan];
    //双击
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleEvent:)];
    doubleTapGesture.numberOfTapsRequired =2;
    [imgv addGestureRecognizer:doubleTapGesture];
    //捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)];
    [imgv addGestureRecognizer:pinch];
    //旋转手势
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(handleRotation:)];
    [imgv addGestureRecognizer:rotation];
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

//添加文字
-(void)tapEvent:(UITapGestureRecognizer *)tap{
    if (!addWordFlag) return;
    CGPoint point = [tap locationInView:drawBoard];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入文字" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入文字";
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *text = alert.textFields.firstObject.text;
        if (text.length>0) {
            [drawBoard addSubview:[self addWord:point text:text]];
        }
    }]];
    [self presentViewController:alert animated:YES completion:nil];
    
}
//添加文字
-(id)addWord:(CGPoint)point text:(NSString *)text{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(point.x-(text.length+1)*wordFont/2, point.y-(wordFont+2)/2, (text.length+1)*wordFont, wordFont+2)];
    UILabel *label = [MyBaseView myLabelFrame:CGRectMake(0, 0, backView.frame.size.width, wordFont) text:text textColor:wordColor backgroudColor:nil font:[UIFont systemFontOfSize:wordFont]];
    label.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:label];
    backView.userInteractionEnabled = YES;
    UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(removeTap:)];
    tap.delegate = self;
    label.font = wordSFlag?[UIFont boldSystemFontOfSize:wordFont]:[UIFont systemFontOfSize:wordFont];
    [backView addGestureRecognizer:tap];
    //双击
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleEvent:)];
    doubleTapGesture.numberOfTapsRequired =2;
    [backView addGestureRecognizer:doubleTapGesture];
    [tap requireGestureRecognizerToFail:doubleTapGesture];
    [addWordGesture requireGestureRecognizerToFail:doubleTapGesture];
    return backView;
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
//双击手势
-(void)doubleEvent:(UITapGestureRecognizer*)recognizer{
    [recognizer.view removeFromSuperview];
}
//生成图片
-(UIImage *)createImg:(UIView *)view{
    CGSize size = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数。
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
