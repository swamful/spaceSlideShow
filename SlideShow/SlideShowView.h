//
//  SlideShowView.h
//  SlideShow
//
//  Created by Seungpill Baik on 2014. 11. 30..
//  Copyright (c) 2014년 retix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideShowView : UIView {
    NSTimer *_timer;
    NSInteger _curIdx;
}

- (void) setImageList:(NSArray *) imageList;
- (void) beginShow;
@end
