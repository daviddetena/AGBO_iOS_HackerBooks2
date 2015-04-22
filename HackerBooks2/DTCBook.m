#import "AGTCoreDataStack.h"
#import "DTCBook.h"
#import "DTCHelpers.h"
#import "DTCPdf.h"
#import "DTCAuthor.h"
#import "DTCPhoto.h"
#import "DTCTag.h"
#import "DTCCoreDataQueries.h"

/* JSON Properties */
#define TITLE @"title"
#define AUTHORS @"authors"
#define IMAGE_URL @"image_url"
#define PDF_URL @"pdf_url"
#define TAGS @"tags"
#define FAVORITE @"Favorite"

@interface DTCBook ()

// Private interface goes here.

@end

@implementation DTCBook

#pragma mark - Properties inherited from base class
+(NSArray *) observableKeys{
    // Observo las propiedades de las relaciones
    return @[DTCBookRelationships.annotations, @"pdf.pdfData", @"photo.photoData", DTCBookRelationships.tags];
}


#pragma mark - Factory inits

+(instancetype) bookWithDictionary:(NSDictionary *) dict
                             stack:(AGTCoreDataStack *) stack{


    DTCBook *book = [NSEntityDescription insertNewObjectForEntityForName:[DTCBook entityName]
                                                  inManagedObjectContext:stack.context];
    
    // Propiedades obligatorias
    NSArray *arrayOfAuthors = [DTCHelpers arrayOfItemsFromString:[dict objectForKey:AUTHORS] separatedBy:@", "];
    NSArray *arrayOfTags = [DTCHelpers arrayOfItemsFromString:[dict objectForKey:TAGS] separatedBy:@", "];
    
    book.title = [dict objectForKey:TITLE];
    
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
            // Añadimos existente
            [book addAuthorsObject:[results lastObject]];
        }
        else{
            [book addAuthorsObject:[DTCAuthor authorWithName:author stack:stack]];
        }
    }
    
    
    book.pdf = [DTCPdf pdfWithURL:[NSURL URLWithString:[dict objectForKey:PDF_URL]]
                            stack:stack];
    book.photo = [DTCPhoto photoForBookWithURL:[NSURL URLWithString:[dict objectForKey:IMAGE_URL]]
                                  defaultImage:[UIImage imageNamed:@"emptyBookCover.png"]
                                         stack:stack];
    
    return book;
}


+(instancetype) bookWithArchivedURIRepresentation:(NSData *) archivedURI
                                            stack:(AGTCoreDataStack *) stack{

    NSURL *uri = [NSKeyedUnarchiver unarchiveObjectWithData:archivedURI];
    if (uri == nil) {
        return nil;
    }
    
    NSManagedObjectID *nid = [stack.context.persistentStoreCoordinator
                              managedObjectIDForURIRepresentation:uri];
    
    if (nid == nil) {
        return nil;
    }
    
    NSManagedObject *obj = [stack.context objectWithID:nid];
    if (obj.isFault) {
        // Got it !
        return (DTCBook *) obj;
    }
    else{
        // Might not exist anymore. Let's fetch it!
        NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:obj.entity.name];
        req.predicate = [NSPredicate predicateWithFormat:@"SELF = %@",obj];
        
        NSError *error;
        NSArray *res = [stack.context executeFetchRequest:req
                                                    error:&error];
        
        if (res == nil) {
            return nil;
        }
        else{
            return [res lastObject];
        }
    }
}



#pragma mark - Utils
// TRY TO IMPLEMENT A GENERIC METHOD FOR THESE TWO

// Return the author(s) of a book in a string
-(NSString *) sortedListOfAuthors{
    
    // Standarize case, sort, join with comma
    NSArray *all = [self.authors allObjects];
    NSMutableArray *authors = [NSMutableArray arrayWithCapacity:all.count];
    for (DTCAuthor *author in all) {
        [authors addObject:author.name];
    }
    NSString *contat = [authors componentsJoinedByString:@", "];
    return contat;
}


// Return the tag(s) of a book in a string
// Return the author(s) of a book in a string
-(NSString *) sortedListOfTags{
    
    // Standarize case, sort, join with comma
    NSArray *all = [self.tags allObjects];
    NSMutableArray *tags = [NSMutableArray arrayWithCapacity:all.count];
    for (DTCTag *tag in all) {
        [tags addObject:tag.name];
    }
    NSString *contat = [tags componentsJoinedByString:@", "];
    return contat;
}


// Returns an NSData with the serialized URI representation of the objectID.
// Ready to save it in a NSUserDefaults, for example
-(NSData *) archiveURIRepresentation{
    NSURL *uri = self.objectID.URIRepresentation;
    return [NSKeyedArchiver archivedDataWithRootObject:uri];
}



-(BOOL) isFavorite{
    // Un libro será favorito si tiene la tag "favorite"
    
    if ([self.tags.allObjects containsObject:FAVORITE]){
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
    
    // COMPROBAR FAVORITO
    
}

@end
