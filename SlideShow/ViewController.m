//
//  ViewController.m
//  SlideShow
//
//  Created by Seungpill Baik on 2014. 11. 30..
//  Copyright (c) 2014년 retix. All rights reserved.
//

#import "ViewController.h"
#import "SlideShowView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SlideShowView *slideShow = [[SlideShowView alloc] initWithFrame:self.view.bounds];
    [slideShow setImageList:[self tmpImgList]];
    [self.view addSubview:slideShow];
    
    [slideShow beginShow];
}


- (NSMutableArray *) tmpImgList {
    NSMutableArray *tmpList = [NSMutableArray array];
    for (int i = 0; i < 11; i++) {
        [tmpList addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]]];
    }
    return tmpList;
}


@end
