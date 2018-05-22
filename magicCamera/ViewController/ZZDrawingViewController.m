//
//  ZZDrawingViewController.m
//  magicCamera
//
//  Created by 张展展 on 2017/10/13.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZDrawingViewController.h"
#import "ZZMerchandiseViewController.h"

@interface ZZDrawingViewController ()<LXFDrawBoardDelegate,XMFSegmentViewDataSource, XMFSegmentViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *title_view;
@property (strong, nonatomic) IBOutlet UIView *two_drawing_view;
@property (strong, nonatomic) IBOutlet UIView *clor_view;

@property (strong, nonatomic) IBOutlet UIView *four_xiangpicha_view;

@property (weak, nonatomic) IBOutlet UIView *twooooooo_view;


@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIView *cor_view;

@property(nonatomic,strong)UIView *sucai_view;
@property(nonatomic,strong)UIView *drawing_one_view;
@property(nonatomic,strong)UIView *drawing_two_view;
@property(nonatomic,strong)UIView *wenzi_one_view;
@property(nonatomic,strong)UIView *wenzi_two_view;
@property(nonatomic,strong)UIView *xiangpicha_view;



@property(nonatomic, copy) NSString *desc;

@end

@implementation ZZDrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = 0;
    
    [self.draw_image_view setImage:self.image];
 
//    self.draw_image_view.image = [UIImage imageNamed:self.image_nameSting];
    
    self.draw_image_view.delegate = self;
    //是指画板 滚动
  
    [self.transparency addTarget:self action:@selector(transparency_slider:) forControlEvents:UIControlEventValueChanged];
    [self.panel_size addTarget:self action:@selector(panel_sizeslider:) forControlEvents:UIControlEventValueChanged];
    //self.draw_image_view.image = [UIImage imageNamed:self.image_nameSting];
    

    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//***********************************************
// / 标题
- (NSString *)segmentView:(XMFSegmentView *)segmentView titleOfIndex:(NSUInteger)index {
    NSArray *ary = @[@"1", @"2", @"3", @"4", @"5", @"6"];
    NSString *str = ary[index];
    return str;
}

//  每个item的宽度
- (CGFloat)segmentView:(XMFSegmentView *)segmentView widthOfIndex:(NSUInteger)index {
    
    return 80.0f;
    
    
}

//  item的数量
- (NSUInteger)numberOfItemsInSegmentView:(XMFSegmentView *)segmentView {
    return 6;
}

//  点击item
- (void)segmentView:(XMFSegmentView *)segmentView didSelectItemsAtIndex:(NSUInteger)index {
    NSLog(@"点击了%ld", index);
    _label.text = [NSString stringWithFormat:@"%ld", index + 1];
}

//  高亮的颜色
- (UIColor *)highlightColorInSegmentView:(XMFSegmentView *)segmentView {
    return [UIColor grayColor];
}

//  标题字体颜色
- (UIColor *)fontColorInSegmentView:(XMFSegmentView *)segmentView {
    return [UIColor blackColor];
}






//***********************************************




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"DrawingStoryboard" bundle:nibBundleOrNil];
        ZZDrawingViewController *message = [stroyboard instantiateViewControllerWithIdentifier:@"drawing"];
        self = message;
    }
    return  self;
}


-(void)addView:(UIView *)view with:(UIView *)superView withaddview:(UIView *)addView{
    
    [superView removeFromSuperview];
    addView =[[UIView alloc]initWithFrame: CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    [view addSubview:addView];
    
    
}

-(void)setcor_view{
    _cor_view = [[UIView alloc]initWithFrame:CGRectMake(0, self.draw_image_view.frame.size.height - ViewH/6 , ViewW, ViewH/6)];
    [_draw_image_view addSubview:_cor_view];
}
- (IBAction)next_buttonclicked:(id)sender {
    if (_index == 0) {
        ZZMerchandiseViewController *wen = [[ZZMerchandiseViewController alloc]init];
        //wen.url = @"http://118.31.21.194/mijiu/page/";
        [self.navigationController pushViewController:wen animated:YES];
    }

    
    
}

- (IBAction)sucai_clicked:(id)sender {
    [self setcor_view];
    _sucai_view = [[UIView alloc]initWithFrame: CGRectMake(0, 0, _cor_view.frame.size.width, _cor_view.frame.size.height)];
    XMFSegmentView *view_sco = [XMFSegmentView new];
    _sucai_view.backgroundColor = [UIColor whiteColor];
    view_sco.dataSource = self;
    view_sco.columDelegate = self;
    view_sco.defaultIndex = 3;
    [_sucai_view addSubview: view_sco];
    
    CGSize size = _sucai_view.frame.size;
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(0, size.height/4+10, ViewW, size.height/4*3);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:30];
    _label = label;
    [_sucai_view addSubview: _label];
    
    
    UIImageView *imgvCtrl = [[UIImageView alloc]initWithFrame:CGRectMake(100, 0, 30, 30)];
    imgvCtrl.image = [UIImage imageNamed:@"edit_camera_default"];
    imgvCtrl.userInteractionEnabled = YES;
    [self.draw_image_view addSubview:imgvCtrl];
    
    UIPanGestureRecognizer *gesture5 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(onScaleAndRotate:)];
    [imgvCtrl addGestureRecognizer:gesture5];
    
    
    
    [_cor_view addSubview:_sucai_view];
}

-(void)onScaleAndRotate:(UIPanGestureRecognizer*)gesture
{
    CGPoint translation = [gesture translationInView:self.view];
    CGPoint center = gesture.view.center;
    center.x += translation.x;
    center.y += translation.y;
    gesture.view.center = center;
    [gesture setTranslation:CGPointZero inView:self.draw_image_view];
    
}
- (IBAction)huabi_clicked:(id)sender {
    [_sucai_view removeFromSuperview];
    _two_drawing_view.frame = CGRectMake(0, 0, _cor_view.frame.size.width, _cor_view.frame.size.height);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:2.0 forKey:@"Age"];
    [defaults synchronize];
   
    self.draw_image_view.brush = [LXFPencilBrush new];
    [_cor_view addSubview:_two_drawing_view];
    
}
- (IBAction)wenzi_clicked:(id)sender {
   
    _title_view.frame = CGRectMake(0, 0, _cor_view.frame.size.width, _cor_view.frame.size.height);
     self.draw_image_view.brush = [LXFTextBrush new];
    [_cor_view addSubview:_title_view];
}

- (IBAction)xiangpicha_clicked:(id)sender {
    
        [self.draw_image_view revoke];
}
// 画板
// 大小
- (IBAction)set_buttonclicked:(id)sender {
    [_clor_view removeFromSuperview];
    [_two_drawing_view removeFromSuperview];
    [_sucai_view removeFromSuperview];
    _two_drawing_view.frame = CGRectMake(0, 0, _cor_view.frame.size.width, _cor_view.frame.size.height);
    [_cor_view addSubview:_two_drawing_view];
}
// slider变动时改变label值
- (void)panel_sizeslider:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:self.panel_size.value forKey:@"Age"];
    [defaults synchronize];
    
}
// 颜色
- (IBAction)board_color_buttonclicked:(id)sender {
    [_clor_view removeFromSuperview];
    [_two_drawing_view removeFromSuperview];
    [_sucai_view removeFromSuperview];
    _clor_view.frame = CGRectMake(0, 0, _cor_view.frame.size.width, _cor_view.frame.size.height);
    [_cor_view addSubview:_clor_view];
}
// slider变动时改变label值
- (void)transparency_slider:(id)sender {
    
    
}


#pragma mark - LXFDrawBoardDelegate
- (NSString *)LXFDrawBoard:(LXFDrawBoard *)drawBoard textForDescLabel:(UILabel *)descLabel {
    
    //    return [NSString stringWithFormat:@"我的随机数：%d", arc4random_uniform(256)];
    return self.desc;
}

- (void)LXFDrawBoard:(LXFDrawBoard *)drawBoard clickDescLabel:(UILabel *)descLabel {
    descLabel ? self.desc = descLabel.text: nil;
    [self alterDrawBoardDescLabel];
}

- (void)alterDrawBoardDescLabel {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"添加描述" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.desc = alertController.textFields.firstObject.text;
        [self.draw_image_view alterDescLabel];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入";
        textField.text = self.desc;
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
}






-(void)addtap{
    
    UITapGestureRecognizer *labelTapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick1)];
    [self setTop:self.Lebel1 with:labelTapGestureRecognizer1];
   
    UITapGestureRecognizer *labelTapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick2)];
    [self setTop:self.Lebel2 with:labelTapGestureRecognizer2];
    
    UITapGestureRecognizer *labelTapGestureRecognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick3)];
    [self setTop:self.Lebel3 with:labelTapGestureRecognizer3];
    
    UITapGestureRecognizer *labelTapGestureRecognizer4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick4)];
    [self setTop:self.Lebel4 with:labelTapGestureRecognizer4];
    
    UITapGestureRecognizer *labelTapGestureRecognizer5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick5)];
    [self setTop:self.Lebel5 with:labelTapGestureRecognizer5];
    
    UITapGestureRecognizer *labelTapGestureRecognizer6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick6)];
    [self setTop:self.Lebel6 with:labelTapGestureRecognizer6];
    
    UITapGestureRecognizer *labelTapGestureRecognizer7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick7)];
    [self setTop:self.Lebel7 with:labelTapGestureRecognizer7];
    
    UITapGestureRecognizer *labelTapGestureRecognizer8 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick8)];
    [self setTop:self.Lebel8 with:labelTapGestureRecognizer8];
    
    UITapGestureRecognizer *labelTapGestureRecognizer9 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick9)];
    [self setTop:self.Lebel9 with:labelTapGestureRecognizer9];
    
}


// 获取颜色的RBGA
- (NSMutableArray *)changeUIColorToRGB:(UIColor *)color
{
    NSMutableArray *RGBStrValueArr = [[NSMutableArray alloc] init];
    NSString *RGBStr = nil;
    
    //获得RGB值描述
    NSString *RGBValue = [NSString stringWithFormat:@"%@", color];
    
    //将RGB值描述分隔成字符串
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    
    //获取红色值
    float r = [RGBArr[1] floatValue];
    RGBStr = [NSString stringWithFormat:@"%.2lf", r];
    [RGBStrValueArr addObject:RGBStr];
    
    //获取绿色值
    float g = [RGBArr[2] floatValue];
    RGBStr = [NSString stringWithFormat:@"%.2lf", g];
    [RGBStrValueArr addObject:RGBStr];
    
    //获取蓝色值
    float b = [RGBArr[3] floatValue];
    RGBStr = [NSString stringWithFormat:@"%.2lf", b];
    [RGBStrValueArr addObject:RGBStr];
    
    float a = [RGBArr[4] floatValue];
    RGBStr = [NSString stringWithFormat:@"%.2lf", a];
    [RGBStrValueArr addObject:RGBStr];
    
    //返回保存RGB值的数组
    return RGBStrValueArr;
}




-(void)labelClick9{
    
}
-(void)labelClick8{
    
}
-(void)labelClick7{
    
}
-(void)labelClick6{
    
}
-(void)labelClick5{
    
}
-(void)labelClick4{
    
}
-(void)labelClick3{
    
}
-(void)labelClick2{
    
}
-(void)labelClick1{
    
}

-(void)setTop:(UILabel *)label with:(UITapGestureRecognizer *)top{
    [label addGestureRecognizer:top];
    label.userInteractionEnabled = YES; // 可以理解为设置label可被点击
}



   

@end
