//
//  ViewController.m
//  OverlaySegueDemo
//
//  Created by zhoujinrui on 16/3/11.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import "ViewController.h"
#import "TVOverlaySegue.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:)];
    [self.view addGestureRecognizer:tap];
}

- (void)close:(UITapGestureRecognizer *)g
{
    [self.view endEditing:YES];
}

@end
