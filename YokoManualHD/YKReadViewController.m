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

@synthesize isHideBars;

- (void)dealloc
{
    [isHideBars release];
    [imageArray release];
    [self removeObserver:self forKeyPath:@"isHideBars"];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"YOKOHAMA节油手册";
        
        imageArray = [[NSMutableArray array] retain];
        for (int i = 1; i <= 31; i++) {
            NSString *name = [NSString stringWithFormat:@"%d.jpg",i];
            UIImage *img = [UIImage imageNamed:name];
            [imageArray addObject:img];
        }
        
        self.wantsFullScreenLayout = YES;
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
        
        [self addObserver:self forKeyPath:@"isHideBars" options:NSKeyValueObservingOptionNew context:nil];
        
        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(showBars:)];
        [self.view addGestureRecognizer:singleTapGesture];
        [singleTapGesture release];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setValue:@"YES" forKeyPath:@"isHideBars"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    NSLog(@"%@",[change description]);
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    if ([[change objectForKey:@"new"] isEqualToString:@"YES"]) {
        [self performSelector:@selector(hideBars) withObject:nil afterDelay:3];
    }
}

- (void)showBars:(UITapGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:self.view];
    if (point.x > 100 && point.x < 220) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        [self setValue:@"YES" forKeyPath:@"isHideBars"];
    }
}

- (void)hideBars
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark LeavesViewDataSource methods
- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView {
	return [imageArray count];
}

- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx {
    UIImage *image = [imageArray objectAtIndex:index];
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
