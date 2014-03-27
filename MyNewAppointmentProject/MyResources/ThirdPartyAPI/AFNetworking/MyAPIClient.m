//
//  MyAPIClient.m
//  ClubEliteMainStoryBoard
//
//  Created by Ganesh Kulpe on 15/06/13.
//  Copyright (c) 2013 Ganesh Kulpe. All rights reserved.
//

#import "MyAPIClient.h"
#import "AFJSONRequestOperation.h"
@implementation MyAPIClient

+(MyAPIClient *)sharedClient {
    static MyAPIClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:[[Utility sharedInstance] baseURL]]];
    });
    return _sharedClient;
}

-(id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    self.parameterEncoding = AFJSONParameterEncoding;
    
    return self;
    
}
@end