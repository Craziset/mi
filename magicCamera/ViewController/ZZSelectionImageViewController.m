//
//  ZZSelectionImageViewController.m
//  magicCamera
//
//  Created by 张展展 on 2017/10/13.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZSelectionImageViewController.h"
#import "ZZDrawingViewController.h"

#import "ZZxuepaizhaoViewController.h"

#import "ZZMerchandiseViewController.h"

#import "ZZxchoseViewController.h"


#import "ViewController.h"

@interface ZZSelectionImageViewController ()<XMFSegmentViewDataSource, XMFSegmentViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *nextStep_Clicked;
@property (weak, nonatomic) IBOutlet UIView *selecImageView;
@property (weak, nonatomic) IBOutlet UIImageView *image_view;


// 传递图片
@property(nonatomic,copy)NSString *image_string;
@property(nonatomic,strong)UILabel *label;
@end

@implementation ZZSelectionImageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _image_view.image = [UIImage imageNamed:@"change_pic2_default"];
    [self setcor_view];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)next_step_button_clicked:(id)sender {
    if (_index == 0) {
    ZZDrawingViewController *drae = [[ZZDrawingViewController alloc]init];
    drae.image_nameSting = @"change_pic2_default.png";
    [self.navigationController pushViewController:drae animated:YES];
    }else{
        ViewController *wen = [[ViewController alloc]init];
        [self.navigationController pushViewController:wen animated:YES];
    }
}


-(void)setcor_view{
    XMFSegmentView *view_sco = [XMFSegmentView new];
    _selecImageView.backgroundColor = [UIColor whiteColor];
    view_sco.dataSource = self;
    view_sco.columDelegate = self;
    view_sco.defaultIndex = 3;
    [_selecImageView addSubview: view_sco];
    
    CGSize size = _selecImageView.frame.size;
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(0, size.height/4+10, ViewW, size.height/4*3);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:30];
    _label = label;
    [_selecImageView addSubview: _label];
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
        ZZSelectionImageViewController *message = [stroyboard instantiateViewControllerWithIdentifier:@"selectionImage"];
        self = message;
    }
    return  self;
}

- (IBAction)nextxchose:(id)sender {
    
   
        ZZxchoseViewController *xue = [[ZZxchoseViewController alloc]init];
        [self.navigationController pushViewController:xue animated:YES];
 
}


@end
