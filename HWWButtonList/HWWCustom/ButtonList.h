//
//  ButtonList.h
//  HWWButtonList
//
//  Created by icreative-mini on 13-12-24.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HWWButtonListDelegate <NSObject>

- (void)didSelectButton:(UIButton *)btn atIndex:(NSInteger)index;

@end

@interface ButtonList : UIView
{
    UIView *_tapView;
    CGPoint _centerP;
    NSMutableArray *_buttons;
}

@property (nonatomic) CGFloat spacingFromSender;    ///< default 50
@property (nonatomic) CGFloat btnRadius;            ///< default 50
@property (nonatomic, strong) NSArray *titles;         ///<
@property (nonatomic, strong) NSArray *colors;         ///< 二进制数组

@property (nonatomic,weak) id<HWWButtonListDelegate> delegate;

- (id)initWithPoint:(CGPoint)point inView:(UIView *)inView;

- (void)show;

@end
