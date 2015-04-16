//
//  DTCLibraryViewController.m
//  HackerBooks2
//
//  Created by David de Tena on 16/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

#import "DTCLibraryViewController.h"
#import "DTCBook.h"
#import "DTCHelpers.h"
#import "DTCPhoto.h"
#import "DTCTag.h"

@interface DTCLibraryViewController ()

@end

@implementation DTCLibraryViewController



#pragma mark - View Lifecycle
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"HackerBooks";
}



#pragma mark - DataSource
-(UITableViewCell *) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    // Averiguar el tag
    DTCTag *tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];
    DTCBook *book = [[tag.books allObjects] objectAtIndex:indexPath.row];
    
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
    cell.detailTextLabel.text = [book stringOfAuthors];
    
    
    // Devolver celda
    return cell;
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.fetchedResultsController.fetchedObjects count];
}


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DTCTag *tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:section];
    return [[tag.books allObjects]count];
}


#pragma mark - Delegate

@end
