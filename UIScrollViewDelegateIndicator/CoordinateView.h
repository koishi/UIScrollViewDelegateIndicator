//
//  CoordinateView.h
//  UIScrollViewDelegateExample
//
//  Created by Naoyuki Takura on 2014/04/29.
//  Copyright (c) 2014年 Naoyuki Takura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoordinateView : UIView<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) UITableView *tableView;
@property (weak, nonatomic) UIViewController *parentVC;
@end
