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
@property (nonatomic, strong)UIPageControl *pageControl;
@end

@implementation BigPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
        
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
        imageView.frame = CGRectMake(i * kScreenWidth, 130, kScreenWidth, 200);
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
    
    self.pageControl = [[UIPageControl alloc] init];
    [self.pageControl setFrame:CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 30)];
    self.pageControl.numberOfPages = self.dataArray.count;
    self.pageControl.currentPage = self.number;
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self.view addSubview:self.pageControl];
    
    self.label = [[UILabel alloc] init];
    [self.label setFrame:CGRectMake(0, 10, self.view.frame.size.width, 30)];
    self.label.text = [NSString stringWithFormat:@"%ld/%lu", (long)self.number + 1, (unsigned long)self.dataArray.count];
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    
    
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    [self.pageControl setCurrentPage:offset.x / kScreenWidth];
    NSLog(@"%f",offset.x / kScreenWidth);
    
    NSInteger index = offset.x / kScreenWidth + 1;
    self.label.text = [NSString stringWithFormat:@"%ld/%lu", (long)index, (unsigned long)self.dataArray.count];
    
}




- (void)click:(UITapGestureRecognizer *)sender{
    
    [self dismissViewControllerAnimated:NO completion:nil];
//    BigPicViewController *bigVC = [[BigPicViewController alloc] init];
//    [self.view removeFromSuperview];
//    [bigVC removeFromParentViewController];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    
}



//长按保存到本地相册
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
