//
//  YKViewController.m
//  YokoManualHD
//
//  Created by liang xie on 9/22/12.
//  Copyright (c) 2012 liang xie. All rights reserved.
//

#import "YKViewController.h"

@interface YKViewController ()

@end

@implementation YKViewController

- (void)dealloc
{
    [_sinaEngine release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _sinaEngine = [[XLSinaEngine alloc] init];
    _sinaEngine.delegate = self;
    _sinaEngine.rootViewController = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIDeviceOrientationLandscapeRight) || (interfaceOrientation == UIDeviceOrientationLandscapeLeft);
}

- (IBAction)goToContents:(id)sender
{
    YKContentsViewController *contentsCon = [[YKContentsViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController *naviCon = [[UINavigationController alloc] initWithRootViewController:contentsCon];
    naviCon.navigationBarHidden = YES;
    [self presentModalViewController:naviCon animated:YES];
    [naviCon release];
    [contentsCon release];
}

- (IBAction)atttionWeibo:(id)sender
{
    _flag = 0;
    [_sinaEngine loginSina];
}

- (IBAction)shareToWeibo:(id)sender
{
    _flag = 1;
    [_sinaEngine loginSina];    
}

#pragma mark - XLSinaEngineDelegate
- (void)didLoginSina
{
    Debug(@"登陆成功");
    if (_flag == 0) {
        [_sinaEngine attentionWeibo];
    }else{
        NSString *str = @"#优科豪马节油手册# 物价疯涨，钱袋吃紧，勤俭持家从节约点滴汽油开始，超级实用的节油秘笈分享给你们，从此告别高油价带来的烦恼。@优科豪马橡胶 各种版本节油秘笈下载 http://champion.yokohama.com.cn/site/main";
        [_sinaEngine sendStatus:str withImage:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"]] longitude:0 latitude:0];
    }
}

- (void)didFialdLoginSina
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"登陆sina微博失败！"
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)didFinishShareToSina
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"分享到微博成功！"
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)didFaildShareToSina
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:@"分享到微博失败！"
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    [alert release];
}
@end
