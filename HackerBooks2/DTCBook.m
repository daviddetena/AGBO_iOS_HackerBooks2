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
    
    // Propiedades obligatorias
    NSArray *arrayOfAuthors = [DTCHelpers arrayOfItemsFromString:[dict objectForKey:@"authors"] separatedBy:@", "];
    NSArray *arrayOfTags = [DTCHelpers arrayOfItemsFromString:[dict objectForKey:@"tags"] separatedBy:@", "];
    
    book.title = [dict objectForKey:@"title"];
    
    for (NSString *author in arrayOfAuthors) {
        [book addAuthorsObject:[DTCAuthor authorWithName:author context:context]];
    }
    
    for (NSString *tag in arrayOfTags) {
        [book addTagsObject:[DTCTag tagWithName:tag context:context]];
    }
    
    book.pdf = [DTCPdf pdfWithURL:[NSURL URLWithString:[dict objectForKey:@"pdf_url"]]
                          context:context];
    book.photo = [DTCPhoto photoWithImage:[UIImage imageNamed:@"noimageThumb.png"]
                                 imageURL:[NSURL URLWithString:[dict objectForKey:@"image_url"]]
                                  context:context];
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
