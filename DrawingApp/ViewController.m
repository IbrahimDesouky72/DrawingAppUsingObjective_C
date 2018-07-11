//
//  ViewController.m
//  DrawingApp
//
//  Created by Ahmed Mokhtar on 7/10/18.
//  Copyright © 2018 Ahmed Mokhtar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    _red = 0.0/255.0;
    _green = 0.0/255.0;
    _blue = 0.0/255.0;
    _brush = 10.0;
    _opacity = 1.0;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pencilPressed:(UIButton *)sender {
    
    UIButton * PressedButton = (UIButton*)sender;
    
    switch(PressedButton.tag)
    {
        case 0:
            _red = 0.0/255.0;
            _green = 0.0/255.0;
            _blue = 0.0/255.0;
            break;
        case 1:
            
            _red = 160.0/255.0;
            _green = 82.0/255.0;
            _blue = 45.0/255.0;
            
            
            break;
        case 2:
            
            _red = 105.0/255.0;
            _green = 105.0/255.0;
            _blue = 105.0/255.0;
            
            
            break;
        case 3:
            _red = 0.0/255.0;
            _green = 0.0/255.0;
            _blue = 255.0/255.0;
            break;
        case 4:
            _red = 51.0/255.0;
            _green = 204.0/255.0;
            _blue = 255.0/255.0;
            break;
        case 5:
            _red = 102.0/255.0;
            _green = 255.0/255.0;
            _blue = 0.0/255.0;
            break;
        case 6:
            _red = 102.0/255.0;
            _green = 204.0/255.0;
            _blue = 0.0/255.0;
            break;
        case 7:
            _red = 255.0/255.0;
            _green = 0.0/255.0;
            _blue = 0.0/255.0;
            
            
            break;
        case 8:
            _red = 255.0/255.0;
            _green = 102.0/255.0;
            _blue = 0.0/255.0;
            break;
        case 9:
            _red = 255.0/255.0;
            _green = 255.0/255.0;
            _blue = 0.0/255.0;
            break;
    }
}

- (IBAction)eraseButtonPressed:(UIButton *)sender {
    _red = 255.0/255.0;
    _green = 255.0/255.0;
    _blue = 255.0/255.0;
    _opacity = 1.0;
}

- (IBAction)save:(UIButton *)sender {
}

- (IBAction)reset:(UIButton *)sender {
    self.mainImage.image = nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    _mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    _lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    _mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.tempImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x, _lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), _red, _green, _blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempImage setAlpha:_opacity];
    UIGraphicsEndImageContext();
    
    _lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!_mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), _red, _green, _blue, _opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x, _lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x, _lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.mainImage.frame.size);
    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempImage.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:_opacity];
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempImage.image = nil;
    UIGraphicsEndImageContext();
}


@end
