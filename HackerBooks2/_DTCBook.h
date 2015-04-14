// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to DTCBook.h instead.

@import CoreData;

extern const struct DTCBookAttributes {
	__unsafe_unretained NSString *title;
} DTCBookAttributes;

extern const struct DTCBookRelationships {
	__unsafe_unretained NSString *annotations;
	__unsafe_unretained NSString *authors;
	__unsafe_unretained NSString *pdf;
	__unsafe_unretained NSString *photo;
	__unsafe_unretained NSString *tags;
} DTCBookRelationships;

@class DTCAnnotation;
@class DTCAuthor;
@class DTCPdf;
@class DTCPhoto;
@class DTCTag;

@interface DTCBookID : NSManagedObjectID {}
@end

@interface _DTCBook : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) DTCBookID* objectID;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *annotations;

- (NSMutableSet*)annotationsSet;

@property (nonatomic, strong) NSSet *authors;

- (NSMutableSet*)authorsSet;

@property (nonatomic, strong) DTCPdf *pdf;

//- (BOOL)validatePdf:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) DTCPhoto *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *tags;

- (NSMutableSet*)tagsSet;

@end

@interface _DTCBook (AnnotationsCoreDataGeneratedAccessors)
- (void)addAnnotations:(NSSet*)value_;
- (void)removeAnnotations:(NSSet*)value_;
- (void)addAnnotationsObject:(DTCAnnotation*)value_;
- (void)removeAnnotationsObject:(DTCAnnotation*)value_;

@end

@interface _DTCBook (AuthorsCoreDataGeneratedAccessors)
- (void)addAuthors:(NSSet*)value_;
- (void)removeAuthors:(NSSet*)value_;
- (void)addAuthorsObject:(DTCAuthor*)value_;
- (void)removeAuthorsObject:(DTCAuthor*)value_;

@end

@interface _DTCBook (TagsCoreDataGeneratedAccessors)
- (void)addTags:(NSSet*)value_;
- (void)removeTags:(NSSet*)value_;
- (void)addTagsObject:(DTCTag*)value_;
- (void)removeTagsObject:(DTCTag*)value_;

@end

@interface _DTCBook (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSMutableSet*)primitiveAnnotations;
- (void)setPrimitiveAnnotations:(NSMutableSet*)value;

- (NSMutableSet*)primitiveAuthors;
- (void)setPrimitiveAuthors:(NSMutableSet*)value;

- (DTCPdf*)primitivePdf;
- (void)setPrimitivePdf:(DTCPdf*)value;

- (DTCPhoto*)primitivePhoto;
- (void)setPrimitivePhoto:(DTCPhoto*)value;

- (NSMutableSet*)primitiveTags;
- (void)setPrimitiveTags:(NSMutableSet*)value;

@end
