//
//  CoordinateView.m
//  UIScrollViewDelegateExample
//
//  Created by Naoyuki Takura on 2014/04/29.
//  Copyright (c) 2014年 Naoyuki Takura. All rights reserved.
//

#import "CoordinateView.h"
#import "CallBackIndicator.h"

@interface CoordinateView() {
    __weak IBOutlet CallBackIndicator *didScrollView;
    __weak IBOutlet CallBackIndicator *shouldScrollToTopView;
    __weak IBOutlet CallBackIndicator *didScrollToTopView;
    __weak IBOutlet CallBackIndicator *willBeginDraggingView;
    __weak IBOutlet CallBackIndicator *didEndDraggingView;
    __weak IBOutlet CallBackIndicator *willBeginDeceleratingView;
    __weak IBOutlet CallBackIndicator *didEndDeceleratingView;
}

@property NSMutableArray *nowDisplay;

@end

@implementation CoordinateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [didScrollView showIndicator];
        [didScrollToTopView showIndicator];
        [self setup];
    }
    return self;
}

- (void)setup {
    self.nowDisplay = [NSMutableArray array];
}



#pragma mark - UIScrollViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 500;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewDidScroll. : contentOffset :{%f, %f}", scrollView.contentOffset.x, scrollView.contentOffset.y);

    NSString *logText = [NSString stringWithFormat:@"scrollViewDidScroll :%@", scrollView];
    self.textView.text = logText;
    
    //
    CGRect frame = self.frame;
    frame.origin.y = 200 + scrollView.contentOffset.y;
    self.frame = frame;
    
    [didScrollView highlight];
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewShouldScrollToTop. : contentOffset:{%f, %f}", scrollView.contentOffset.x, scrollView.contentOffset.y);
    [shouldScrollToTopView highlight];
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewDidScrollToTop. : %@", scrollView);
    NSString *logText = [NSString stringWithFormat:@"scrollViewDidScrollToTop. : %@", scrollView];
    self.textView.text = logText;
    
    [didScrollToTopView highlight];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewWillBeginDragging. : %@", scrollView);
    NSString *logText = [NSString stringWithFormat:@"scrollViewWillBeginDragging. : %@", scrollView];
    self.textView.text = logText;
    
    [willBeginDraggingView highlight];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    NSLog(@"scrollViewDidEndDragging. : %@, %d", scrollView, decelerate);
    NSString *logText = [NSString stringWithFormat:@"scrollViewDidEndDragging. : %@", scrollView];
    self.textView.text = logText;

    [didEndDraggingView highlight];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewWillBeginDecelerating. : %@", scrollView);
    NSString *logText = [NSString stringWithFormat:@"scrollViewWillBeginDecelerating. : %@", scrollView];
    self.textView.text = logText;
    
    [willBeginDeceleratingView highlight];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"scrollViewDidEndDecelerating. : %@", scrollView);
    NSString *logText = [NSString stringWithFormat:@"scrollViewDidEndDecelerating. : %@", scrollView];
    self.textView.text = logText;
    
    [didEndDeceleratingView highlight];

    [self playCell: self.tableView];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString *indexPathRow = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    if (![self.nowDisplay containsObject: indexPathRow]) {
        [self.nowDisplay addObject: indexPathRow];
    }
    NSLog(@"表示された %@", self.nowDisplay);
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString *indexPathRow = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    if ([self.nowDisplay containsObject: indexPathRow]) {
        [self.nowDisplay removeObject: indexPathRow];
    }
    NSLog(@"非表示になった %@", self.nowDisplay);
}

- (void)playCell:(UITableView *)tableView
{
    for (NSString *indexString in self.nowDisplay) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[indexString integerValue] inSection:0];
        CGRect cellRect = [tableView rectForRowAtIndexPath:indexPath];
        CGRect cellRectInView = [tableView convertRect:cellRect toView:self.parentVC.navigationController.view];
        NSLog(@"%ld セルの位置 %@", (long)indexPath.row, NSStringFromCGRect(cellRectInView));
    }
}

@end
