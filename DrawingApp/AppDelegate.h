//
//  AppDelegate.h
//  DrawingApp
//
//  Created by Ahmed Mokhtar on 7/10/18.
//  Copyright © 2018 Ahmed Mokhtar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

