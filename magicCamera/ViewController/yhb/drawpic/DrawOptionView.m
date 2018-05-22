//
//  DrawOptionView.m
//  miliu
//
//  Created by hibo on 2017/11/15.
//  Copyright © 2017年 hibo. All rights reserved.
//

#import "DrawOptionView.h"
#import "BaseController.h"

//#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface DrawOptionView()
@property (nonatomic, strong)NSNumber *alignment;

@end

@implementation DrawOptionView
{
    //取色底板
    UIView *backView;
    
    UIView *backView1,*backView2,*backView3,*backView4;//素材、画笔、文字背景
    
    UISlider *slider1,*slider2;//字体大小、透明度
    
    NSArray *_dataArray;//分类
    NSArray *_sourceArray;//画板背景图列表
    //    NSArray *boardImgArr;//画板背景图列表
    CustomTableView *tablev1,*tablev2;//素材标题、素材图片
    
    UIButton *setButton;//设置按钮
    UIButton *colorButton;//颜色按钮
    UIView *penBackView1,*penBackView2;//画笔中的设置、颜色背景
    
    UIButton *wordSetButton;//编辑按钮
    UIButton *wordColorButton;//颜色按钮
    UISlider *processSlider;//透明度
    UILabel *processLabel;
    NSMutableArray *wordButtonArr;//按钮
    UIView *wordBackView1,*wordBackView2;//编辑、颜色背景
    
    resultBlock result_block;
    UIButton *curpenButton;//画笔当前使用颜色按钮
    UIButton *curwordButton;//字体当前使用颜色按钮
    CustomButton *wordSFlagButton;//颜色粗细
    
    CustomButton *AnywayBtn; //横向转换
    CustomButton *shadowBtn;//阴影
    
    UIView *eraserBackView; //橡皮擦
    
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:backView1];
        backView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:backView2];
        backView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:backView3];
        
        backView4 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:backView4];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0.5)];
        line.backgroundColor = RGB(230, 230, 230);
        [self addSubview:line];
        backView1.backgroundColor = RGB(240, 240, 240);
        backView2.backgroundColor = RGB(240, 240, 240);
        backView3.backgroundColor = RGB(240, 240, 240);
        backView4.backgroundColor = RGB(240, 240, 240);
    }
    return self;
}
#pragma mark - 素材
-(void)setMaterialWithResult:(resultBlock)block{
    backView1.alpha = 1;backView2.alpha = 0;backView3.alpha = 0;backView4.alpha = 0;
    [self insertSubview:backView1 atIndex:self.subviews.count-1];
    if (tablev1==nil) {
        //创建tableview
        MJWeakSelf
        tablev1 = [[CustomTableView alloc] initWithFrame:CGRectMake(0, 0, Width, 30*rateh) result:^(NSInteger index,id result) {
            [[SDImageCache sharedImageCache]clearMemory];
            [weakSelf getSourcePicByTag:result[@"tag_id"]];
        }];
        [backView1 addSubview:tablev1];
        //
        [self getDrawbackImageView];
        //创建tableview
        tablev2 = [[CustomTableView alloc] initWithFrame:CGRectMake(0, 30*rateh, Width, 70*rateh) result:^(NSInteger index,id result) {
            block(result);
        }];
        [backView1 addSubview:tablev2];
    }
    //    [tablev1 setTitleArr:@[@{@"tag_name":@"人物",@"tag_data":@[@{@"original_image":@"http://mi6.wulinnet.com/images/201705/c4f4d013072829c339f714663ed01b26.png"},@{@"original_image":@"http://mi6.wulinnet.com/images/201706/0a0291886ab21f556faaa0c7b1e890e5.png"}]},@{@"tag_name":@"风景"},@{@"tag_name":@"动画"},@{@"tag_name":@"建筑"}]];
}
#pragma mark - 画笔Ï
-(void)setPenWithResult:(resultBlock)block{
    for (UIView *vi in [backView2 subviews]) {
        [vi removeFromSuperview];
    }
    backView1.alpha = 0;backView2.alpha = 1;backView3.alpha = 0;backView4.alpha = 0;
    [self insertSubview:backView2 atIndex:self.subviews.count-1];
    //    if (setButton==nil) {
    NSArray *titArr = @[@"设置",@"颜色"];
    for(int i=0;i<titArr.count;i++){
        UIButton *button = [MyBaseView myButtonFrame:CGRectMake(i*Width/2, 0, Width/2, 30*rateh) text:titArr[i] textColor:[UIColor blackColor] backgroudColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14*rateh]];
        [backView2 addSubview:button];
        [button addTarget:self action:@selector(penBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0)setButton = button;
        else colorButton = button;
    }
    setButton.backgroundColor = RGB(240, 240, 240);
    //设置背景
    penBackView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 30*rateh, Width, 70*rateh)];
    penBackView1.userInteractionEnabled = YES;
    [backView2 addSubview:penBackView1];
    penBackView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 30*rateh, Width, 70*rateh)];
    penBackView2.userInteractionEnabled = YES;
    penBackView2.alpha = 0;
    [backView2 addSubview:penBackView2];
    //进度条
    titArr = @[@"大小",@"透明度"];
    for (int i=0; i<2; i++) {
        UILabel *label = [MyBaseView myLabelFrame:CGRectMake(i*Width/2, 10*rateh, Width/2, 20*rateh) text:titArr[i] textColor:nil backgroudColor:nil font:[UIFont systemFontOfSize:12*rateh]];
        label.textAlignment = NSTextAlignmentCenter;
        [penBackView1 addSubview:label];
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(i*Width/2+10, 35*rateh, Width/2-20, 30*rateh)];
        slider.value = 0.5;
        [slider addTarget:self action:@selector(sliderEvent:) forControlEvents:UIControlEventValueChanged];
        [penBackView1 addSubview:slider];
        if (i==0)slider1 = slider;
        else slider2 = slider;
    }
    //当前颜色
    curpenButton = [MyBaseView myButtonFrame:CGRectNull text:nil textColor:nil backgroudColor:[UIColor blackColor] font:nil];
    [penBackView2 addSubview:[self getColor:curpenButton]];
    
    for (int i = 0; i < 7; i++) {
        UIButton *btn = [MyBaseView myButtonFrame:CGRectMake(10+25*rateh*2+30*rateh + (i+1)*35*rateh, 3*rateh, 30*rateh, 30*rateh) text:nil textColor:nil backgroudColor:randomColor font:nil];
        btn.layer.cornerRadius = 15*rateh;
        [btn addTarget:self action:@selector(colorSelect:) forControlEvents:UIControlEventTouchUpInside];
        [penBackView2 addSubview:btn];
        
    }
    
    //    }
    __weak UISlider *slid1 = slider1;
    __weak UISlider *slid2 = slider2;
    __weak UIButton *curBtn = curpenButton;
    result_block = ^(id result){
        NSMutableDictionary *info = [NSMutableDictionary dictionary];
        info[@"font"] = [NSString stringWithFormat:@"%.4f",slid1.value];
        info[@"trans"] = [NSString stringWithFormat:@"%.4f",slid2.value];
        info[@"color"] = curBtn.backgroundColor;
        block(info);
    };
}
-(void)penBtn:(UIButton *)button{
    setButton.backgroundColor = [UIColor whiteColor];
    colorButton.backgroundColor = [UIColor whiteColor];
    button.backgroundColor = RGB(240, 240, 240);
    NSLog(@"%@",button.titleLabel.text);
    if ([button.titleLabel.text isEqualToString:@"设置"]) {
        penBackView1.alpha = 1;
        penBackView2.alpha = 0;
    }else{
        penBackView1.alpha = 0;
        penBackView2.alpha = 1;
    }
}
//滑块
-(void)sliderEvent:(UISlider*)slider{
    result_block(slider);//触发代码块执行
}
//选择颜色
-(void)colorTap:(UIPanGestureRecognizer *)tap{
    CGPoint point = [tap locationInView:self];
    UIColor *color  = [self colorOfPoint:point];
    UIButton *button = backView2.alpha==1?curpenButton:curwordButton;
    button.backgroundColor = color;
    result_block(color);//触发代码块执行
}
//取色
-(UIView *)getColor:(UIButton *)current_button{
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 70*rateh)];
    //当前颜色
    UILabel *curLabel = [MyBaseView myLabelFrame:CGRectMake(10, 0, 20*rateh, 35*rateh) text:@"当前" textColor:nil backgroudColor:nil font:[UIFont systemFontOfSize:12*rateh]];
    curLabel.numberOfLines = 0;
    curLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:curLabel];
    current_button.frame = CGRectMake(10+25*rateh, 3*rateh, 30*rateh, 30*rateh);
    current_button.layer.cornerRadius = 15*rateh;
    [backView addSubview:current_button];
    
    UILabel *useLabel = [MyBaseView myLabelFrame:CGRectMake(10+25*rateh*2+30*rateh, 0, 20*rateh, 35*rateh) text:@"常用" textColor:nil backgroudColor:nil font:[UIFont systemFontOfSize:12*rateh]];
    useLabel.numberOfLines = 0;
    useLabel.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:useLabel];
    

    //颜色条
    UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(10, 35*rateh, Width-20, 30*rateh)];
    imagev.image = [UIImage imageNamed:@"color_icon"];
    imagev.userInteractionEnabled = YES;
    [backView addSubview:imagev];
    UIPanGestureRecognizer *tap = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(colorTap:)];
    [imagev addGestureRecognizer:tap];
    UITapGestureRecognizer *clicktap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(colorTap:)];
    [imagev addGestureRecognizer:clicktap];
    return backView;
}
//获取颜色值
- (UIColor *)colorOfPoint:(CGPoint)point {
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGContextTranslateCTM(context, -point.x, -point.y);
    [self.layer renderInContext:context];
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0 green:pixel[1]/255.0 blue:pixel[2]/255.0 alpha:pixel[3]/255.0];
    return color;
}

#pragma mark - 字体
-(void)setWordWithResult:(resultBlock)block{
    backView1.alpha = 0;backView2.alpha = 0;backView3.alpha = 1;backView4.alpha = 0;
    [self insertSubview:backView3 atIndex:self.subviews.count-1];
    if (processSlider==nil) {
        NSArray *titArr = @[@"编辑",@"颜色"];
        for(int i=0;i<titArr.count;i++){
            UIButton *button = [MyBaseView myButtonFrame:CGRectMake(i*Width/2, 0, Width/2, 30*rateh) text:titArr[i] textColor:[UIColor blackColor] backgroudColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16*rateh]];
            [backView3 addSubview:button];
            [button addTarget:self action:@selector(wordBtn:) forControlEvents:UIControlEventTouchUpInside];
            if (i==0)wordSetButton = button;
            else wordColorButton = button;
        }
        wordSetButton.backgroundColor = RGB(240, 240, 240);
        //设置背景
        wordBackView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 30*rateh, Width, 70*rateh)];
        wordBackView1.userInteractionEnabled = YES;
        [backView3 addSubview:wordBackView1];
        wordBackView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 30*rateh, Width, 70*rateh)];
        wordBackView2.userInteractionEnabled = YES;
        wordBackView2.alpha = 0;
        [backView3 addSubview:wordBackView2];
        //对其按钮
        NSArray *titleArr = @[@"横向切换",@"左对齐",@"居中对齐",@"右对齐",@"加粗",@"阴影"];
        NSArray *imgArr = @[@"word_function5_default",@"word_function1_default",@"word_function2_default",@"word_function3_default",@"word_function14_default",@"word_function5_default"];
        wordButtonArr = [NSMutableArray array];
        for (int i=0; i<titleArr.count; i++) {
            CustomButton *button = [MyBaseView myButtonFrame:CGRectMake(i*Width/titleArr.count, 0, Width/titleArr.count, 45*rateh) text:titleArr[i] textColor:[UIColor blackColor] backgroudColor:[UIColor clearColor] font:[UIFont systemFontOfSize:10*rateh]];
            button.titleEdgeInsets = UIEdgeInsetsMake(30*rateh, 0, 0, 0);
            [wordBackView1 addSubview:button];
            UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake((Width/titleArr.count-25*rateh)/2, 3*rateh, 25*rateh, 25*rateh)];
            imagev.image = [UIImage imageNamed:imgArr[i]];
            [button addSubview:imagev];
            button.tag=i;
            [button addTarget:self action:@selector(editBtn:) forControlEvents:UIControlEventTouchUpInside];
            [wordButtonArr addObject:button];
            if (i==4) {
                wordSFlagButton = button;
            }else if (i == 0) {
                AnywayBtn = button;
            }else if (i == 5) {
                shadowBtn = button;
            }
            
            button.idStr1 = @"0";
        }
        //透明度设置
        UILabel *label = [MyBaseView myLabelFrame:CGRectMake(10, 40*rateh, 45*rateh, 30*rateh) text:@"透明度" textColor:nil backgroudColor:nil font:[UIFont systemFontOfSize:12*rateh]];
        label.textAlignment = NSTextAlignmentCenter;
        [wordBackView1 addSubview:label];
        processLabel = [MyBaseView myLabelFrame:CGRectMake(Width-45*rateh-10, 40*rateh, 45*rateh, 30*rateh) text:@"50 %" textColor:nil backgroudColor:nil font:[UIFont systemFontOfSize:12*rateh]];
        processLabel.textAlignment = NSTextAlignmentCenter;
        [wordBackView1 addSubview:processLabel];
        processSlider = [[UISlider alloc] initWithFrame:CGRectMake(10+50*rateh, 40*rateh, Width-2*(10+50*rateh), 30*rateh)];
        processSlider.value = 1;
        [processSlider addTarget:self action:@selector(sliderEvent:) forControlEvents:UIControlEventValueChanged];
        [wordBackView1 addSubview:processSlider];
        
        //当前颜色
        curwordButton = [MyBaseView myButtonFrame:CGRectNull text:nil textColor:nil backgroudColor:[UIColor blackColor] font:nil];
        [wordBackView2 addSubview:[self getColor:curwordButton]];
    }
    __weak UISlider *slid = processSlider;
    __weak UILabel *labe = processLabel;
    __weak UIButton *curBtn = curwordButton;
    __weak CustomButton *flagButton =  wordSFlagButton;
    __weak CustomButton *anywayButton = AnywayBtn;
    __weak CustomButton *shadowButton = shadowBtn;
    MJWeakSelf
    result_block = ^(id result){
    
        NSMutableDictionary *info = [NSMutableDictionary dictionary];
        labe.text = [NSString stringWithFormat:@"%.0f %@",slid.value*100,@"%"];
        info[@"process"] = [NSString stringWithFormat:@"%.2f",slid.value];
        info[@"color"] = curBtn.backgroundColor;
        info[@"wordSFlag"] = flagButton.idStr;
        info[@"anyWay"] = anywayButton.idStr;
        info[@"shadow"] = shadowButton.idStr;
        if ([result isKindOfClass:[CustomButton class]]) {
            CustomButton *btn = result;
            info[@"textAli"] = [NSString stringWithFormat:@"%@",btn.idStr1];
            weakSelf.alignment = [NSNumber numberWithInteger:[btn.idStr1 integerValue]];
        }else {
            info[@"textAli"] = [NSString stringWithFormat:@"%@",weakSelf.alignment];
            
        }
        
        block(info);
    };
}
-(void)wordBtn:(UIButton *)button{
    wordSetButton.backgroundColor = [UIColor whiteColor];
    wordColorButton.backgroundColor = [UIColor whiteColor];
    button.backgroundColor = RGB(240, 240, 240);
    if ([button.titleLabel.text isEqualToString:@"编辑"]) {
        wordBackView1.alpha = 1;
        wordBackView2.alpha = 0;
    }else{
        wordBackView1.alpha = 0;
        wordBackView2.alpha = 1;
        for (int i = 0; i < 7; i++) {
            UIButton *btn = [MyBaseView myButtonFrame:CGRectMake(10+25*rateh*2+30*rateh + (i+1)*35*rateh, 3*rateh, 30*rateh, 30*rateh) text:nil textColor:nil backgroudColor:randomColor font:nil];
            btn.layer.cornerRadius = 15*rateh;
            [btn addTarget:self action:@selector(colorSelect:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:btn];
            //            [backView2 addSubview:btn];
            
        }
    }
}
-(void)colorSelect:(UIButton *)btn{
    NSLog(@"%@",btn.backgroundColor);
    UIButton *button = backView2.alpha==1?curpenButton:curwordButton;
    button.backgroundColor = btn.backgroundColor;
    result_block(btn.backgroundColor);
}
-(void)editBtn:(CustomButton *)button{
    if ([button.backgroundColor isEqual:[UIColor clearColor]]) button.backgroundColor = RGB(229, 229, 229);
    else button.backgroundColor = [UIColor clearColor];
    if (button.tag==4) {
        button.idStr = [button.backgroundColor isEqual:[UIColor clearColor]]?@"0":@"1";
    }else if (button.tag > 0 && button.tag< 4) {
        
        button.idStr1 = [NSString stringWithFormat:@"%ld",button.tag -1];
    }else if (button.tag == 0) {
        button.idStr = [button.backgroundColor isEqual:[UIColor clearColor]]?@"0":@"1";
    }else if (button.tag == 5) {
        button.idStr = [button.backgroundColor isEqual:[UIColor clearColor]]?@"0":@"1";
    }
    result_block(button);
}

#pragma mark --- 橡皮擦

- (void)setEraserResult:(resultBlock)block
{
    for (UIView *vi in [backView4 subviews]) {
        [vi removeFromSuperview];
    }
    backView1.alpha = 0;backView2.alpha = 0;backView3.alpha = 0;backView4.alpha = 1;
    [self insertSubview:backView4 atIndex:self.subviews.count-1];
    //    if (setButton==nil) {
    NSArray *titArr = @[@""];
    for(int i=0;i<titArr.count;i++){
        UIButton *button = [MyBaseView myButtonFrame:CGRectMake(i*Width/2, 0, Width/2, 1) text:titArr[i] textColor:[UIColor blackColor] backgroudColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16*rateh]];
        [backView4 addSubview:button];
        [button addTarget:self action:@selector(penBtn:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0)setButton = button;
        else colorButton = button;
    }
    setButton.backgroundColor = RGB(240, 240, 240);
    //设置背景
    penBackView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 30*rateh, Width, 70*rateh)];
    penBackView1.userInteractionEnabled = YES;
    [backView4 addSubview:penBackView1];
    penBackView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 30*rateh, Width, 70*rateh)];
    penBackView2.userInteractionEnabled = YES;
    penBackView2.alpha = 0;
    [backView4 addSubview:penBackView2];
    //进度条
    titArr = @[@"大小",@"透明度"];
    for (int i=0; i<2; i++) {
        UILabel *label = [MyBaseView myLabelFrame:CGRectMake(i*Width/2, 10*rateh, Width/2, 20*rateh) text:titArr[i] textColor:nil backgroudColor:nil font:[UIFont systemFontOfSize:14*rateh]];
        label.textAlignment = NSTextAlignmentCenter;
        [penBackView1 addSubview:label];
        UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(i*Width/2+10, 35*rateh, Width/2-20, 30*rateh)];
        slider.value = 1;
        [slider addTarget:self action:@selector(sliderEvent:) forControlEvents:UIControlEventValueChanged];
        [penBackView1 addSubview:slider];
        if (i==0)slider1 = slider;
        else slider2 = slider;
    }
    //当前颜色
    curpenButton = [MyBaseView myButtonFrame:CGRectNull text:nil textColor:nil backgroudColor:[UIColor blackColor] font:nil];
    [penBackView2 addSubview:[self getColor:curpenButton]];
    
    //    }
    __weak UISlider *slid1 = slider1;
    __weak UISlider *slid2 = slider2;
    __weak UIButton *curBtn = curpenButton;
    result_block = ^(id result){
        NSMutableDictionary *info = [NSMutableDictionary dictionary];
        info[@"font"] = [NSString stringWithFormat:@"%.4f",slid1.value]; //大小
        info[@"trans"] = [NSString stringWithFormat:@"%.4f",slid2.value]; //透明度
        info[@"color"] = curBtn.backgroundColor;
        
        block(info);
    };
}

#pragma mark ---- Network Request

-(void)getDrawbackImageView{
    [ZJProgressHUD showProgress];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"per_page"] = @"10";
    dic[@"page"] = @"1";
    dic[@"app_id"] = @"3";
    
    MJWeakSelf
    [HWHttpTool post:API_getTagList params:dic success:^(id json) {
        [ZJProgressHUD hideAllHUDs];
        if ([json[@"state"] isEqualToString:@"M00000"]) {
            _dataArray = json[@"result"][@"data"];
            NSDictionary *firstDic = _dataArray[0];
            NSString *tagid = [NSString stringWithFormat:@"%@",firstDic[@"tag_id"]];
            [weakSelf getSourcePicByTag:tagid];
            [tablev1 setTitleArr:_dataArray];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)getSourcePicByTag:(NSString *)tag {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"tag_id"] = tag;
    params[@"per_page"] = @10;
    params[@"page"] = @1;
    [ZJProgressHUD showProgress];
    [HWHttpTool post:API_MaterialsByTag params:params success:^(id json) {
        [ZJProgressHUD hideAllHUDs];
        
        _sourceArray = json[@"data"];
        [tablev2 setBoardImgArr:json[@"result"][@"data"]];
        
    } failure:^(NSError *error) {
        
    }];
}

@end
