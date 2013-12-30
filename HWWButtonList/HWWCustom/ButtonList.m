//
//  ButtonList.m
//  HWWButtonList
//
//  Created by icreative-mini on 13-12-24.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "ButtonList.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00) >> 8))/255.0 blue:((float)((rgbValue) & 0xFF))/255.0 alpha:1.0]

@implementation ButtonList

- (id)initWithPoint:(CGPoint)point inView:(UIView *)inView
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _centerP = point;
        [inView addSubview:self];
//  create background view
        _tapView = [[UIView alloc] initWithFrame:inView.bounds];
        [inView addSubview:_tapView];
//  add remove tap
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeCurrentView)];
        [_tapView addGestureRecognizer:tapges];
    }
    return self;
}


- (void)show
{
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2 * self.btnRadius, 2 * self.btnRadius)];
    circle.layer.cornerRadius = self.btnRadius;
    circle.layer.masksToBounds = YES;
    circle.opaque = NO;
    circle.alpha = 0.97;
    

    _buttons = [[NSMutableArray alloc] initWithCapacity:self.count];
    for (int i = 0; i < self.count; i++) {
        int color = [self.backgroundColors[i] intValue];
        circle.backgroundColor = UIColorFromRGB(color);
        /* * * * * * * * * *  华 丽 丽 的  * * * * * * * * */
        UILabel *label = [[UILabel alloc] initWithFrame:circle.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"%@",self.titles[i]];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:30];
        label.textAlignment = NSTextAlignmentCenter;
        [circle addSubview:label];
        /* * * * * * * * * *  分  割  线  * * * * * * * * */
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[self imageWithView:circle] forState:UIControlStateNormal];
        [btn setTag:i];
        [btn addTarget:self action:@selector(selectedIndexButton:) forControlEvents:UIControlEventTouchUpInside];
        [btn setFrame:CGRectMake(0, 0, self.btnRadius, self.btnRadius)];
        btn.transform = CGAffineTransformMakeScale(2, 2);
        btn.center = self.superview.center;
        [_tapView addSubview:btn];
        
        [_buttons addObject:btn];
    }
    
    for (UIButton *btn in _buttons) {
        [self performSelector:@selector(animationWithButtons:) withObject:btn afterDelay:btn.tag * 0.1];
    }
}



//  create button's background image
- (UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    for (UIView *subView in view.subviews) {
        [subView removeFromSuperview];
    }

    return img;
}



//  button touch event
- (void)selectedIndexButton:(UIButton *)btn
{
    [_buttons removeObject:btn];
    [UIView animateWithDuration:0.25f animations:^{
        btn.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f animations:^{
            [self scaleSingleButton:btn];
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
            for (UIButton *subBtn in _buttons) {
                [self performSelector:@selector(removeSubButton:)
                           withObject:subBtn
                           afterDelay:subBtn.tag * 0.1];
            }
        }];
    }];
    
    if ([self.delegate respondsToSelector:@selector(didSelectButton:atIndex:)]) {
        [self.delegate didSelectButton:btn atIndex:btn.tag];
    }
}



//  the button scale animate
- (void)animationWithButtons:(UIButton *)btn
{
    CGFloat pointY = _centerP.y + self.spacingFromSender;
    CGFloat pointX = (320 / self.count * btn.tag) + (320 / self.count / 2);
    
    [UIView animateWithDuration:0.2f animations:^{
        [btn setCenter:CGPointMake(pointX, pointY)];
        btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25f animations:^{
            btn.transform = CGAffineTransformMakeScale(0.8, 0.8);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1f animations:^{
                btn.transform = CGAffineTransformMakeScale(1, 1);
            }completion:^(BOOL finished) {
                btn.layer.shadowColor = [UIColor blackColor].CGColor;
                btn.layer.shadowOpacity = 0.2;
                btn.layer.shadowOffset = CGSizeMake(0, 1);
                btn.layer.shadowRadius = 2;
            }];
        }];
    }];
}

- (void)removeSubButton:(UIButton *)btn
{
    [UIView animateWithDuration:0.2f animations:^{
        btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25f animations:^{
            [self scaleSingleButton:btn];
        } completion:^(BOOL finished) {
            [btn removeFromSuperview];
            
            if(btn == [_buttons lastObject])
                [self removeAllExceptButton];
        }];
    }];
}

- (void)scaleSingleButton:(UIButton *)btn
{
    btn.transform = CGAffineTransformMakeScale(0.001, 0.001);
    btn.alpha = 0;
    btn.center = self.superview.center;
}



//  remove view
- (void)removeAllExceptButton
{
    [_tapView removeFromSuperview];
    _tapView = nil;
    [self removeFromSuperview];
}

- (void)removeCurrentView
{
    for (UIButton *btn in _buttons) {
        [btn removeFromSuperview];
    }
    [self removeAllExceptButton];
}


#pragma mark - property
- (NSArray *)backgroundColors
{
    if (_backgroundColors)
        return _backgroundColors;
    
    _backgroundColors = @[ @0x3c5a9a,
                           @0x3083be,
                           @0xd95433,
                           @0xbb54b5,
                           @0xab54b4 ];
    return _backgroundColors;
}

- (CGFloat)spacingFromSender
{
    if (_spacingFromSender)
        return _spacingFromSender;
    
    _spacingFromSender = 50;
    return _spacingFromSender;
}

- (CGFloat)btnRadius
{
    if (_btnRadius)
        return _btnRadius;
    
    _btnRadius = 50;
    return _btnRadius;
}

- (NSInteger)count
{
    if (_count)
        return _count;
    
    _count = 4;
    return _count;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
