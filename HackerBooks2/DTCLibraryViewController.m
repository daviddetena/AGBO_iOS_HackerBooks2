//
//  DTCLibraryViewController.m
//  HackerBooks2
//
//  Created by David de Tena on 16/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

#import "DTCLibraryViewController.h"
#import "DTCBookViewController.h"
#import "DTCBook.h"
#import "DTCHelpers.h"
#import "DTCPhoto.h"
#import "DTCTag.h"
#import "Settings.h"

@interface DTCLibraryViewController ()

@end

@implementation DTCLibraryViewController



#pragma mark - View Lifecycle
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"HackerBooks";
}


#pragma mark - Utils
- (DTCBook *) bookAtIndexPath:(NSIndexPath *) indexPath{
    
    DTCTag *tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];
    DTCBook *book = [[tag.books allObjects] objectAtIndex:indexPath.row];
    
    return book;
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
    cell.detailTextLabel.text = [book stringOfAuthors];
    
    
    // Devolver celda
    return cell;
}


#pragma mark - TableView Delegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Obtenemos libro seleccionado
    DTCBook *book = [self bookAtIndexPath:indexPath];
    
    // Guardamos en NSUserDefaults el id de este libro como el último seleccionado
    [self saveLastSelectedBook:book];
    
    // Lo mostramos en un push view controller
    DTCBookViewController *bookVC = [[DTCBookViewController alloc]initWithModel:book];
    [self.navigationController pushViewController:bookVC animated:YES];
}



#pragma mark - NSUserDefaults
-(void) saveLastSelectedBook:(DTCBook *) book{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:book.archiveURIRepresentation forKey:LAST_SELECTED_BOOK];
    [defaults synchronize];
}

@end
