//
//  ViewController.m
//  Picture
//
//  Created by 宋学谦 on 2016/12/20.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "ViewController.h"
#import "BigPicViewController.h"

@interface ViewController ()
@property (nonatomic, strong)NSMutableArray *recArray;
@property (nonatomic, strong)NSMutableArray *recArray2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"看大图";
    self.view.backgroundColor = [UIColor whiteColor];
 
    

    
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    self.recArray = [NSMutableArray array];
    self.recArray2 = [NSMutableArray array];
    
    self.recArray = [NSMutableArray arrayWithObjects:
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1482234577010&di=6cc8a59fb26714fbacc5d3e1ad6a0450&imgtype=0&src=http%3A%2F%2Fimg3.qianzhan123.com%2Fnews%2F201503%2F04%2F20150304-1c77a7d127f0e83e_600x5000.jpg",
                     @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1334964395,3558204258&fm=21&gp=0.jpg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b10000_10000&sec=1482224444&di=28bf8f9e687d4f4d86cbf16eb08ec0aa&src=http://img4.178.com/dota/201005/68451128775/68451214368.jpg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1482829314&di=94ec378d0699e5d5c42b16cafbf0c0a1&imgtype=jpg&er=1&src=http%3A%2F%2Fi2.17173cdn.com%2Fi7mz64%2FYWxqaGBf%2Ftu17173com%2F20141230%2FCxhxTqbjkmExqkA.jpg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1482829333&di=41d231a9d7b92f9b6160684d2172f998&imgtype=jpg&er=1&src=http%3A%2F%2Fi0.hdslb.com%2Fbfs%2Farchive%2Fb5c324e1b7d67791a5dd2c7303bc9498c7c9bfb4.jpg",
                     @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1482234634180&di=c421bb2a85e3c9c96722729e76f90c26&imgtype=0&src=http%3A%2F%2Farticle.fd.zol-img.com.cn%2Ft_s501x2000%2Fg5%2FM00%2F09%2F01%2FChMkJ1gexRCIZnCXAABNbxL1bBwAAXhSQIFhSsAAE2H347.jpg", nil];
    self.recArray2 = [NSMutableArray arrayWithObjects:@"pic1", @"pic2", @"pic3", @"pic4", @"pic5", @"pic6", nil];
    
    for (int i = 0; i < 6; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(10 + ((kScreenWidth - 40) / 3 + 10) * (i % 3), 10 + (10 + (kScreenWidth - 40) / 3) * (i / 3), (kScreenWidth - 40) / 3, (kScreenWidth - 40) / 3);
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.image = [UIImage imageNamed:[self.recArray2 objectAtIndex:i]];
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self.view addSubview:imageView];
        
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
        [imageView addGestureRecognizer:tap];
        
        
    }
}

- (void)click:(UITapGestureRecognizer *)action{
    
    BigPicViewController *bigVC = [[BigPicViewController alloc] init];
    bigVC.dataArray = self.recArray;
    bigVC.number = action.view.tag;
    
    [self.navigationController pushViewController:bigVC animated:YES];
    
    
}

    



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
