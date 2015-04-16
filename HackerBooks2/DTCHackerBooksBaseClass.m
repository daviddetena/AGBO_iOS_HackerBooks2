//
//  DTCHackerBooksBaseClass.m
//  HackerBooks2
//
//  Created by David de Tena on 15/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

#import "DTCHackerBooksBaseClass.h"

@implementation DTCHackerBooksBaseClass

#pragma mark - Class methods

// Inicialmente vacío
+(NSArray *) observableKeys{
    return @[];
}

#pragma mark - Lifecycle

-(void)awakeFromInsert{
    // Sólo una vez en la vida del objeto
    [super awakeFromInsert];
    
    // KVO (alta en notificaciones de cambio)
    [self setupKVO];
}


-(void)awakeFromFetch{
    // n-veces a lo largo de la vida del objeto. Viene de un fault o
    // se recupera de la base de datos
    [super awakeFromFetch];
    
    // KVO (alta en notificaciones de cambio)
    [self setupKVO];
}

-(void)willTurnIntoFault{
    // Cuando el objeto se vacía convirtiéndose en un fault.
    [super willTurnIntoFault];
    
    // Nos damos de baja en todas las notificaciones
    [self tearDownKVO];
}

#pragma mark - KVO
-(void)setupKVO{
    
    // Añadimos observador por cada una de las propiedades deseadas
    for (NSString *key in [[self class] observableKeys]) {
        [self addObserver:self
               forKeyPath:key
                  options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                  context:NULL];
    }
}

-(void)tearDownKVO{
    
    // Me doy de baja de todas las notificaciones
    for (NSString *key in [[self class] observableKeys]) {
        [self removeObserver:self forKeyPath:key];
    }
}


@end
