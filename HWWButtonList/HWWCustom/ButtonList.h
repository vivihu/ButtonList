//
//  ButtonList.h
//  HWWButtonList
//
//  Created by icreative-mini on 13-12-24.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonList : UIView
{
//    UIView *_parentView;
    UIView *_tapView;
    CGPoint _centerP;
    NSMutableArray *_buttons;
}

@property (nonatomic) CGFloat spacingFromSender;
@property (nonatomic) CGFloat btnRadius;

- (id)initWithPoint:(CGPoint)point inView:(UIView *)inView;

- (void)show;

@end
