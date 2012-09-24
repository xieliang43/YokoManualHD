//
//  YKReadViewController.h
//  YokoManual
//
//  Created by xie liang on 12-9-15.
//  Copyright (c) 2012年 YOKOHAMA. All rights reserved.
//

#import "LeavesViewController.h"

@interface YKReadViewController : LeavesViewController
{
    NSMutableArray *imageArray;
}

- (void)setCurrentPage:(NSInteger)page;

@end
