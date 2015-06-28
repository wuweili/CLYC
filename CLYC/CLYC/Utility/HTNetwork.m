//
//  HTNetwork.m
//  IOS-IM
//
//  Created by xishuaishuai on 13-9-14.
//  Copyright (c) 2013年 weihua. All rights reserved.
//

#import "HTNetwork.h"
#import "Reachability.h"



@implementation HTNetwork
//@synthesize wifi,carrier;

+ (HTNetwork *)sharedInstance
{
    static HTNetwork *sharedReach = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
            sharedReach = [[HTNetwork alloc] init];
    });
    return sharedReach;
}
#pragma mark
+ (BOOL)isNetworkAvailable
{
    Reachability *reach3G = [Reachability reachabilityForInternetConnection];
    BOOL is3GAvailable = ([reach3G currentReachabilityStatus] != NotReachable);
    
    Reachability *reachWIFI = [Reachability reachabilityForLocalWiFi];
    BOOL isWIFIAvailable = ([reachWIFI currentReachabilityStatus] != NotReachable);
    
    return (is3GAvailable || isWIFIAvailable);
}

#pragma mark
- (id)init
{
    self = [super init];
    if (self)
    {
        _wifi = [Reachability reachabilityForLocalWiFi];
        _carrier = [Reachability reachabilityForInternetConnection];
    }
    return self;
}


#pragma mark
- (BOOL)isNetworkAvailable
{
    BOOL hasCarrier = ([_carrier currentReachabilityStatus] != NotReachable);
    BOOL hasWIFI = ([_wifi currentReachabilityStatus] != NotReachable);
    
    return hasCarrier || hasWIFI;
}

- (void)startListening
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    [_wifi startNotifier];
    
    [_carrier startNotifier];
}

- (void)stopListening
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kReachabilityChangedNotification
                                                  object:nil];
    [_wifi stopNotifier];
    
    [_carrier stopNotifier];
}

//TODO: need to define a protocol and notify delegates
- (void)reachabilityChanged
{
     //custom code
    
     [[NSNotificationCenter defaultCenter]postNotificationName:KNetworkStateChangedNotification object:nil];
    
    
}

@end
