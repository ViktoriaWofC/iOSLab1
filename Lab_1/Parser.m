//
//  Parser.m
//  Lab_1
//
//  Created by user on 01.04.17.
//  Copyright © 2017 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Parser.h"

@implementation Parser

-(id)init{
    self = [super init];
    return self;
}


-(NSMutableArray *) getMoviesArray:(NSString *)json{
    
    NSMutableArray *movies = [NSMutableArray new];
    NSData *responseData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    if ([NSJSONSerialization isValidJSONObject:responseDic]) {
        NSArray *array = [responseDic objectForKey:@"result"];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            NSString *year = [obj objectForKey:@"year"];
            if (year == [NSNull null]){
                year = @"нет информации";
            }
            NSString *film = [NSString stringWithFormat:@"%@ (%@)", [obj objectForKey:@"title"], year];
            [movies addObject:film];
        }];
        
    }
    return movies;
}



-(NSMutableArray *) getMoviesID:(NSString *)json{
    
    NSMutableArray *moviesID = [NSMutableArray new];
    NSData *responseData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    if ([NSJSONSerialization isValidJSONObject:responseDic]) {
        NSArray *array = [responseDic objectForKey:@"result"];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            [moviesID addObject: [obj objectForKey:@"id"]];
        }];
        
    }
    return moviesID;
}


@end
