//
//  ViewController.h
//  DrawingApp
//
//  Created by Ahmed Mokhtar on 7/10/18.
//  Copyright © 2018 Ahmed Mokhtar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)pencilPressed:(UIButton *)sender;
- (IBAction)eraseButtonPressed:(UIButton *)sender;
- (IBAction)save:(UIButton *)sender;
- (IBAction)reset:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *tempImage;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;

@property CGPoint lastPoint;
@property CGFloat red;
@property CGFloat green;
@property CGFloat blue;
@property CGFloat brush;
@property CGFloat opacity;
@property BOOL mouseSwiped;

@end

