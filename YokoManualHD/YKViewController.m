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

- (IBAction)atttionWeibo:(id)sender
{
    [_sinaEngine loginSina];
}

- (IBAction)shareToWeibo:(id)sender
{
    [_sinaEngine loginSina];
}

#pragma mark - XLSinaEngineDelegate
- (void)didLoginSina
{
    Debug(@"登陆成功");
}

- (void)didFialdLoginSina
{
    
}

- (void)didFinishShareToSina
{
    
}

- (void)didFaildShareToSina
{
    
}
@end
