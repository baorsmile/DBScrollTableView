//
//  ViewController.m
//  DBScrollTableView
//
//  Created by dabao on 2017/10/12.
//  Copyright © 2017年 dabao. All rights reserved.
//

#import "ViewController.h"

#import "TableViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *containerScrollView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIViewController *tableViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.containerScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    TableViewController *tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
    [self addChildViewController:tableViewController];
    [_containerScrollView addSubview:tableViewController.view];
    [tableViewController didMoveToParentViewController:self];
    
    self.tableView = tableViewController.tableView;
    
    self.tableViewController = tableViewController;
    
    [self.tableView addObserver:self forKeyPath:@"contentSize" options:kNilOptions context:NULL];
}

- (void)dealloc
{
    [self.tableView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        self.containerScrollView.contentSize = self.tableView.contentSize;
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.contentOffset = CGPointMake(0, _containerScrollView.contentOffset.y);

    self.tableViewController.view.frame = [self.view convertRect:self.view.bounds toView:_containerScrollView];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view setNeedsLayout];
}


@end
