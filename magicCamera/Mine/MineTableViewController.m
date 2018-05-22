//
//  MineTableViewController.m
//  magicCamera
//
//  Created by LONG on 2017/11/30.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "MineTableViewController.h"

#import "LSXAlertInputView.h"

#import "LZActionSheetView.h"

#import "GSPickerView.h"

#import "CityPickerVeiw.h"
#import "CityNameModel.h" //省市区模型
#import "ZSAnalysisClass.h"  // 数据转模型类

@interface MineTableViewController ()


@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@property (weak, nonatomic) IBOutlet UILabel *nickLab;

@property (weak, nonatomic) IBOutlet UILabel *idLab;

@property (weak, nonatomic) IBOutlet UILabel *sexLab;

@property (weak, nonatomic) IBOutlet UILabel *birthLab;

@property (weak, nonatomic) IBOutlet UILabel *emailLab;

@property (weak, nonatomic) IBOutlet UILabel *phoneLab;

@property (weak, nonatomic) IBOutlet UILabel *cityLab;

@property (weak, nonatomic) IBOutlet UILabel *signLab;

@property (nonatomic,strong)NSDictionary *userInfoDic;

@property (nonatomic, strong) UIView *headView;

//生日控件
@property (nonatomic,strong)GSPickerView *pickerView;

@end

@implementation MineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建自定义视图
    UIView *leftBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    leftBtnView.backgroundColor = [UIColor clearColor];
    //加载自定义视图
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtnView];
    
    //后退按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 8, 25, 25);
    [btn setImage:[UIImage imageNamed:@"返回2"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(navClick1) forControlEvents:UIControlEventTouchUpInside];
    [leftBtnView addSubview:btn];
    
    //关闭按钮
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(btn.right+20, 8, 25, 25);
    [btn2 setImage:[UIImage imageNamed:@"主页"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(navClick2) forControlEvents:UIControlEventTouchUpInside];
    [leftBtnView addSubview:btn2];
    
//    self.view.layer.cornerRadius = 38;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.tableFooterView = [UIView new];
    
    
    /*
     {
     "after_sales_num" = 0;
     area = "";
     "authentication_tag_img" = "";
     avatar = "http://mi6.wulinnet.com/images/Default_avatar.png";
     birthday = "";
     "brand_state" = 3;
     "designer_state" = 3;
     email = "";
     "fans_num" = 0;
     gender = 0;
     hasBind =     {
     qq = 0;
     wechat = 0;
     weibo = 0;
     };
     "is_official" = 0;
     "message_data_num" = 0;
     "nick_name" = "139****5678";
     "original_avatar" = "http://mi6.wulinnet.com/images/original_Default_avatar.png";
     phone = 13921405678;
     "product_num" = 48;
     sign = "";
     "user_id" = 11112;
     "user_type" = 0;
     "wait_pay_num" = 0;
     "wait_rejected_num" = 0;
     "wait_send_num" = 0;
     }
     */
    
    __weak __typeof(self)wself = self;
    
    [HWHttpTool post:API_GetUserInfo params:@{@"user_id":USER_ID} success:^(id json) {
        NSDictionary *dic = (NSDictionary *)json[@"result"];
        NSLog(@"%@",self.userInfoDic);
        wself.nickLab.text = dic[@"nick_name"];
        wself.idLab.text =[NSString stringWithFormat:@"%@",dic[@"user_id"]];
        NSString *sexStr = [[NSString stringWithFormat:@"%@",dic[@"gender"]] isEqualToString:@"1"]?@"男":@"女";
        wself.sexLab.text = sexStr;
        wself.birthLab.text =[NSString stringWithFormat:@"%@",dic[@"birthday"]];
        wself.emailLab.text = dic[@"email"];
        wself.phoneLab.text =[NSString stringWithFormat:@"%@",dic[@"phone"]];
        wself.cityLab.text = [NSString stringWithFormat:@"%@",dic[@"area"]];
        wself.signLab.text =dic[@"sign"];
        
        [wself.headImg sd_setImageWithURL:[NSURL URLWithString:dic[@"avatar"]] placeholderImage:[UIImage imageNamed:@"12@2x_32"]];
        
    } failure:^(NSError *error) {
        
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"%@",self.userInfoDic);
}

-(void)navClick1{
    sywBaseViewController *vc = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    [self.navigationController popToViewController:vc animated:YES];
}
-(void)navClick2{
    sywBaseViewController *vc = [self.navigationController.viewControllers objectAtIndex:0];
    [self.navigationController popToViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    __weak __typeof(self)wself = self;

    switch (indexPath.row) {
        case 0:
            {
                //更换头像
                [self alertOfHeaderImage];

                
            }
            break;
        case 1:
        {
            //更换昵称

            LSXAlertInputView * alert=[[LSXAlertInputView alloc]initWithTitle:@"提示" PlaceholderText:@"请输入文字" WithKeybordType:LSXKeyboardTypeDefault CompleteBlock:^(NSString *contents) {
                
                [HWHttpTool post:API_ChangeNickName params:@{@"user_id":USER_ID,@"nick_name":contents} success:^(id json) {
                    wself.nickLab.text = contents;
                    [MBProgressHUD showSuccess:json[@"message"] toView:self.view];
                } failure:^(NSError *error) {
                    
                }];            }];
            [alert show];
            
            
        }
            break;
        case 3:
        {
            //更换性别
            
            NSArray *array = @[@"男", @"女"];
            LZActionSheetView *action = [[LZActionSheetView alloc] initWithTitleView:self.headView optionsArr: array cancelTitle:@"取消" cancelBlock:^{
                
            } selectBlock:^(NSInteger index) {
                NSLog(@"点击了第 %ld 个", index);
                
                [HWHttpTool post:API_ChangeGender params:@{@"user_id":USER_ID,@"gender":[NSString stringWithFormat:@"%ld",index+1]} success:^(id json) {
                    NSString *sexStr = index+1 ==1?@"男":@"女";
                    wself.sexLab.text = sexStr;
                    [MBProgressHUD showSuccess:json[@"message"] toView:self.view];
                } failure:^(NSError *error) {
                    
                }];
            }];
            
            [self.view addSubview:action];
              }
            break;
        case 4:
        {
            //更换生日
            
            NSString *str = @"2017-01-01";
            
            [self.pickerView appearWithTitle:@"年月日" pickerType:GSPickerTypeDatePicker subTitles:nil selectedStr:str sureAction:^(NSInteger path, NSString *pathStr) {
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                [formatter setDateFormat:@"yyyy年MM月dd日"];
                NSDate *date = [formatter dateFromString:pathStr];
                NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
                [formatter1 setDateFormat:@"yyyy-MM-dd"];
                NSString *strdate = [formatter1 stringFromDate:date];
                [HWHttpTool post:API_ChangeBirthday params:@{@"user_id":USER_ID,@"birthday":strdate} success:^(id json) {
                    
                    wself.birthLab.text = strdate;

                    [MBProgressHUD showSuccess:json[@"message"] toView:self.view];
                } failure:^(NSError *error) {
                    
                }];
//                [sender setTitle:pathStr forState:UIControlStateNormal];
            } cancleAction:^{
                
            }];

            
           
        }
            break;
        case 5:
        {
            //修改邮箱
            
            LSXAlertInputView * alert=[[LSXAlertInputView alloc]initWithTitle:@"提示" PlaceholderText:@"请输入" WithKeybordType:LSXKeyboardTypeDefault CompleteBlock:^(NSString *contents) {
                
                [HWHttpTool post:API_ChangeEmail params:@{@"user_id":USER_ID,@"email":contents} success:^(id json) {
                    wself.emailLab.text = contents;
                    [MBProgressHUD showSuccess:json[@"message"] toView:self.view];
                } failure:^(NSError *error) {
                    
                }];            }];
            [alert show];
            
            
        }
            break;
        case 7:
        {
            //修改区域
            
            CityPickerVeiw * cityView = [[CityPickerVeiw alloc] init];
            [cityView show];
            cityView.showSelectedCityNameStr=self.cityLab.text;
            [cityView setCityBlock:^(NSString * value) {
                
                [HWHttpTool post:API_ChangeArea params:@{@"user_id":USER_ID,@"area":value} success:^(id json) {
                    wself.cityLab.text = value;
                    [MBProgressHUD showSuccess:json[@"message"] toView:self.view];
                } failure:^(NSError *error) {
                    
                }];
//                [btn setTitle:value forState:UIControlStateNormal];
            }];

        }
            break;
        case 8:
        {
            //修改个性签名
            
            LSXAlertInputView * alert=[[LSXAlertInputView alloc]initWithTitle:@"提示" PlaceholderText:@"请输入" WithKeybordType:LSXKeyboardTypeDefault CompleteBlock:^(NSString *contents) {
                
                [HWHttpTool post:API_ChangeSign params:@{@"user_id":USER_ID,@"sign":contents} success:^(id json) {
                    wself.signLab.text = contents;
                    [MBProgressHUD showSuccess:json[@"message"] toView:self.view];
                } failure:^(NSError *error) {
                    
                }];
                
            }];
            [alert show];
            
            
        }
            break;
        default:
            break;
    }
    
}


-(void)alertOfHeaderImage{
    //初始化相册对象
    UIImagePickerController *pickerC = [[UIImagePickerController alloc] init];
    pickerC.delegate = self;
    pickerC.allowsEditing = YES;
    //初始化弹出视图
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //判断是否具有相机硬件
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //设置对应的数据源
            pickerC.sourceType = UIImagePickerControllerSourceTypeCamera;
            //弹出相册
            [self presentViewController:pickerC animated:YES completion:^{
            }];
        }];
        [alertC addAction:action1];
    }else{
        NSLog(@"没有找到相机");
    }
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //设置对应的数据源类型
        pickerC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //弹出相册
        [self presentViewController:pickerC animated:YES completion:^{
        }];
    }];
    [alertC addAction:action2];
    //初始化事件对象
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertC addAction:action3];
    [self presentViewController:alertC animated:YES completion:^{
        
    }];
}
#pragma 相册代理事件
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    NSLog(@"editingInfo == %@",editingInfo);
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"didFinishPickingMediaWithInfo  == %@",info);
    
    [self.headImg setImage:info[@"UIImagePickerControllerEditedImage"]];

    
    [self imagedata:info[@"UIImagePickerControllerEditedImage"]];

//setImage:info[@"UIImagePickerControllerEditedImage"] forState:UIControlStateNormal];
    
//    _avatar = [self fixOrientation:[info objectForKey:@"UIImagePickerControllerEditedImage"]];
//    NSLog(@"%@",_avatar);
    //弹下去模态视图
    [self dismissViewControllerAnimated:YES completion:^{
        [self.tableView reloadData];
        
    }];
}
//缩放图片
- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // NSLog(@"%@",NSStringFromCGSize(scaledImage.size));
    return scaledImage;
}

//修正照片方向(手机转90度方向拍照)
- (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

#pragma 上传头像接口
-(void)imagedata:(UIImage *)photo
{
    /*
     [HWHttpTool post:API_ImageUpload params:nil fileDatas:@[_imagedata] name:@"finished" fileNames:@[@"finished.png"] mimeTypes:@[@"image/png"] success:^(id json) {
     NSLog(@"%@",json);
     NSString *imageUrl = [NSString stringWithFormat:@"%@",json[@"data"]];
     _imageUrl = imageUrl;
     dispatch_group_leave(_group);
     } failure:^(NSError *error) {
     dispatch_group_leave(_group);
     NSLog(@"%@",error);
     }];
     */
    NSData *imageData = UIImagePNGRepresentation(photo);
//    API_ChangeHeaderView
    NSNumber* date = @([[NSDate date] timeIntervalSince1970]);
    [HWHttpTool post:@"http://wx.nicway.cn/api/user/user_avatar" params:nil fileDatas:@[imageData] name:@"avatar" fileNames:@[[NSString stringWithFormat:@"%@%@%@",USER_ID,date,@"avatar.png"]] mimeTypes:@[@"image/png"] success:^(id json) {
//        NSLog(@"%@",json);
//        NSString *imageUrl = [NSString stringWithFormat:@"%@",json[@"data"]];
        if ([json[@"return_code"] isEqualToString:@"SUCCESS"])
        {
            [HWHttpTool post:@"http://wx.nicway.cn/api/user/change_avatar" params:@{@"user_id":USER_ID,@"avatar":json[@"return_body"]} success:^(id json) {
              
                if ([json[@"return_code"] isEqualToString:@"SUCCESS"])
                {
                    [HWHttpTool post:API_GetUserInfo params:@{@"user_id":USER_ID} success:^(id json) {
                        NSDictionary *dic = (NSDictionary *)json[@"result"];
                        ZZUserModel *model = [[ZZUserManager shareManager]userManager];
                        model.avatar = [NSString stringWithFormat:@"%@",dic[@"avatar"]];
                        [[ZZUserManager shareManager]saveUser:model];
                        [MBProgressHUD showError:@"头像修改成功"];
                        
                        
                        
                    } failure:^(NSError *error) {
                       
                    }];
                    
                }
                
            } failure:^(NSError *error) {
                
            }];
        }
       
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
  
    //    NSString *URL = [NSString stringWithFormat:@"%@//user/updavatar%@",SERVERURL,[DES3Util geturl]];
    //    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    //
    //    [manager POST:URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    //
    //        [formData appendPartWithFileData:UIImageJPEGRepresentation(photo, 1.0) name:@"file" fileName:@"file" mimeType:@"image/png"];
    //
    //    } progress:^(NSProgress * _Nonnull uploadProgress) {
    //
    //
    //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //        NSLog(@"%@",responseObject);
    //        _avatorModle=[AvatorModle mj_objectWithKeyValues:responseObject];
    //        if (_avatorModle.code==1) {
    //            [[NSUserDefaults standardUserDefaults]setObject:self.avatorModle.safeobj[@"safestring"] forKey:@"safestring"];
    //            NSString*nowstr=[NSString stringWithFormat:@"%@",self.avatorModle.safeobj[@"now"]];
    //            [[NSUserDefaults standardUserDefaults]setObject: nowstr forKey:@"now"];
    //
    //
    //
    //            NSMutableDictionary*dic= [[NSUserDefaults standardUserDefaults]objectForKey:@"userMessage" ];
    //            NSMutableDictionary*dic2=[dic mutableCopy];
    //            [dic2 setObject:_avatorModle.avatar forKey:@"avatar"];//保存的头像
    //
    //            [_tableView reloadData];
    //            [[NSUserDefaults standardUserDefaults]setObject:dic2 forKey:@"userMessage"];
    //        }if (_avatorModle.code==1006||_avatorModle.code==1007) {
    //            [[NSUserDefaults standardUserDefaults]setObject:self.avatorModle.safeobj[@"safestring"] forKey:@"safestring"];
    //
    //            NSString*nowstr=[NSString stringWithFormat:@"%@",self.avatorModle.safeobj[@"now"]];
    //            [[NSUserDefaults standardUserDefaults]setObject: nowstr forKey:@"now"];
    //
    //        }
    //
    //    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //        NSLog(@"123");
    //    }];
    
    
    
}
//从document取得图片
- (UIImage *)getImage:(NSString *)urlStr
{
    return [UIImage imageWithContentsOfFile:urlStr];
}

- (GSPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[GSPickerView alloc]initWithFrame:self.view.bounds];
    }
    return _pickerView;
}

@end
