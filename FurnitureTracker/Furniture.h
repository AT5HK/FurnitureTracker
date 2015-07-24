//
//  Furniture.h
//  FurnitureTracker
//
//  Created by Auston Salvana on 7/24/15.
//  Copyright (c) 2015 ASolo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface Furniture : RLMObject

@property NSString *name;

@end
RLM_ARRAY_TYPE(Furniture)// define RLMArray<Furniture>