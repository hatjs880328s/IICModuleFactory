//
//  IIModuleInvocation.m
//  OralStunts
//
//  Created by Noah_Shan on 2018/6/8.
//  Copyright © 2018年 Inspur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IIModuleInvocation.h"

@implementation IIModuleInvocation


- (id)invokingMethod:(NSObject *)mateClass selector: (SEL)realSelector params:(NSMutableDictionary *)paramsDic {
    NSMethodSignature *sin = [[mateClass class] instanceMethodSignatureForSelector:realSelector];
    NSInvocation *invok = [NSInvocation invocationWithMethodSignature: sin];
    [invok setTarget:mateClass];
    [invok setSelector:realSelector];
    [invok setArgument:&paramsDic atIndex:2];
    [invok retainArguments];
    [invok invoke];
    
    
    [self methodSignature:invok];
    
    id tempResultSet;
    [invok getReturnValue:&tempResultSet];
    
    return tempResultSet;
}


- (void)methodSignature:(NSInvocation *)invocation {
    
    // get method signature
    NSMethodSignature *signature = invocation.methodSignature;
    
    //NSUInteger frameLength = signature.frameLength;
    //NSLog(@"frameLength ---- %ld",frameLength);
    
    //NSUInteger returnLength = signature.methodReturnLength;
    //NSLog(@"returnLength ---- %ld",returnLength);
    
    // if one way method
    //NSString *oneWay =  [signature isOneway] ? @"yes" : @"no";

    NSInteger count = signature.numberOfArguments;
    
    // print all params
    // results :  @ : i i i  Objective-C params type
    // @ : NSObject* | id
    // : : SEL
    // i : int
    for (int i = 0; i < (int)count; i++) {
        const char *argTybe = [signature getArgumentTypeAtIndex:i];
        NSLog(@"params type is %s",argTybe);
    }
    
    const char *returnType = [signature methodReturnType];
    NSLog(@"params type is %s",returnType);
    
}

@end
