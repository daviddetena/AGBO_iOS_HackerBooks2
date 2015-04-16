//
//  UIViewController+Navigation.h
//  HackerBooks2
//
//  Created by David de Tena on 16/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Navigation)

#pragma mark - Methods
-(UINavigationController *) wrappedInNavigation;

@end
