//
//  Utility.m
//  MyNewAppointmentProject
//
//  Created by Vishal Dharmawat on 07/03/14.
//  Copyright (c) 2014 Vishnu Gupta. All rights reserved.
//

#import "Utility.h"
#import "AFNetworking.h"

@implementation Utility

- (id) init
{
    if (!self) {
        self = [[Utility alloc]init];
    }
    return self;
}

static Utility *util = nil;

+(Utility *)sharedInstance
{
    if (!util) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            util = [[Utility alloc]init];
            [util startConnectionCheck];
        });
    }
    return util;
}

- (void) startConnectionCheck
{
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
        // Set the blocks
    reach.reachableBlock = ^(Reachability*reach)
    {
        _isNetworkConnectionAvailable = YES;
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        _isNetworkConnectionAvailable = NO;
    };
    
        // Start the notifier, which will cause the reachability object to retain itself!
    [reach startNotifier];
}



-(NSString *)baseURL
{
    return [NSString stringWithFormat:@"http://14.140.93.226/MylegalNetRemote/LegalNetService.svc/"];
}
-(NSMutableDictionary *)fetchData:(NSString *)webMethod
{
    return nil;
}
-(void)fetchDataWithMethodName:(NSString *)webMethod andParameterDictionary:(NSMutableDictionary *)dictionary
{
    if (!_isNetworkConnectionAvailable) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please check the network connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else {
        
        AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:
                                [NSURL URLWithString:[self baseURL]]];
        [client setDefaultHeader:@"Accept" value:@"application/json"];
        client.parameterEncoding = AFJSONParameterEncoding;
        [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
        
        NSMutableURLRequest *request =
        [client requestWithMethod:@"POST" path:webMethod parameters:dictionary];
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
        [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
        
        AFJSONRequestOperation *operation =
        [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
         {
             NSLog(@"JSON: %@",JSON);
             [_delegate inComingResponse:JSON forRequest:webMethod];
             
         }
                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
         {
             NSLog(@"%@",error.localizedDescription);
             [_delegate inComingError:error.localizedDescription forRequest:webMethod];
             
         }];
        [operation start];
    }
}

    
- (id)parseJsonResult:(NSData *)result
{
    if( ! result)
        return nil;
    NSError *error = nil;
    
    NSMutableDictionary *dict = [NSJSONSerialization JSONObjectWithData: result options: NSJSONReadingMutableContainers error: &error];
    
    NSLog(@"dict : %@",dict);
    
    if (error)
    {
        NSLog(@"Error parsing JSON: %@", error);
        return nil;
    }
    return dict;
}


@end
