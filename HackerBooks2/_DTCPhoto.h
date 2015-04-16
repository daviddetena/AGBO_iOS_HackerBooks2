// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DTCPhoto.h instead.

@import CoreData;
#import "DTCHackerBooksBaseClass.h"

extern const struct DTCPhotoAttributes {
	__unsafe_unretained NSString *photoData;
	__unsafe_unretained NSString *url;
} DTCPhotoAttributes;

extern const struct DTCPhotoRelationships {
	__unsafe_unretained NSString *annotations;
	__unsafe_unretained NSString *book;
} DTCPhotoRelationships;

@class DTCAnnotation;
@class DTCBook;

@interface DTCPhotoID : NSManagedObjectID {}
@end

@interface _DTCPhoto : DTCHackerBooksBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) DTCPhotoID* objectID;

@property (nonatomic, strong) NSData* photoData;

//- (BOOL)validatePhotoData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* url;

//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *annotations;

- (NSMutableSet*)annotationsSet;

@property (nonatomic, strong) DTCBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@end

@interface _DTCPhoto (AnnotationsCoreDataGeneratedAccessors)
- (void)addAnnotations:(NSSet*)value_;
- (void)removeAnnotations:(NSSet*)value_;
- (void)addAnnotationsObject:(DTCAnnotation*)value_;
- (void)removeAnnotationsObject:(DTCAnnotation*)value_;

@end

@interface _DTCPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePhotoData;
- (void)setPrimitivePhotoData:(NSData*)value;

- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;

- (NSMutableSet*)primitiveAnnotations;
- (void)setPrimitiveAnnotations:(NSMutableSet*)value;

- (DTCBook*)primitiveBook;
- (void)setPrimitiveBook:(DTCBook*)value;

@end
