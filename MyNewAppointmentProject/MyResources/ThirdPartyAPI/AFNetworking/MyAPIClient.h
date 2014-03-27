//
//  MyAPIClient.h
//  ClubEliteMainStoryBoard
//
//  Created by Ganesh Kulpe on 15/06/13.
//  Copyright (c) 2013 Ganesh Kulpe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface MyAPIClient : AFHTTPClient

+(MyAPIClient *)sharedClient;

@end