//
//  Card.h
//  Matchismo
//
//  Created by Alexander on 21.11.13.
//  Copyright (c) 2013 Alexander Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)matchCards:(NSArray *)cards;

@end
