//
//  DTCBookViewController.m
//  HackerBooks2
//
//  Created by David de Tena on 16/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

#import "DTCBookViewController.h"
#import "DTCBook.h"
#import "DTCPhoto.h"
#import "DTCAnnotation.h"
#import "Settings.h"

@interface DTCBookViewController ()

@end

@implementation DTCBookViewController

#pragma mark - Init
-(id) initWithModel:(DTCBook *) model{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = model;
        self.title = model.title;
    }
    return self;
}

#pragma mark - View lifecycle

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Make sure the view not to use the whole screen when embeded in combiners
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Init display mode button on the left in Navigation Controller
    self.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    
    // Sync view with model
    [self syncViewWithModel];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // Sync model with view
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Utils
-(void) syncViewWithModel{
    self.titleLabel.text = self.model.title;
    //self.authorLabel.text = [self.model stringOfAuthors];
    //self.tagLabel.text = [self.model stringOfTags];
    
    // CARGAR LA IMAGEN EN SEGUNDO PLANO AL DESCARGARSE
    if ([self.model.annotations count]==0) {
        self.annotationLabel.text = @"No notes for this book";
    }
    else{
        self.annotationLabel.text = [NSString stringWithFormat:@"%lu notes for this book", (unsigned long)[self.model.annotations count]];
    }
    
    self.photoView.image = self.model.photo.image;
}


#pragma mark - UISplitViewControllerDelegate
-(void) splitViewController:(UISplitViewController *)svc
    willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{

    if (displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
        // Table hidden => show button on the left in navigation
        self.navigationItem.leftBarButtonItem = svc.displayModeButtonItem;
    }
    else{
        // Table visible => hide button in navigation
        self.navigationItem.leftBarButtonItem = nil;
    }
}


@end
