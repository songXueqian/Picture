//
//  BigPicViewController.m
//  Picture
//
//  Created by 宋学谦 on 2016/12/21.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "BigPicViewController.h"


@interface BigPicViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIButton *backButton;
@property (nonatomic, strong)UIButton *photosButton;
@property (nonatomic, strong)UIVisualEffectView *effectView;
@property (nonatomic, strong)UIVisualEffectView *downEffectView;
@property (nonatomic, strong)UILabel *downLabel;
@property (nonatomic, strong)UIView *grayView;

@end

@implementation BigPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //电池，时间，网络变白色
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];

    NSLog(@"number ==== %ld", (long)self.number);
    NSLog(@"dataArray ==== %@", self.dataArray);
    
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.scrollView.backgroundColor = [UIColor blackColor];
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    
    
    
    for (int i = 0 ; i < self.dataArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(i * kScreenWidth, - 20, kScreenWidth, kScreenHeight - 110);
        imageView.backgroundColor = [UIColor clearColor];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;

        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[self.dataArray objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@""]];
        
        

        
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        [imageView addGestureRecognizer:tap];
        
        [self.scrollView addSubview:imageView];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.dataArray.count * kScreenWidth, 0);
    self.scrollView.contentOffset = CGPointMake(self.number * kScreenWidth, 0);
    
   

    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //  毛玻璃view 视图
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //添加到要有毛玻璃特效的控件中
    self.effectView.frame = CGRectMake(0, 0, kScreenWidth, 64);
    [self.view addSubview:self.effectView];
    //设置模糊透明度
    self.effectView.alpha = .7f;
    
    self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 40, 20)];
    [self.backButton setTitle:@"<" forState:UIControlStateNormal];
    [self.backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.backButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.effectView addSubview:self.backButton];
    
    self.photosButton = [[UIButton alloc] initWithFrame:CGRectMake(self.effectView.frame.size.width - 90, 30, 80, 20)];
    [self.photosButton setTitle:@"晒图相册" forState:UIControlStateNormal];
    [self.photosButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.photosButton.titleLabel.font = [UIFont systemFontOfSize:16];
    self.photosButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.photosButton addTarget:self action:@selector(photos:) forControlEvents:UIControlEventTouchUpInside];
    [self.effectView addSubview:self.photosButton];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, kScreenWidth, 30)];
    self.label.text = [NSString stringWithFormat:@"%ld/%lu", (long)self.number + 1, (unsigned long)self.dataArray.count];
    self.label.font = [UIFont systemFontOfSize:14];
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.effectView addSubview:self.label];
    
    self.effectView.hidden = YES;
    
    
    
    UIBlurEffect *blurEffect2 = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //  毛玻璃view 视图
    self.downEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect2];
    //添加到要有毛玻璃特效的控件中
    self.downEffectView.frame = CGRectMake(0, kScreenHeight - 40 - 64, kScreenWidth, 64);
    [self.view addSubview:self.downEffectView];
    //设置模糊透明度
    self.downEffectView.alpha = .7f;
    
    self.downLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 30)];
    self.downLabel.text = @"12346189246198234761982376";
    self.downLabel.font = [UIFont systemFontOfSize:14];
    self.downLabel.textColor = [UIColor whiteColor];
    self.downLabel.textAlignment = NSTextAlignmentCenter;
    [self.downEffectView addSubview:self.downLabel];
    
    self.downEffectView.hidden = YES;
    
    
    self.grayView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 40, kScreenWidth, 40)];
    self.grayView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.grayView];
    
    self.grayView.hidden = YES;



}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    NSInteger index = offset.x / kScreenWidth + 1;
    self.label.text = [NSString stringWithFormat:@"%ld/%lu", (long)index, (unsigned long)self.dataArray.count];

}


- (void)back:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];


}

- (void)photos:(UIButton *)button{
    
}

- (void)click:(UITapGestureRecognizer *)sender{
    
    if (YES == self.effectView.hidden) {
        self.effectView.hidden = NO;
    } else {
        self.effectView.hidden = YES;

    }
    
    if (YES == self.downEffectView.hidden) {
        self.downEffectView.hidden = NO;
    } else {
        self.downEffectView.hidden = YES;
        
    }
    
    if (YES == self.grayView.hidden) {
        self.grayView.hidden = NO;
    } else {
        self.grayView.hidden = YES;
        
    }



}



//点击保存到本地相册
- (void)save:(UITapGestureRecognizer *)tap{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[self.dataArray objectAtIndex:tap.view.tag]]];
    
    UIImage *myImage = [UIImage imageWithData:data];
    
    [self saveImageToPhotos:myImage];
}
- (void)saveImageToPhotos:(UIImage*)savedImage

{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    
    NSString *msg = nil ;
    
    if(error != NULL){
        
        msg = @"保存图片失败" ;
        
    }else{
        
        msg = @"保存图片成功" ;
        
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                          
                                                    message:msg
                          
                                                   delegate:self
                          
                                          cancelButtonTitle:@"确定"
                          
                                          otherButtonTitles:nil];
    
    [alert show];
}


//然后是点击UIPageControl时的响应函数pageTurn


//- (void)tapBotAction:(id)sender{
//    
//    NSInteger index = [(UIButton *)sender tag];
//    self.pageControl.currentPage = index;
//    [self.scrollView setContentOffset:CGPointMake(index * kScreenWidth, 0) animated:YES]; //if animated is 'NO' animat don't implement
//    
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
