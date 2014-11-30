//
//  SlideShowView.m
//  SlideShow
//
//  Created by Seungpill Baik on 2014. 11. 30..
//  Copyright (c) 2014년 retix. All rights reserved.
//

#import "SlideShowView.h"

@implementation SlideShowView

const int zGap = 6000;
- (CATransform3D) getTransForm3DIdentity {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1 / 3000.0f;
    return transform;
}

- (void) dealloc {
    [_timer invalidate];
}

- (CGFloat) ratioHeightBaseWidth:(CGFloat) baseWidth withRealSize:(CGSize) realSize {
    return baseWidth * realSize.height / realSize.width;;
}

- (CGFloat) ratioWidthBaseHeight:(CGFloat) baseHeight withRealSize:(CGSize) realSize {
    return baseHeight * realSize.width / realSize.height;
}


- (void) setImageList:(NSArray *) imageList {
    _curIdx = 0;
    for (int i = 0 ; i < [imageList count] ; i++) {
        CALayer *showLayer = [CALayer layer];
        showLayer.transform = [self getTransForm3DIdentity];
        showLayer.bounds = self.bounds;
        showLayer.position = self.center;
        showLayer.opacity = (i == 0)? 1 : 0.5;
        [self.layer addSublayer:showLayer];

        UIImage *img = [imageList objectAtIndex:i];
        
        CGSize size = img.size;
        if (img.size.width > CGRectGetWidth(self.frame)) {
            size = CGSizeMake(CGRectGetWidth(self.frame), [self ratioHeightBaseWidth:CGRectGetWidth(self.frame) withRealSize:img.size]);
        } else if (img.size.height > CGRectGetHeight(self.frame)){
            size = CGSizeMake([self ratioWidthBaseHeight:(CGRectGetHeight(self.frame)) withRealSize:img.size], CGRectGetHeight(self.frame));
        }

        showLayer.bounds = (CGRect){CGPointZero, size};
        showLayer.contents = (id)img.CGImage;
        NSLog(@"i : %d bounds : %@", i , NSStringFromCGRect(showLayer.bounds));
        showLayer.transform = CATransform3DTranslate(showLayer.transform, 0, 0, - i * zGap);
        if (i != 0) {
            showLayer.position = CGPointMake((arc4random() % ((NSInteger)(CGRectGetWidth(self.frame)))) , (arc4random() % ((NSInteger)(CGRectGetHeight(self.frame)))));
        }
    }
}



- (void) beginShow {
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(aniStart) userInfo:nil repeats:YES];
}

- (void) aniStart {
    _curIdx = (_curIdx + 1) % [[self.layer sublayers] count];
    if (_curIdx == 0) {
        for (int i = 0 ; i < [[self.layer sublayers] count] ; i++) {
            CALayer *showLayer = [[self.layer sublayers] objectAtIndex:i];
            showLayer.transform = CATransform3DTranslate(showLayer.transform, 0, 0, - i * zGap);
            if (i != 0) {
                showLayer.position = CGPointMake((arc4random() % ((NSInteger)(CGRectGetWidth(self.frame)))) , (arc4random() % ((NSInteger)(CGRectGetHeight(self.frame)))));
            }
        }
    }
    
    [CATransaction setDisableActions:NO];
    [CATransaction setValue:[NSNumber numberWithFloat:2.0f] forKey:kCATransactionAnimationDuration];
    
    CALayer *curLayer = [[self.layer sublayers] objectAtIndex:_curIdx];
    curLayer.opacity = 1.0f;
    CGFloat deltax = self.center.x - curLayer.position.x;
    CGFloat deltay = self.center.y - curLayer.position.y;
    
    for (int i =0 ; i < [[self.layer sublayers] count]; i ++) {
        CALayer *layer = [[self.layer sublayers] objectAtIndex:i];
        if (i != _curIdx) {
            layer.opacity = 0.5;
        }
        
        layer.position = CGPointMake(layer.position.x + deltax, layer.position.y + deltay);
        [layer setValue:[NSNumber numberWithFloat:(_curIdx - i) * zGap] forKeyPath:@"transform.translation.z"];
    }


}


@end
