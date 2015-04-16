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

    
    // Averiguar el libro
    DTCBook *book = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //DTCTag *tag = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Crear celda
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        // No hay celda que aprovechar. Crear de cero
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellID];
    }
    
    
    // Configurar la celda => sincronizar celda (vista) y libro (modelo)
    /*
    cell.textLabel.text = tag.name;
    cell.detailTextLabel.text = [tag stringOfBooks];
    */
    
    
    cell.textLabel.text = book.title;
    cell.imageView.image = book.photo.image;
    cell.detailTextLabel.text = [book stringOfTags];
    
    
    // Devolver celda
    return cell;
}

@end
