#import "DTCTag.h"
#import "DTCBook.h"
#import "AGTCoreDataStack.h"
@import CoreData;

@interface DTCTag ()

@end

@implementation DTCTag


#pragma mark - Properties inherited from base class
+(NSArray *) observableKeys{
    // Observo las propiedades de las relaciones
    return @[DTCTagAttributes.name,DTCTagRelationships.books];
}



#pragma mark - Factory init


+(instancetype) tagWithName:(NSString *) name
                      stack:(AGTCoreDataStack *) stack{

    DTCTag *tag = [NSEntityDescription insertNewObjectForEntityForName:[DTCTag entityName]
                                                inManagedObjectContext:stack.context];
    tag.name = name;
    return tag;
}



#pragma mark - Utils

// Return the author(s) of a book in a string
-(NSString *) stringOfBooks{
    
    NSMutableString *stringOfBooks = [[NSMutableString alloc]init];
    for (DTCBook *book in self.books) {
        [stringOfBooks appendString:book.title];
        [stringOfBooks appendString:@", "];
    }
    [stringOfBooks deleteCharactersInRange:NSMakeRange([stringOfBooks length]-2,2)];
    return stringOfBooks;
}


#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    // Con cualquier cambio en las propiedades observables
    
}

@end
