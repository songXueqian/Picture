//
//  UINavigationController+Statusbar.m
//  Picture
//
//  Created by 宋学谦 on 2016/12/21.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "UINavigationController+Statusbar.h"

@implementation UINavigationController (Statusbar)


- (UIStatusBarStyle)preferredStatusBarStyle{
    return [[self topViewController] preferredStatusBarStyle];
}
@end
