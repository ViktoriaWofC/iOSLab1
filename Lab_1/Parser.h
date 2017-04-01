//
//  Parser.h
//  Lab_1
//
//  Created by user on 01.04.17.
//  Copyright © 2017 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Parser : NSObject

-(id) init;

-(NSMutableArray *) getMoviesArray : (NSString *) json;
-(NSMutableArray *) getMoviesID:(NSString *)json;
@end

