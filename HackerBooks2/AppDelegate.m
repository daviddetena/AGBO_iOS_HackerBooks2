//
//  AppDelegate.m
//  HackerBooks2
//
//  Created by David de Tena on 14/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

#import "AppDelegate.h"
#import "AGTCoreDataStack.h"
#import "DTCBook.h"
#import "DTCAnnotation.h"
#import "Settings.h"
#import "DTCLibraryViewController.h"
#import "UIViewController+Navigation.h"
@import CoreData;

@interface AppDelegate ()
@property (strong,nonatomic) AGTCoreDataStack *stack;
@end

@implementation AppDelegate

#pragma mark - App Lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Init CoreData stack with the model name
    self.stack = [AGTCoreDataStack coreDataStackWithModelName:@"Model"];
    
    [self configureApp];
    
    //[self trastearConDatos];
    
    //[self autoSave];
    
    // FetchRequest para búsqueda de libros, ordenados por nombre. En lotes de 20
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[DTCBook entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:DTCBookAttributes.title ascending:YES]];
    req.fetchBatchSize = 20;
    
    
    NSFetchedResultsController *results = [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                                              managedObjectContext:self.stack.context
                                                                                sectionNameKeyPath:nil
                                                                                         cacheName:nil];
    
    
    // Controlador de tabla de libros con NSFetchedResultsController
    DTCLibraryViewController *libraryVC = [[DTCLibraryViewController alloc] initWithFetchedResultsController:results
                                                                                                     style:UITableViewStylePlain];
    
    // Controlador raíz: nuestra tabla embebida en un navigation controller
    self.window.rootViewController = [libraryVC wrappedInNavigation];
    
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [self save];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self save];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // It's too late to save
    NSLog(@"Adiós, mundo cruel");
}


#pragma mark - App setup
-(void) configureApp{

    [self configureModelForFirstLaunch];
    
    /*
    // Combrobamos si es la primera vez que se lanza la aplicación
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:LAST_SELECTED_BOOK]) {
        // Descargamos JSON
        [self configureModelForFirstLaunch];
        
        // Cargamos modelo con JSON
        
        // Guardamos modelo en CoreData
    }
    else{
    
        // Leer modelo de CoreData
    }
     */
}

-(void) configureModelForFirstLaunch{

    // Get data from a remote resource via JSON
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:JSON_API_URL]];
    
    // Get response from server dealing with errors
    NSURLResponse *response = [[NSURLResponse alloc]init];
    NSError *error;
    NSData *modelData = [NSURLConnection sendSynchronousRequest:request
                                              returningResponse:&response
                                                          error:&error];
    
    if (modelData!=nil) {
        id JSONObjects = [NSJSONSerialization JSONObjectWithData:modelData
                                                         options:kNilOptions
                                                           error:&error];
        
        
        if (JSONObjects!=nil) {
            if ([JSONObjects isKindOfClass:[NSArray class]]) {
                
                // Guardamos cada libro a partir de su diccionario en el JSON
                for (NSDictionary *dict in JSONObjects) {
                    [DTCBook bookWithDictionary:dict context:self.stack.context];
                }
            }
        }
    }
    else{
        // No data or error
        NSLog(@"Error while downloading JSON from server: %@",error.localizedDescription);
    }
}


#pragma mark - Utils
/*
-(void) trastearConDatos{

    // Creamos libros y anotaciones. Al asignarle un libro a la anotación
    // no necesitamos indicárselo al libro de la forma book.notes = ...
    DTCBook *book2 = [DTCBook bookWithTitle:@"Los Pilares de La Tierra"
                                    context:self.stack.context];
    
    DTCBook *book = [DTCBook bookWithTitle:@"Fray Perico y su borrico"
                                   context:self.stack.context];
    
    DTCBook *book3 = [DTCBook bookWithTitle:@"Cincuenta sombras de Gray"
                                   context:self.stack.context];
    
    
    [DTCAnnotation annotationWithName:@"Primera nota"
                                 book:book
                              context:self.stack.context];
    
    [DTCAnnotation annotationWithName:@"Segunda nota"
                                 book:book
                              context:self.stack.context];
    
    [DTCAnnotation annotationWithName:@"Primera nota otro libro"
                                 book:book2
                              context:self.stack.context];
    
    
    // Buscamos los libros y ponemos un criterio de ordenación (nombre + fecha_mod)
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:[DTCBook entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:DTCBookAttributes.title ascending:YES]];
    // Número de resultados que devolverá en cada lote:20
    req.fetchBatchSize = 20;
    
    //Queremos todas las notas de la libreta exs
    //req.predicate = [NSPredicate predicateWithFormat:@"notebook = %@",exs];
    
    
    
    NSArray *results = [self.stack
                        executeFetchRequest:req
                        errorBlock:^(NSError *error) {
                            NSLog(@"Error al buscar! %@",error);
                        }];
    NSLog(@"Notas: %@",results);
    
    //NSLog(@"%@",book3);
    
    // Eliminamos libro
    //[self.stack.context deleteObject:book];
    
    
    // Guardar
    [self save];
}
*/
-(void) save{
    [self.stack saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al guardar: %@",error.description);
    }];
}

-(void) autoSave{
    if (AUTO_SAVE) {
        NSLog(@"Autoguardando...");
        [self save];
        
        [self performSelector:@selector(autoSave)
                   withObject:nil
                   afterDelay:AUTO_SAVE_DELAY_IN_SECONDS];
    }    
}


@end
