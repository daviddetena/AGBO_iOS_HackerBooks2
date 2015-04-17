//
//  DTCBookViewController.h
//  HackerBooks2
//
//  Created by David de Tena on 16/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

@import UIKit;
@class DTCBook;

@interface DTCBookViewController : UIViewController<UISplitViewControllerDelegate>

#pragma mark - Properties
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *annotationLabel;
@property (strong,nonatomic) DTCBook *model;

#pragma mark - Init
-(id) initWithModel: (DTCBook *) model;


#pragma mark - Methods

@end
