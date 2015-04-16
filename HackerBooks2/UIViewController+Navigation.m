//
//  UIViewController+Navigation.m
//  HackerBooks2
//
//  Created by David de Tena on 16/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

#import "UIViewController+Navigation.h"

@implementation UIViewController (Navigation)

#pragma mark - Methods
-(UINavigationController *) wrappedInNavigation{

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self];
    return nav;
}

@end
