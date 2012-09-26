//
//  YKReadViewController.m
//  YokoManual
//
//  Created by xie liang on 12-9-15.
//  Copyright (c) 2012年 YOKOHAMA. All rights reserved.
//

#import "YKReadViewController.h"

@interface YKReadViewController ()

@end

@implementation YKReadViewController

- (void)dealloc
{
    [imageArray release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"YOKOHAMA节油手册";
        
        //self.wantsFullScreenLayout = YES;
        //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(1024 - 80, 20, 50, 50);
        [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:backBtn];

    }
    return self;
}

- (void)goBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIDeviceOrientationLandscapeRight) || (interfaceOrientation == UIDeviceOrientationLandscapeLeft);
}

- (void)setCurrentPage:(NSInteger)page
{
    [leavesView setCurrentPageIndex:page];
}

#pragma mark LeavesViewDataSource methods
- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView {
	return 32;
}

- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx {
    NSString *name = [NSString stringWithFormat:@"%d.jpg",index];
    UIImage *image = [UIImage imageNamed:name];
	CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
	CGAffineTransform transform = aspectFit(imageRect,CGContextGetClipBoundingBox(ctx));
	CGContextConcatCTM(ctx, transform);
	CGContextDrawImage(ctx, imageRect, [image CGImage]);
}

CGAffineTransform aspectFit(CGRect innerRect, CGRect outerRect) {
	CGFloat scaleFactor = MIN(outerRect.size.width/innerRect.size.width, outerRect.size.height/innerRect.size.height);
	CGAffineTransform scale = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
	CGRect scaledInnerRect = CGRectApplyAffineTransform(innerRect, scale);
	CGAffineTransform translation =
	CGAffineTransformMakeTranslation((outerRect.size.width - scaledInnerRect.size.width) / 2 - scaledInnerRect.origin.x,
									 (outerRect.size.height - scaledInnerRect.size.height) / 2 - scaledInnerRect.origin.y);
	return CGAffineTransformConcat(scale, translation);
}

@end
