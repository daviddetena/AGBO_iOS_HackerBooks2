//
//  DTCLibraryViewController.m
//  HackerBooks2
//
//  Created by David de Tena on 16/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

#import "DTCCoreDataQueries.h"
#import "DTCLibraryViewController.h"
#import "DTCBookViewController.h"
#import "DTCBook.h"
#import "DTCHelpers.h"
#import "DTCPhoto.h"
#import "DTCTag.h"
#import "Settings.h"

@interface DTCLibraryViewController ()

@property (strong,nonatomic) AGTCoreDataStack *stack;
@property (strong,nonatomic) NSArray *completeList;
@property (strong,nonatomic) NSArray *filteredList;
@property (strong,nonatomic) NSFetchRequest *searchFetchRequest;
@property (strong,nonatomic) UISearchController *searchController;

@end

@implementation DTCLibraryViewController

#pragma mark - Init


-(id) initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController
                                 stack:(AGTCoreDataStack *) stack
                                 style:(UITableViewStyle)aStyle{

    if (self = [super initWithFetchedResultsController:aFetchedResultsController
                                                 style:aStyle]) {
        
        self.stack = stack;
        self.searchFetchRequest = aFetchedResultsController.fetchRequest;
        
//        self.filteredList = [NSArray arrayWithArray:aFetchedResultsController.fetchedObjects];
//        self.completeList = [NSArray arrayWithArray:aFetchedResultsController.fetchedObjects];
    }
    return self;
    
}

#pragma mark - View Lifecycle

-(void) viewDidLoad{
    [super viewDidLoad];
    
    /*
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.scopeButtonTitles = @[@"Tag"];
    
    // Add the search controller to the table view header
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    // The search view covers the table when active, so we make the TVC define
    // the presentation context
    self.definesPresentationContext = YES;
     */
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"HackerBooks";
}



#pragma mark - TableView DataSource
-(UITableViewCell *) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    // Libro actual según el tag
    DTCBook *book = [self bookAtIndexPath:indexPath];
    
    // Crear celda
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        // No hay celda que aprovechar. Crear de cero
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellID];
    }

    cell.textLabel.text = book.title;
    cell.imageView.image = book.photo.image;
    cell.detailTextLabel.text = [book sortedListOfAuthors];
    
    // Devolver celda
    return cell;
}


#pragma mark - Utils
- (DTCBook *) bookAtIndexPath:(NSIndexPath *) indexPath{
    
    DTCTag *tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];
    DTCBook *book = [[tag.books allObjects] objectAtIndex:indexPath.row];
    
    return book;
}


/*
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{    
    return [self.filteredList count];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DTCTag *tag = [self.filteredList objectAtIndex:section];
    
    return [[tag.books allObjects]count];
}
*/



#pragma mark - TableView Delegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"He pulsado en una celda");
    
    // Obtenemos libro seleccionado
    DTCBook *book = [self bookAtIndexPath:indexPath];
    
    // Avisamos al bookVC de que ha cambiado el libro seleccionado
    if ([self.delegate respondsToSelector:@selector(libraryTableViewController:didSelectBook:)]) {
        [self.delegate libraryTableViewController:self didSelectBook:book];
    }
    
    // Guardamos en NSUserDefaults el id de este libro como el último seleccionado
    [self saveLastSelectedBook:book];
}



#pragma mark - NSUserDefaults
-(void) saveLastSelectedBook:(DTCBook *) book{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:book.archiveURIRepresentation forKey:LAST_SELECTED_BOOK];
    [defaults synchronize];
}

/*
#pragma mark - UISearchResultsUpdating
-(void) updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchString = searchController.searchBar.text;
    [self searchForText:searchString scope:searchController.searchBar.selectedScopeButtonIndex];
    [self.tableView reloadData];
}


#pragma mark - UISearchBarDelegate
-(void) searchBar:(UISearchBar *)searchBar
selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{

    [self updateSearchResultsForSearchController:self.searchController];
}

-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"Empiezo a escribir");
    if (searchBar.text.length == 0) {
        // Mostramos todos
        self.filteredList = self.completeList;
    }
    else{
        [self searchForText:searchBar.text scope:searchBar.selectedScopeButtonIndex];
    }
    [self.tableView reloadData];
}

-(void) searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    if (searchBar.text.length == 0) {
        // Mostramos todos
        self.filteredList = self.completeList;
    }
    else{
        [self searchForText:searchBar.text scope:searchBar.selectedScopeButtonIndex];
    }
    [self.tableView reloadData];
}


// Si se pulsa en cancelar, mostramos todos los resultados
-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    if (searchBar.text.length == 0) {
        // Mostramos todos
        self.filteredList = self.completeList;
    }
    else{
        [self searchForText:searchBar.text scope:searchBar.selectedScopeButtonIndex];
    }
    
    [self.tableView reloadData];
}
*/

/*
#pragma mark - Searchs
-(void) searchForText:(NSString *) searchText
                scope:(NSInteger) scope{
    
    // Predicado de búsqueda (por defecto buscamos por título)
    NSString *predicateFormat = @"%K CONTAINS[cd] %@";
    NSString *searchAttribute = @"name";
    
    
    if (scope == 1) {
        // Search by title
        searchAttribute = @"title";
        predicateFormat = @"SELF IN %@,";
    }
    else if (scope == 2){
        // Search by author
        searchAttribute = @"author";
        predicateFormat = ;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateFormat, searchAttribute, searchText];
    self.filteredList = [DTCCoreDataQueries resultsFromFetchForEntityName:[DTCTag entityName]
                                                                 sortedBy:DTCTagAttributes.name
                                                                ascending:YES
                                                            withPredicate:predicate
                                                                  inStack:self.stack];
}

 */
@end
