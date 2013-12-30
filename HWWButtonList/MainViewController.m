//
//  MainViewController.m
//  HWWButtonList
//
//  Created by icreative-mini on 13-12-24.
//  Copyright (c) 2013年 icreative-mini. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showButtonList:(UIButton *)sender {
    ButtonList *list = [[ButtonList alloc] initWithPoint:sender.center inView:self.view];
//    list.count = 4;
//    list.titles = @[ @"K",
//                     @"O",
//                     @"B",
//                     @"E" ];
//    list.backgroundColors = @[ @0x3c5a9a,
//                               @0x3083be,
//                               @0xd95433,
//                               @0xbb54b5 ];
//    list.spacingFromSender = 60;
//    list.btnRadius = 50;

    list.delegate = self;
    [list show];
}

#pragma mark - HWWButtonListDelegate
- (void)didSelectButton:(UIButton *)btn atIndex:(NSInteger)index
{
    NSLog(@"didSelectButton %d",btn.tag);
}

@end
