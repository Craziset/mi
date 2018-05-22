//
//  CameraViewController.m
//  FaceImage
//
//  Created by 徐征 on 2017/10/30.
//  Copyright © 2017年 徐征. All rights reserved.
//

#import "CameraViewController.h"
#import "GPUImageBeautifyFilter.h"

#import "FCPPSDK.h"
#import "XPSFaceBeautify.h"
#import "DrawingViewController.h"

@interface CameraViewController ()
{
    CGFloat angle1;
}

@property (nonatomic, strong) GPUImageStillCamera *stillCamera;

@property (nonatomic, strong) GPUImageView *filterView;

@property (nonatomic, strong) UIButton *kaButton;

@property (nonatomic, strong) GPUImageBeautifyFilter *beautifyFilter;

@end

@implementation CameraViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"拍照";
    
    self.stillCamera = [[GPUImageStillCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionFront];
    self.stillCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.stillCamera.horizontallyMirrorFrontFacingCamera = YES;
    self.filterView = [[GPUImageView alloc] initWithFrame:self.view.frame];
    self.filterView.center = self.view.center;
    [self.view addSubview:self.filterView];
    [self.stillCamera addTarget:self.filterView];
    
    [self.stillCamera removeAllTargets];
    self.beautifyFilter = [[GPUImageBeautifyFilter alloc] init];
    [self.stillCamera addTarget:self.beautifyFilter];
    [self.beautifyFilter addTarget:self.filterView];
    [self.stillCamera startCameraCapture];
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:self.view.frame];
    img.image = [UIImage imageNamed:@"蒙版.png"];
    img.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:img];
    
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-150, self.view.frame.size.width, 150)];
    vi.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:vi];
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCR_WIDTH-20, 30)];
    textLabel.text = @"请选择一张光线均匀的正面照";
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:14];
    [vi addSubview:textLabel];
    
    self.kaButton  = [[UIButton alloc ]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 25, SCREEN_HEIGHT - 95, 50, 50)];
    self.kaButton.backgroundColor = [UIColor clearColor];
    self.kaButton.layer.cornerRadius = 10;
    [self.kaButton setImage:[UIImage imageNamed:@"camera_shape_default"] forState:(UIControlStateNormal)];
    
    [self.kaButton addTarget:self action:@selector(clickKaChaBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    self.kaButton.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.kaButton];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(40, SCREEN_HEIGHT - 90, 35, 35)];
    [btn setImage:[UIImage imageNamed:@"camera_upload_default"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(Cli) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *locaLabel = [[UILabel alloc]init];
    
    [self.view addSubview:locaLabel];
    [locaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn.mas_bottom).offset(3);
        make.centerX.mas_equalTo(btn);
        make.height.mas_equalTo(20);
    }];
    
    locaLabel.text = @"本地上传";
    locaLabel.font = [UIFont systemFontOfSize:12];
    locaLabel.textColor = [UIColor blackColor];
    [locaLabel sizeToFit];
    locaLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 31, 28, 28)];
    [self.view addSubview:backBtn];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"返回"] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(clickBackBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *toggleBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCR_WIDTH-50, 31, 30, 30)];
    [self.view addSubview:toggleBtn];
    [toggleBtn setBackgroundImage:[UIImage imageNamed:@"camera_change_default"] forState:(UIControlStateNormal)];
    [toggleBtn addTarget:self action:@selector(clickToggleBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
}

- (void)clickBackBtn:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickToggleBtn:(UIButton *)btn
{
    [self.stillCamera rotateCamera];
}


-(void)Cli{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    ///美白
    //    image = [XPSFaceBeautify whiteImage:image Whiteness:30];
    
    [self handleImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)clickKaChaBtn:(UIButton *)button
{
    __weak typeof(self) weakSelf = self;
    [self.stillCamera capturePhotoAsImageProcessedUpToFilter:self.beautifyFilter withCompletionHandler:^(UIImage *processedImage, NSError *error) {
        if(error){
            return;
        }
        
        //        weakSelf.imageblock(processedImage);
        //        [weakSelf.navigationController popViewControllerAnimated:YES];
        //存入本地相册
        //        UIImageWriteToSavedPhotosAlbum(processedImage, nil, nil, nil);
        
        //       UIImage *image = [XPSFaceBeautify whiteningWithImage:processedImage];
        [weakSelf handleImage:processedImage];
    }];
    
}





- (void)handleImage:(UIImage *)image{
    
    
    //清除人脸框
    //    [self.imageView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //检测人脸
    FCPPFaceDetect *faceDetect = [[FCPPFaceDetect alloc] initWithImage:image];
    
    self.image = faceDetect.image;
    
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //需要获取的属性
    NSArray *att = @[@"gender",@"age",@"headpose",@"smiling",@"blur",@"eyestatus",@"emotion",@"facequality",@"ethnicity"];
    [faceDetect detectFaceWithReturnLandmark:YES attributes:att completion:^(id info, NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        
        if (info) {
            NSArray *array = info[@"faces"];
            if (array.count) {
                UIImage *image = faceDetect.image;
                
                //绘制关键点和矩形框
                [weakSelf handleImage:image withInfo:array];
                
                
                
            }else{
                NSLog(@"没有检测到人脸");
                [MBProgressHUD showError:@"没有检测到人脸"];
            }
        }else{
            NSLog(@"网络失败");
            //            [MBProgressHUD showError:@"网络失败"];
            [weakSelf handleImage:image];
        }
    }];
    
}

- (void)handleImage:(UIImage *)image withInfo:(NSArray *)array{
    
    //    image =  [XPSFaceBeautify applySketchFilter:image];
    
    image = [XPSFaceBeautify cuttingBackgroundImage:image withInfo:array];
    

        if (self.imageblock) {
            self.imageblock(image);
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            DrawingViewController *drawVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"DrawingViewController"];
            drawVC.image_mat = self.image_mat;
            drawVC.image_face = image;
            drawVC.image_hair = self.image_hair;
            drawVC.image_facestyle = self.image_facestyle;
            
            drawVC.rect_face = self.rect_face;
            drawVC.rect_hair = self.rect_hair;
            drawVC.rect_facestyle = self.rect_facestyle;
            [self.navigationController pushViewController:drawVC animated:YES];
        }
    
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

