//
//  DTCLibraryViewController.h
//  HackerBooks2
//
//  Created by David de Tena on 16/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

#import "AGTCoreDataTableViewController.h"

@class DTCLibraryViewController;
@class DTCBook;
@class AGTCoreDataStack;

#pragma mark - Custom protocol
@protocol DTCLibraryTableViewControllerDelegate <NSObject>

@optional
// Method implemented by its delegate to update the book model
- (void) libraryTableViewController:(DTCLibraryViewController *) libraryVC
                      didSelectBook:(DTCBook *) aBook;

@end

@interface DTCLibraryViewController : AGTCoreDataTableViewController

#pragma mark - Properties
// The delegate is the DTCBookVC for iPad and the tableVC itself for iPhone
@property (weak,nonatomic) id<DTCLibraryTableViewControllerDelegate> delegate;


#pragma mark - Init

-(id) initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController
                                 stack:(AGTCoreDataStack *) stack
                                 style:(UITableViewStyle)aStyle;


@end
