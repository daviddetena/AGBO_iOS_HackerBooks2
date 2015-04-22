//
//  DTCSimplePDFViewController.h
//  HackerBooks2
//
//  Created by David de Tena on 21/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

@import UIKit;
@class DTCBook;

@interface DTCSimplePDFViewController : UIViewController<UIWebViewDelegate,NSURLSessionDownloadDelegate>


#pragma mark - Properties
@property (strong,nonatomic) DTCBook *model;
@property (weak, nonatomic) IBOutlet UIWebView *browser;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;


#pragma mark - Init
-(id) initWithModel:(DTCBook *) model;


#pragma mark - Actions



@end
