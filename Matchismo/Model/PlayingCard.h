//
//  PlayingCard.h
//  Matchismo
//
//  Created by Alexander on 21.11.13.
//  Copyright (c) 2013 Alexander Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
