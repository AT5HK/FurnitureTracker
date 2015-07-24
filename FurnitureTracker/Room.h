//
//  Room.h
//  FurnitureTracker
//
//  Created by Auston Salvana on 7/24/15.
//  Copyright (c) 2015 ASolo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Furniture.h"

@interface Room : RLMObject 

@property RLMArray<Furniture> *allFurniture;
@property NSString *name;

@end
RLM_ARRAY_TYPE(Room)// define RLMArray<Room>