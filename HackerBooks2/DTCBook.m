#import "DTCBook.h"
#import "DTCHelpers.h"
#import "DTCPdf.h"
#import "DTCAuthor.h"
#import "DTCPhoto.h"
#import "DTCTag.h"

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

+(instancetype) bookWithTitle:(NSString *) title
                      context:(NSManagedObjectContext *) context{

    // Configuramos libro con propiedades obligatorias
    DTCBook *book = [NSEntityDescription insertNewObjectForEntityForName:[DTCBook entityName]
                                                  inManagedObjectContext:context];
    book.title = title;
    [book addTagsObject:[DTCTag tagWithName:@"Literatura"
                                    context:context]];
    [book addAuthorsObject:[DTCAuthor authorWithName:@"Alfredo Landa"
                                             context:context]];
    book.pdf = [DTCPdf pdfWithURL:[NSURL URLWithString:@"http://www.marca.com"]
                          context:context];
    book.photo = [DTCPhoto photoWithImage:[UIImage imageNamed:@"noimageThumb.png"]
                                 imageURL:[NSURL URLWithString:@"www.marca.com"]
                                  context:context];
    return book;
}


+(instancetype) bookWithDictionary: (NSDictionary *) dict
                           context:(NSManagedObjectContext *) context{

    DTCBook *book = [NSEntityDescription insertNewObjectForEntityForName:[DTCBook entityName]
                                                  inManagedObjectContext:context];
    
    // SACAR LOS DATOS DEL DICCIONARIO Y ASIGNARSELOS
    book.title = [dict objectForKey:@"title"];
    
    
    // Un libro debe tener una foto, aunque sea vacía. Inicialmente, la imagen será "Sin foto"
    //book.photo = [DTCPhoto photoWithImage:[UIImage imageNamed:@"noimageThumb.png"] context:context];
    
    // Un libro debe tener un pdf, aunque esté vacío inicialmente
    //book.pdf = [DTCPdf insertInManagedObjectContext:context];
    
    /*
    NSArray *arrayOfAuthors = [DTCHelpers extractItemsFromString:[dict objectForKey:@"authors"] separatedBy:@", "];
    NSArray *arrayOfTags = [DTCHelpers extractItemsFromString:[dict objectForKey:@"tags"] separatedBy:@", "];
    
    book.pdf = [NSEntityDescription insertNewObjectForEntityForName:@"Pdf" inManagedObjectContext:context];
    book.pdf.url = [dict objectForKey:@"pdf_url"];
    
    for (NSString *author in arrayOfAuthors) {
        DTCAuthor *author = [NSEntityDescription insertNewObjectForEntityForName:@"Author" inManagedObjectContext:context];
        [book addAuthorsObject:author];
    }
     */
    return book;
}

#pragma mark - Utils
-(BOOL) isFavorite{
    // Un libro será favorito si tiene la tag "favorite"
    
    if ([self.tags.allObjects containsObject:@"favorite"]){
        return YES;
    }
    return NO;
}

-(void) toggleFavorite{
//    
//    if ([self.tags.allObjects containsObject:@"favorite"]) {
//        self addTagsObject:[DTCTag tagWithName:@"favorite" context:];
//    }
//    
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
