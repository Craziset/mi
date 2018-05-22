//
//  ZZFirstChoseOneViewController.m
//  magicCamera
//
//  Created by 张展展 on 2017/9/22.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZFirstChoseOneViewController.h"
#import "LXFDrawBoard.h"

#import "LXFRectangleBrush.h"
#import "LXFLineBrush.h"
#import "LXFArrowBrush.h"
#import "LXFTextBrush.h"
#import "LXFMosaicBrush.h"

#import "XMFSegmentView.h"

#import "ZZtextView.h"

@interface ZZFirstChoseOneViewController ()<LXFDrawBoardDelegate,XMFSegmentViewDataSource, XMFSegmentViewDelegate>
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,strong)LXFDrawBoard *board;
@property (strong, nonatomic)  UIView *corView;
@property (nonatomic, weak) UILabel *label;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)NSInteger index_tap;
@property (weak, nonatomic) IBOutlet UILabel *change_label;
@property(nonatomic,strong)UIView *firstView;
@property(nonatomic,strong)UIView *secondView;
@property(nonatomic,assign)CGSize cor_view_size;
@property(nonatomic,strong)UIView *sucai_View;
@property(nonatomic,strong)UIView *size_View;
@property(nonatomic,strong)UISlider *literals_slider;
@property(nonatomic,strong)UISlider *transparency_slider;
@property(nonatomic,assign)CGRect cor_view_height;
@property(nonatomic,assign)CGRect board_height;

@end

@implementation ZZFirstChoseOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _board = [[LXFDrawBoard alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_change_label.frame), ViewW, ViewH/32*19)];
    [self.view addSubview:_board];
    _corView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_board.frame), ViewW, ViewH/7)];
    [self.view addSubview:_corView];
    self.board.brush = [LXFPencilBrush new];
    
    self.cor_view_size = self.corView.frame.size;
    self.cor_view_height = self.corView.frame;
    self.board_height = self.board.frame;
  
    self.firstView = [self theFirstViewwithchose:100];
    self.index = 0;
    [self.corView addSubview:self.firstView];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [self.board alterDescLabel];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入";
        textField.text = self.desc;
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


-(UIView *)theFirstViewwithchose:(NSInteger )index{
    if (index == 100) {
         self.titleArray = @[@"1", @"2", @"3", @"4", @"5", @"6"];
    }else if(index == 200){
        self.titleArray = @[@"10", @"20", @"30", @"40", @"50", @"60"];
    }
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.cor_view_size.width, self.cor_view_size.height)];
    XMFSegmentView *view_sco = [XMFSegmentView new];
    view.backgroundColor = [UIColor grayColor];
    view_sco.dataSource = self;
    view_sco.columDelegate = self;
    view_sco.defaultIndex = 3;
    CGSize size = view.frame.size;
    view.frame = CGRectMake(0, 0, ViewW,size.height/4);
    [view addSubview: view_sco];
    
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(0, size.height/4+10, ViewW, size.height/4*3);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:30];
    _label = label;
    [view addSubview: _label];
    
    return view;
    
}


-(UIView *)theSecondView:(UIView *)view{
    CGSize size = view.frame.size;
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ViewW/4, size.height)];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(ViewW/4, 0, ViewW/4, size.height)];
    UIView *view3 = [[UIView alloc]initWithFrame:CGRectMake(ViewW/2, 0, ViewW/4, size.height)];
    UIView *view4 = [[UIView alloc]initWithFrame:CGRectMake(ViewW/4*3, 0, ViewW/4, size.height)];
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(view1.frame.size.width/2-15, 5, 30, 30)];
    imageView1.image = [UIImage imageNamed:@"素材.png"];
       UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(view2.frame.size.width/2-15, 5, 30, 30)];
    imageView2.image = [UIImage imageNamed:@"画笔.png"];
       UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(view3.frame.size.width/2-15, 5, 30, 30)];
     imageView3.image = [UIImage imageNamed:@"文字.png"];
       UIImageView *imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(view4.frame.size.width/2-15, 5, 30, 30)];
     imageView4.image = [UIImage imageNamed:@"衣色.png"];
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(imageView1.frame.origin.x, CGRectGetMaxY(imageView1.frame), 30, 10)];
    label1.text = @"素材";
    label1.font = [UIFont systemFontOfSize:12];
     label1.textAlignment = NSTextAlignmentCenter;
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(imageView2.frame.origin.x, CGRectGetMaxY(imageView2.frame), 30, 10)];
    label2.text = @"画笔";
    label2.textAlignment = NSTextAlignmentCenter;
        label2.font = [UIFont systemFontOfSize:12];
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(imageView3.frame.origin.x, CGRectGetMaxY(imageView3.frame), 30, 10)];
    label3.text = @"文字";
     label3.textAlignment = NSTextAlignmentCenter;
        label3.font = [UIFont systemFontOfSize:12];
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(imageView4.frame.origin.x, CGRectGetMaxY(imageView4.frame), 40, 10)];
     label4.textAlignment = NSTextAlignmentCenter;
    label4.text = @"橡皮擦";
    label4.font = [UIFont systemFontOfSize:12];
    [view1 addSubview:imageView1];
        [view2 addSubview:imageView2];
        [view3 addSubview:imageView3];
        [view4 addSubview:imageView4];
    
    [view1 addSubview:label1];
    [view2 addSubview:label2];
    [view3 addSubview:label3];
    [view4 addSubview:label4];
    
    [view addSubview:view1];
    [view addSubview:view2];
    [view addSubview:view3];
    [view addSubview:view4];
    
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fourClicked)];
    [self addTapOn:view1 with:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fourClicked2)];
    [self addTapOn:view2 with:tap2];
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fourClicked3)];
    [self addTapOn:view3 with:tap3];
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fourClicked4)];
    [self addTapOn:view4 with:tap4];
    
    
    
    
    
    
    return nil;
}

-(void)addTapOn:(UIView *)alabel with:(UITapGestureRecognizer *)tap
{
    alabel.userInteractionEnabled = YES;
    [alabel addGestureRecognizer:tap];
}
-(void)fourClicked{
    CGSize size = self.board.frame.size;
    self.sucai_View = [self theFirstViewwithchose:200];
    self.sucai_View.frame = CGRectMake(0, size.height - self.cor_view_size.height, ViewW, self.cor_view_size.height);
    [self.board addSubview:self.sucai_View];
}
-(void)fourClicked2{
    CGSize size = self.board.frame.size;
    [self.sucai_View removeFromSuperview];
    self.twoView.frame = CGRectMake(0, size.height - self.cor_view_size.height, ViewW, self.cor_view_size.height);
    
    self.board.brush = [LXFPencilBrush new];

    [self.board addSubview:self.twoView];
    
}
-(void)fourClicked3{
    CGSize size = self.board.frame.size;
    [self.twoView removeFromSuperview];
    self.title_view.frame = CGRectMake(0, size.height - self.cor_view_size.height, ViewW, self.cor_view_size.height);
    [self.board addSubview:self.title_view];
}
-(void)fourClicked4{
    CGSize size = self.board.frame.size;
    self.eraser_View.frame = CGRectMake(0, size.height - self.cor_view_size.height, ViewW, self.cor_view_size.height);
    [self.board addSubview:self.eraser_View];
}


//  标题
- (NSString *)segmentView:(XMFSegmentView *)segmentView titleOfIndex:(NSUInteger)index {
    NSString *str = self.titleArray[index];
    return str;
}

//  每个item的宽度
- (CGFloat)segmentView:(XMFSegmentView *)segmentView widthOfIndex:(NSUInteger)index {
  
    return ViewW/self.titleArray.count;
}

//  item的数量
- (NSUInteger)numberOfItemsInSegmentView:(XMFSegmentView *)segmentView {
    return self.titleArray.count;
}

//  点击item
- (void)segmentView:(XMFSegmentView *)segmentView didSelectItemsAtIndex:(NSUInteger)index {
    NSLog(@"点击了%ld", index);
    _label.text = [NSString stringWithFormat:@"%ld", index + 1];
}

//  高亮的颜色
- (UIColor *)highlightColorInSegmentView:(XMFSegmentView *)segmentView {
    return [UIColor blackColor];
}

//  标题字体颜色
- (UIColor *)fontColorInSegmentView:(XMFSegmentView *)segmentView {
    return [UIColor whiteColor];
}



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
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nibBundleOrNil];
        ZZFirstChoseOneViewController *message = [stroyboard instantiateViewControllerWithIdentifier:@"firstchose"];
        self = message;
    }
    return  self;
}


-(void)pagChoseTitelwith:(UIView *)view{
    UIButton *literals_Btn = [self createAButtonwith:CGRectMake(0, 0, ViewW/2, ViewH/28)];
    UIButton *transparency_Btn = [self createAButtonwith:CGRectMake(ViewW/2, 0, ViewW/2, ViewH/28)];
    [literals_Btn addTarget:self action:@selector(literals_Btn_create) forControlEvents:UIControlEventTouchUpInside];
    [transparency_Btn addTarget:self action:@selector(transparency_Btn_create) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:literals_Btn];
    [view addSubview:transparency_Btn];
}


-(UIButton *)createAButtonwith:(CGRect )frame{
    UIButton *button = [[UIButton alloc]initWithFrame:frame];
    button.backgroundColor = RGBA(243, 243, 243, 1);
    [button setTintColor:[UIColor blackColor]];
   return button;
}

-(void)literals_Btn_createwith:(UIView *)view{
    UIView *view_1 = [[UIView alloc]initWithFrame:view.frame];
    UIButton *literals_Btn = [self createAButtonwith:CGRectMake(0, 0, ViewW/2, ViewH/28)];
    UIButton *transparency_Btn = [self createAButtonwith:CGRectMake(ViewW/2, 0, ViewW/2, ViewH/28)];
    [literals_Btn addTarget:self action:@selector(literals_Btn_create) forControlEvents:UIControlEventTouchUpInside];
    [transparency_Btn addTarget:self action:@selector(transparency_Btn_create) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:literals_Btn];
    [view addSubview:transparency_Btn];
    
    
    
}

-(void)transparency_Btn_create{
    
}

- (IBAction)nextBU:(id)sender {
    self.index ++ ;
    
    if (self.index == 1) {
        CGSize size = self.corView.frame.size;
        [self.firstView removeFromSuperview];
        [_board removeFromSuperview];
        [_corView removeFromSuperview];
          _board = [[LXFDrawBoard alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_change_label.frame), ViewW, ViewH/32*19 + size.height/2)];
        _corView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_board.frame), ViewW, size.height/2)];
        self.board.delegate = self;
        self.board.image = [UIImage imageNamed:@"change_pic4_default.png"];
        [self.view addSubview:_board];
        [self.view addSubview:_corView];
   
        UIView *view = [self theSecondView:self.corView];
        [self.corView addSubview:view];
    }
    
}
- (IBAction)colorButton_clicked:(id)sender {
    
    [self.twoView removeFromSuperview];
    CGSize size = self.board.frame.size;
    self.threeView.frame = CGRectMake(0, size.height - self.cor_view_size.height, ViewW, self.cor_view_size.height);
    [self.board addSubview:self.threeView];
    
}
- (IBAction)titleCololerButton:(id)sender {
    
    [_big_small_Button setTitle:@"设置" forState:UIControlStateNormal];
    [_color_button setTitle:@"颜色" forState:UIControlStateNormal];
    [self.twoView removeFromSuperview];
    CGSize size = self.board.frame.size;
    self.threeView.frame = CGRectMake(0, size.height - self.cor_view_size.height, ViewW, self.cor_view_size.height);
    [self.board addSubview:self.threeView];
    
    
}
- (IBAction)back_button_clicked:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
