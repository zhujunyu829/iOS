//
//  ViewController.m
//  TestWiFiTransmission
//
//  Created by zjy on 2022/3/26.
//

#import "ViewController.h"
#import "HTTPServer.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <sys/sockio.h>
#include <net/if.h>
#include <errno.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#import "MyHTTPConnection.h"

@interface ViewController ()
{
    HTTPServer *_server;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatServer];
    // Do any additional setup after loading the view.
}
- (void)creatServer{
    _server = [[HTTPServer alloc] init];
    [_server setType:@"_http._tcp."];
    NSString *ip = [self localWiFiIPAddress];
    if (ip) {
        [_server setPort:4432];
    }
    NSString *webPath = [[NSBundle mainBundle] resourcePath];

    [_server setDocumentRoot:webPath];
    [_server setConnectionClass:[MyHTTPConnection class]];
    NSError *error = nil;
    NSLog(@"%@",ip);
    if ([_server start:&error]) {
        NSLog(@"启动服务成功");
    }else{
        NSLog(@"%@",error);
    }
}


#pragma  mark - 获取ip
- (NSString *)localWiFiIPAddress
{
    BOOL success;
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;
    char IPdotdec[20]; //dengzhucai add by  2016 05 23

    success = getifaddrs(&addrs) == 0;
    if (success) {
        cursor = addrs;
        while (cursor != NULL) {
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = [NSString stringWithUTF8String:cursor->ifa_name];
                if ([name isEqualToString:@"en0"])
                   // return [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr)];// dengzhcuai  inet_ntop
                return [NSString stringWithUTF8String:inet_ntop(AF_INET,&((struct sockaddr_in *)cursor->ifa_addr)->sin_addr,IPdotdec,16)]; //dengzhucai add by  2016 05 23
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return nil;
}
@end
