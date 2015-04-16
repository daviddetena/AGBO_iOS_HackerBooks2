#import "_DTCBook.h"

@interface DTCBook : _DTCBook {}


#pragma mark - Factory inits

// HAY QUE CREAR INICIALIZADORES DE CONVENIENCIA: CON DICCIONARIO + CONTEXT
// Y CON LAS PROPIEDADES + CONTEXT

+(instancetype) bookWithTitle:(NSString *)title
                      context:(NSManagedObjectContext *) context;

+(instancetype) bookWithDictionary: (NSDictionary *) dict
                           context:(NSManagedObjectContext *) context;

@end
