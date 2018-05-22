//
//  ZZCreatViewController.m
//  magicCamera
//
//  Created by 徐征 on 2017/11/8.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "ZZCreatViewController.h"

@interface ZZCreatViewController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;
@property (weak, nonatomic) IBOutlet UIButton *huanyuanBtn;

//@property (nonatomic , strong)UITapGestureRecognizer *tapGesture;
@property (nonatomic , assign)BOOL isHidden;
@property(strong,nonatomic)NSDictionary *NextproductDic; //产品的信息
//更换的图片
@property (nonatomic, strong) UIImage *newimage;

@property (weak, nonatomic) IBOutlet UIView *titleView;

@end

@implementation ZZCreatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.titleView.layer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
//    self.titleView.layer.shadowOffset = CGSizeMake(2,2);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
//    self.titleView.layer.shadowOpacity = 0.15;//阴影透明度，默认0
//    self.titleView.layer.shadowRadius = 2;//阴影半径，默认3
    
    self.title = @"";
    [self.logoImageView setImage:self.image];
//    self.logoImageView.layer.borderColor = RGBA(107, 188, 99, 1).CGColor;
//    self.logoImageView.layer.borderWidth = 1;
    CAShapeLayer *border = [CAShapeLayer layer];
    
    border.strokeColor = RGBA(107, 188, 99, 1).CGColor;
    
    border.fillColor = nil;
    
    border.path = [UIBezierPath bezierPathWithRect:self.logoImageView.bounds].CGPath;
    
    border.frame = self.logoImageView.bounds;
    
    border.lineWidth = 1.f;
    
    border.lineCap = @"square";
    
    border.lineDashPattern = @[@4, @2];
    
    [self.logoImageView.layer addSublayer:border];
    
   
    
//    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//    _tapGesture.delegate = self;
//
//    [self.view addGestureRecognizer:_tapGesture];
    
    
    
    self.changeBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.changeBtn.layer.cornerRadius = 3;
    self.changeBtn.layer.borderWidth = 1;
    
    self.huanyuanBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.huanyuanBtn.layer.cornerRadius = 3;
    self.huanyuanBtn.layer.borderWidth = 1;
    
    
    
    UIRotationGestureRecognizer *rotationGes = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundViewRotationAction:)];
    rotationGes.delegate = self;
    [self.view addGestureRecognizer:rotationGes];
    
    UIPinchGestureRecognizer *pinchGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundViewPinchAction:)];
    pinchGes.delegate =self;
    [self.view addGestureRecognizer:pinchGes];
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundViewPanAction:)];
    [panGes setMinimumNumberOfTouches:1];
    [panGes setMaximumNumberOfTouches:1];
    panGes.delegate = self;
    [self.view addGestureRecognizer:panGes];
    
}

//- (void)tapAction:(UIGestureRecognizer *)gesture{
//
//    _isHidden = !_isHidden;
//    [self.navigationController setNavigationBarHidden:_isHidden animated:YES];
//
//}
- (IBAction)xiadandingzhi:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction)changeImageClick:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.logoImageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)reductionImageClick:(id)sender {
    [self.logoImageView setImage:self.image];
}

#pragma mark 手势触发事件
-(void)backGroundViewPinchAction:(UIPinchGestureRecognizer *)gesture{
//    if (_tapTag != 0) {
        UIView *view = self.logoImageView;
        
        if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
            
            view.transform = CGAffineTransformScale(view.transform, gesture.scale, gesture.scale);
            gesture.scale = 1;
        }
//    }
    
}
-(void)backGroundViewPanAction:(UIPanGestureRecognizer *)gesture{
//    if (_tapTag != 0) {
    UIView *view = self.logoImageView;
        
        if (gesture.numberOfTouches == 1) {
            if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
                CGPoint transLation = [gesture translationInView:self.view];
                view.center = CGPointMake(view.center.x + transLation.x, view.center.y + transLation.y);
                [gesture setTranslation:CGPointZero inView:self.view];
            }
        }
//    }
    
}

-(void)backGroundViewRotationAction:(UIRotationGestureRecognizer *)gesture{
    
        UIView *view = self.logoImageView;
        
        view.transform = CGAffineTransformRotate(view.transform, gesture.rotation);
        
        gesture.rotation = 0;

}








//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return NO;
//}

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
