// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DTCTag.h instead.

@import CoreData;
#import "DTCHackerBooksBaseClass.h"

extern const struct DTCTagAttributes {
	__unsafe_unretained NSString *name;
} DTCTagAttributes;

extern const struct DTCTagRelationships {
	__unsafe_unretained NSString *books;
} DTCTagRelationships;

@class DTCBook;

@interface DTCTagID : NSManagedObjectID {}
@end

@interface _DTCTag : DTCHackerBooksBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) DTCTagID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *books;

- (NSMutableSet*)booksSet;

@end

@interface _DTCTag (BooksCoreDataGeneratedAccessors)
- (void)addBooks:(NSSet*)value_;
- (void)removeBooks:(NSSet*)value_;
- (void)addBooksObject:(DTCBook*)value_;
- (void)removeBooksObject:(DTCBook*)value_;

@end

@interface _DTCTag (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveBooks;
- (void)setPrimitiveBooks:(NSMutableSet*)value;

@end
