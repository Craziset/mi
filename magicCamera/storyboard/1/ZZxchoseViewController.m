//
//  ZZxchoseViewController.m
//  magicCamera
//
//  Created by 张展展 on 2017/10/25.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZxchoseViewController.h"
#import "ZZMerchandiseViewController.h"


@interface ZZxchoseViewController ()<XMFSegmentViewDataSource, XMFSegmentViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *cView;
@property(nonatomic,strong)UILabel *label;
@end

@implementation ZZxchoseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _board.image = [UIImage imageNamed:@"change_pic2_default.png"];
    [self setcor_view];
    
    // Do any additional setup after loading the view.
}



-(void)setcor_view{
    XMFSegmentView *view_sco = [XMFSegmentView new];
    _cView.backgroundColor = [UIColor whiteColor];
    view_sco.dataSource = self;
    view_sco.columDelegate = self;
    view_sco.defaultIndex = 3;
    [_cView addSubview: view_sco];
    
    CGSize size = _cView.frame.size;
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(0, size.height/4+10, ViewW, size.height/4*3);
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:30];
    _label = label;
    [_cView addSubview: _label];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextb:(id)sender {
    
    ZZMerchandiseViewController *m = [[ZZMerchandiseViewController alloc]init];
    [self.navigationController pushViewController:m animated:YES];
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
        UIStoryboard *stroyboard = [UIStoryboard storyboardWithName:@"DrawingStoryboard" bundle:nibBundleOrNil];
        ZZxchoseViewController *message = [stroyboard instantiateViewControllerWithIdentifier:@"xchose"];
        self = message;
    }
    return  self;
}


@end
