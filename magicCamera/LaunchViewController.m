//
//  LaunchViewController.m
//  magicCamera
//
//  Created by 徐征 on 2017/12/4.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *button;


@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

//    [self performSelector:@selector(gogogo)];
//    return
//    
    self.scrollView.contentSize = CGSizeMake(SCR_WIDTH*4, SCR_HEIGHT);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    NSArray *titArr = @[@"蝙蝠侠640x1136",@"超人640x1136",@"加菲猫640x1136",@"小王子640x1136"];
    for (int i = 0; i < 4; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:titArr[i]]];
        imageView.frame  = CGRectMake(i*SCR_WIDTH, 0, SCR_WIDTH, SCR_HEIGHT);
        [self.scrollView addSubview:imageView];
    }
    self.button = [[UIButton alloc]init];
    self.button.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [self.button setTitle:@"开始" forState:(UIControlStateNormal)];
    self.button.layer.borderWidth = 1;
    self.button.layer.cornerRadius = 6;
    self.button.layer.borderColor = YEllOWColor.CGColor;
    [self.button setTitleColor:YEllOWColor forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    self.button.hidden = YES;
    [self.button addTarget:self action:@selector(gogogo) forControlEvents:(UIControlEventTouchUpInside)];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(80);
    }];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > 2.9*SCR_WIDTH) {
        self.button.hidden = NO;
    }else
    {
        self.button.hidden = YES;
    }
}

- (void)gogogo
{
    [self performSegueWithIdentifier:@"gogogo" sender:nil];
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
