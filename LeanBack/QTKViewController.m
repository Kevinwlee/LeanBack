//
//  QTKViewController.m
//  LeanBack
//
//  Created by Kevin Lee on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QTKViewController.h"
#import "QTKDetailViewController.h"
#import "QTKListViewController.h"

@interface QTKViewController ()
@property (nonatomic, strong) QTKDetailViewController *detailViewController;
@property (nonatomic, strong) QTKListViewController *listViewController;
@end

@implementation QTKViewController
@synthesize detailViewController, listViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listViewController = [[QTKListViewController alloc] initWithNibName:@"QTKListViewController" bundle:nil];
    [self addChildViewController:self.listViewController];
    [self.view addSubview:self.listViewController.view];
    [self.listViewController didMoveToParentViewController:self];
    
    self.detailViewController = [[QTKDetailViewController alloc] initWithNibName:@"QTKDetailViewController" bundle:nil];
}

- (void)viewDidUnload {
    [super viewDidUnload];

    [self setDetailViewController:nil];
    [self setDetailViewController:nil];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


- (void)dismissChildViewController:(UIViewController *)child {    
    [self addChildViewController:self.listViewController];
    [self.detailViewController willMoveToParentViewController:nil];
    
    [UIView animateWithDuration:.3 animations:^{
        CGRect detailFrame = self.view.bounds;
        detailFrame.origin.y = self.view.bounds.size.height;
        self.detailViewController.view.frame = detailFrame;                            
    }];
    
    [UIView animateWithDuration:.5 delay:.1 options:UIViewAnimationCurveEaseInOut animations:^{
        CGRect frame = self.listViewController.view.frame;
        frame.size.width +=100;
        frame.size.height +=100;
        frame.origin.x -=50;
        frame.origin.y -=50;
        self.listViewController.view.frame = frame;
    } completion:^(BOOL finished) {
        [self.listViewController didMoveToParentViewController:self];

        [self.detailViewController removeFromParentViewController];
        [self.detailViewController.view removeFromSuperview];
    }];

}
     
- (void)presentChildViewController {
    [self addChildViewController:self.detailViewController];
    __block CGRect detailFrame = self.view.bounds;
    detailFrame.origin.y = self.view.bounds.size.height;
    [self.view addSubview:self.detailViewController.view];
    self.detailViewController.view.frame = detailFrame;

    [self.listViewController willMoveToParentViewController:nil];

    [UIView animateWithDuration:.5 animations:^{
        CGRect frame = self.listViewController.view.frame;
        frame.size.width -=100;
        frame.size.height -=100;
        frame.origin.x +=50;
        frame.origin.y +=50;
        self.listViewController.view.frame = frame;        
    }];
    
    [UIView animateWithDuration:.3 delay:.25 options:UIViewAnimationCurveEaseInOut animations:^{
        detailFrame.origin.y = 0;
        self.detailViewController.view.frame = detailFrame;                
    } completion:^(BOOL finished) {
        [self.detailViewController didMoveToParentViewController:self];
        
        [self.listViewController removeFromParentViewController];
    }];
    
}
@end
