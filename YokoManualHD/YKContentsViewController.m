//
//  YKContentsViewController.m
//  YokoManualHD
//
//  Created by liang xie on 9/22/12.
//  Copyright (c) 2012 liang xie. All rights reserved.
//

#import "YKContentsViewController.h"

@interface YKContentsViewController ()

@end

@implementation YKContentsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)goBack:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)goToRead:(UIButton *)sender
{
    YKReadViewController *readViewCon = [[YKReadViewController alloc] initWithNibName:nil bundle:nil];
    readViewCon.curPage = sender.tag;
    [self.navigationController pushViewController:readViewCon animated:YES];
    [readViewCon release];
}

@end
