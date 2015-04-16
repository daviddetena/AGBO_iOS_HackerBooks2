// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DTCAuthor.h instead.

@import CoreData;
#import "DTCHackerBooksBaseClass.h"

extern const struct DTCAuthorAttributes {
	__unsafe_unretained NSString *name;
} DTCAuthorAttributes;

extern const struct DTCAuthorRelationships {
	__unsafe_unretained NSString *books;
} DTCAuthorRelationships;

@class DTCBook;

@interface DTCAuthorID : NSManagedObjectID {}
@end

@interface _DTCAuthor : DTCHackerBooksBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) DTCAuthorID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *books;

- (NSMutableSet*)booksSet;

@end

@interface _DTCAuthor (BooksCoreDataGeneratedAccessors)
- (void)addBooks:(NSSet*)value_;
- (void)removeBooks:(NSSet*)value_;
- (void)addBooksObject:(DTCBook*)value_;
- (void)removeBooksObject:(DTCBook*)value_;

@end

@interface _DTCAuthor (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveBooks;
- (void)setPrimitiveBooks:(NSMutableSet*)value;

@end
