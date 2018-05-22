//
//  SelectImgController.m
//  miliu
//
//  Created by hibo on 2017/11/14.
//  Copyright © 2017年 hibo. All rights reserved.
//

#import "SelectImgController.h"
#import "DrawPicController.h"
#import "ZJProgressHUD.h"
#import "ZZSourceTagModel.h"
#import "ZZSourcePicModel.h"

@interface SelectImgController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UIImageView *backImageView;
    NSArray *titleArr;//分类
    NSArray *boardImgArr;//画板背景图列表
    NSArray *_dataArray;
    NSArray *_sourceArray;
    NSInteger select_index;
    CustomTableView *tablev1;
    CustomTableView *tablev2;
}

@property (nonatomic, strong) ZZSourceTagModel *tagModel;
@property (nonatomic, strong) ZZSourcePicModel *picModel;


@end

@implementation SelectImgController

//下一步
-(void)nextBtn:(UIButton *)button{
    DrawPicController *drawC = [[DrawPicController alloc] init];
    drawC.selectImage = backImageView.image;
    drawC.tagModel = self.tagModel;
    drawC.picModel = self.picModel;
    [self.navigationController pushViewController:drawC animated:YES];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //下一步点击事件
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, self.nextButton.frame.origin.y, 36, 36)];
    btn.layer.cornerRadius = 18;
    btn.clipsToBounds = YES;
    [btn setImage:[UIImage imageNamed:@"camera_upload_default"] forState:UIControlStateNormal];
    btn.backgroundColor = YEllOWColor;
    [btn addTarget:self action:@selector(Cli) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self.nextButton addTarget:self action:@selector(nextBtn:) forControlEvents:UIControlEventTouchUpInside];
    //设置图片展示
    backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, NAVHEIGHT+40*rateh, Width, Height-NAVHEIGHT-40*rateh-170*rateh)];
    backImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:backImageView];
    //创建tableview
    tablev1 = [[CustomTableView alloc] initWithFrame:CGRectMake(0, Height-160*rateh, Width, 30*rateh) result:^(NSInteger index,id result) {
        NSLog(@"%ld,%@",index,result);
        [[SDImageCache sharedImageCache]clearMemory];
        [self getSourcePicByTag:result[@"tag_id"]];
        self.tagModel = [ZZSourceTagModel mj_objectWithKeyValues:result];
    }];
    [self.view addSubview:tablev1];
    //创建tableview
    tablev2 = [[CustomTableView alloc] initWithFrame:CGRectMake(0, Height-130*rateh, Width, 70*rateh) result:^(NSInteger index,id result) {
         NSLog(@"%ld,%@",index,result);
       
        NSURL *original_path = [NSURL URLWithString:result[@"small_image"]];
        
        if (index == 0)
        {
            [backImageView setImage:[UIImage imageNamed:@"透明白板"]];
        }else
        {
            [backImageView sd_setImageWithURL:original_path placeholderImage:[UIImage imageNamed:@"common_nopic"]];
        }
        
        self.picModel = [ZZSourcePicModel mj_objectWithKeyValues:result];
        
    }];
    tablev2.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    tablev2.layer.borderWidth = 1;
    [self.view addSubview:tablev2];
    //获取背景图
    [self getDrawbackImageView];
}
#pragma mark - 请求画板背景图列表
-(void)getDrawbackImageView{
    [ZJProgressHUD showProgress];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    dic[@"app_id"] = @1;
    dic[@"tag_type"] = @2;
    MJWeakSelf
    [HWHttpTool post:API_getTagList params:dic success:^(id json) {
        [ZJProgressHUD hideAllHUDs];
        if ([json[@"state"] isEqualToString:@"M00000"]) {
            _dataArray = json[@"result"][@"data"];
            NSDictionary *firstDic = _dataArray[0];
            self.tagModel = [ZZSourceTagModel mj_objectWithKeyValues:firstDic];
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
    [HWHttpTool post:API_getSourcePicByTag params:params success:^(id json) {
        NSLog(@"%@",json);
        [ZJProgressHUD hideAllHUDs];

            _sourceArray = json[@"data"];
           [tablev2 setBoardImgArr:json[@"data"]];
            
    } failure:^(NSError *error) {
        
    }];
}


-(void)Cli{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [backImageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
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
