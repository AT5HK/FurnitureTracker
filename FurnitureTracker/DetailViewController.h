//
//  DetailViewController.h
//  FurnitureTracker
//
//  Created by Auston Salvana on 7/24/15.
//  Copyright (c) 2015 ASolo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import "Furniture.h"
#import "Room.h"


@interface DetailViewController : UIViewController

@property Room *roomDetailItem;

@end

