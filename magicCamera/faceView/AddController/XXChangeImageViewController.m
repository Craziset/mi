//
//  XXChangeImageViewController.m
//  magicCamera
//
//  Created by 徐征 on 2017/12/2.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import "XXChangeImageViewController.h"

@interface XXChangeImageViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
//    UIImageView *backImageView;
    NSArray *titleArr;//分类
    NSArray *boardImgArr;//画板背景图列表
    NSInteger select_index;
    NSArray *_dataArray;
    NSArray *_sourceArray;
    CustomTableView *tablev1;
    CustomTableView *tablev2;
}
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIView *chooseView;

@end

@implementation XXChangeImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bigImageView.contentMode = UIViewContentModeScaleAspectFit;
    //创建tableview
    tablev1 = [[CustomTableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, 30*rateh) result:^(NSInteger index, id result) {
        NSLog(@"%@",result);
        [self getSourcePicByTag:result[@"tag_id"]];
    }];
    [self.chooseView addSubview:tablev1];
    //创建tableview
    tablev2 = [[CustomTableView alloc] initWithFrame:CGRectMake(0, 35*rateh, SCR_WIDTH, 70*rateh) result:^(NSInteger index,id result) {
//<<<<<<< .mine
        NSLog(@"%ld,%@",index,result);
        if (index == 0 && result == nil) {
            NSLog(@"本地上传");
            [self Cli];
            
        }else {
            NSURL *original_path = [NSURL URLWithString:result[@"small_image"]];
            
            [self.bigImageView sd_setImageWithURL:original_path placeholderImage:[UIImage imageNamed:@"common_nopic"]];
        }
        
//=======
//        NSLog(@"%@",result);
//        NSURL *original_path = [NSURL URLWithString:result[@"original_image"]];
//        [self.bigImageView sd_setImageWithURL:original_path placeholderImage:[UIImage imageNamed:@"common_nopic.png"]];
//>>>>>>> .r204
    }];
    [self.chooseView addSubview:tablev2];
    //获取背景图
    [self getDrawbackImageView];
}

- (IBAction)clickConfirm:(UIButton *)sender {
    
    if (self.imageBlock) {
        self.imageBlock(self.bigImageView.image);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
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
    [self.bigImageView setImage:image];
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
