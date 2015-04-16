#import "AGTCoreDataStack.h"
#import "DTCBook.h"
#import "DTCHelpers.h"
#import "DTCPdf.h"
#import "DTCAuthor.h"
#import "DTCPhoto.h"
#import "DTCTag.h"
#import "DTCCoreDataQueries.h"

@interface DTCBook ()

// Private interface goes here.

@end

@implementation DTCBook

#pragma mark - Properties inherited from base class
+(NSArray *) observableKeys{
    // Observo las propiedades de las relaciones
    return @[DTCBookRelationships.annotations, DTCBookRelationships.pdf, DTCBookRelationships.photo, DTCBookRelationships.tags];
}


#pragma mark - Factory inits

+(instancetype) bookWithDictionary:(NSDictionary *) dict
                             stack:(AGTCoreDataStack *) stack{


    DTCBook *book = [NSEntityDescription insertNewObjectForEntityForName:[DTCBook entityName]
                                                  inManagedObjectContext:stack.context];
    
    // Propiedades obligatorias
    NSArray *arrayOfAuthors = [DTCHelpers arrayOfItemsFromString:[dict objectForKey:@"authors"] separatedBy:@", "];
    NSArray *arrayOfTags = [DTCHelpers arrayOfItemsFromString:[dict objectForKey:@"tags"] separatedBy:@", "];
    
    book.title = [dict objectForKey:@"title"];
    
    // Añadimos tags al libro, creando la etiqueta sólo si no existe
    for (NSString *tag in arrayOfTags) {
        // Compruebo si existe el tag
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",tag];
        NSArray *results = [DTCCoreDataQueries resultsFromFetchForEntityName:[DTCTag entityName]
                                                                    sortedBy:DTCTagAttributes.name
                                                                   ascending:YES
                                                               withPredicate:predicate
                                                                     inStack:stack];
         
        if ([results count]!=0) {
            // Añadimos la existente
            [book addTagsObject:[results lastObject]];
        }
        else{
            [book addTagsObject:[DTCTag tagWithName:tag stack:stack]];
        }
    }
    
    // Añadimos autores al libro, creando el autor sólo si no existe
    for (NSString *author in arrayOfAuthors) {
        // Compruebo si existe el autor
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",author];
        NSArray *results = [DTCCoreDataQueries resultsFromFetchForEntityName:[DTCAuthor entityName]
                                                                    sortedBy:DTCAuthorAttributes.name
                                                                   ascending:YES
                                                               withPredicate:predicate
                                                                     inStack:stack];
        
        if ([results count]!=0) {
            // Añadimos la existente
            [book addAuthorsObject:[results lastObject]];
        }
        else{
            [book addAuthorsObject:[DTCAuthor authorWithName:author stack:stack]];
        }
    }
    
    
    book.pdf = [DTCPdf pdfWithURL:[NSURL URLWithString:[dict objectForKey:@"pdf_url"]]
                          stack:stack];
    book.photo = [DTCPhoto photoWithImage:[UIImage imageNamed:@"noimageThumb.png"]
                                 imageURL:[NSURL URLWithString:[dict objectForKey:@"image_url"]]
                                  stack:stack];
    return book;
}


#pragma mark - Utils
// TRY TO IMPLEMENT A GENERIC METHOD FOR THESE TWO

// Return the author(s) of a book in a string
-(NSString *) stringOfAuthors{
    
    NSMutableString *stringOfAuthors = [[NSMutableString alloc]init];
    for (DTCAuthor *author in self.authors) {
        [stringOfAuthors appendString:author.name];
        [stringOfAuthors appendString:@", "];
    }
    [stringOfAuthors deleteCharactersInRange:NSMakeRange([stringOfAuthors length]-2,2)];
    return stringOfAuthors;
}


// Return the tag(s) of a book in a string
-(NSString *) stringOfTags{

    NSMutableString *stringOfTags = [[NSMutableString alloc]init];
    for (DTCTag *tag in self.tags) {
        [stringOfTags appendString:tag.name];
        [stringOfTags appendString:@", "];
    }
    [stringOfTags deleteCharactersInRange:NSMakeRange([stringOfTags length] -2 ,2)];
    return stringOfTags;
}


-(BOOL) isFavorite{
    // Un libro será favorito si tiene la tag "favorite"
    
    if ([self.tags.allObjects containsObject:@"favorite"]){
        return YES;
    }
    return NO;
}

-(void) toggleFavorite:(BOOL) favorite{
    /*
    if (favorite) {
        if (![self.tags containsObject:@"favorite"]) {
            // No existe aún la etiqueta favorito en la BD
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = favorite"];
            NSArray *results = [DTCCoreDataQueries resultsFromFetchForEntityName:[DTCTag entityName]
                                                                        sortedBy:DTCTagAttributes.name
                                                                       ascending:YES
                                                                   withPredicate:predicate
                                                                         inStack:stack];
        }
    }
    else{
        // Pasa a no favorito
        if ([self.tags containsObject:@"favorite"]) {
            self removeTagsObject:[DTCTag tagWithName:<#(NSString *)#> stack:<#(AGTCoreDataStack *)#>];
        }
    }
     */
}




#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    // Con cualquier cambio en las propiedades observables
    // de la anotación, cambio la fecha de modificación
    
}

@end
