//
//  YKViewController.h
//  YokoManualHD
//
//  Created by liang xie on 9/22/12.
//  Copyright (c) 2012 liang xie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLSinaEngine.h"
#import "YKContentsViewController.h"

@interface YKViewController : UIViewController<XLSinaEngineDelegate>
{
    XLSinaEngine *_sinaEngine;
    NSInteger _flag;
}

- (IBAction)atttionWeibo:(id)sender;
- (IBAction)shareToWeibo:(id)sender;
- (IBAction)goToContents:(id)sender;

@end
