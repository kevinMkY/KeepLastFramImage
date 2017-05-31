//
//  ViewController.m
//  KKKeepLastFrameImageView
//
//  Created by kevin on 2017/5/31.
//  Copyright © 2017年 kevin. All rights reserved.
//

#import "ViewController.h"
#import "KKKeepLastFrameImageView.h"

@interface ViewController ()

@property (nonatomic, strong) KKKeepLastFrameImageView *giftImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i<46; i++) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"gift_effect_text2_%zd@2x",i] ofType:@"png"];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        if (img) {
            [array addObject:img];
        }
    }
    
    _giftImage = [[KKKeepLastFrameImageView alloc] initWithFrame:self.view.bounds];
    _giftImage.frameIntervalMS = 40;
    _giftImage.animationImages = array;
    _giftImage.animationRepeatCount = 2;
    [self.view addSubview:_giftImage];
    
    [_giftImage startAnimating];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
