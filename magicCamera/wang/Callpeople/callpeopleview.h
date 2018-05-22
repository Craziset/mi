//
//  callpeopleview.h
//  magicCamera
//
//  Created by Myself on 2017/11/15.
//  Copyright © 2017年 张展展. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface callpeopleview : UIView

@property (weak, nonatomic) IBOutlet UIView *backview;
@property (weak, nonatomic) IBOutlet UIView *backview2;
- (IBAction)cacleBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *callimg;
- (IBAction)callphone:(id)sender;

@end
