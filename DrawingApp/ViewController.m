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
    _brush = 5.0;
    _opacity = 1.0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.data = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithDouble:1.0],[NSNumber numberWithDouble:5.0],[NSNumber numberWithDouble:10.0],[NSNumber numberWithDouble:15.0],[NSNumber numberWithDouble:20.0], nil];
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
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Save Photo"
                                                                   message:@"This is an alert."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField){}];
    
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              UIGraphicsBeginImageContextWithOptions(self->_mainImage.bounds.size, NO,0.0);
                                                              [self->_mainImage.image drawInRect:CGRectMake(0, 0, self->_mainImage.frame.size.width, self->_mainImage.frame.size.height)];
                                                              UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
                                                              NSString *imageName = alert.textFields.firstObject.text;
                                                              if ([imageName  isEqual: @""]) {
                                                                  printf("empty");
                                                                  //return ;
                                                              }else {
//                                                                  NSManagedObjectContext *context = [self managedObjectContext];
//                                                                  printf("1ggggg");
//                                                                  // Create a new managed object
//                                                                  NSManagedObject *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Images" inManagedObjectContext:context];
//                                                                  printf("2ggggg");
//                                                                  
//                                                                  
//                                                                 // [entity setValue:UIImagePNGRepresentation(self->_mainImage.image) forKey:@"imageData"];
//                                                                  [entity setValue:alert.textFields.firstObject.text forKey:@"imageName"];
//                                                                  printf("3gggg");
//                                                                  NSError *error = nil;
//                                                                  // Save the object to persistent store
//                                                                  if (![context save:&error]) {
//                                                                      NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
//                                                                  }
                                                                  
                                                                  UIGraphicsEndImageContext();
                                                                  UIImageWriteToSavedPhotosAlbum(SaveImage, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
                                                                  
                                                              }
                                                              
                                                              
                                                          }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    printf("4kkkkkkk");
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Image could not be saved.Please try again"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Image was successfully saved in photoalbum"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    }
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


- (IBAction)getBrushValue:(UIButton *)sender {
    
    if (self.tableView.hidden == YES) {
        self.tableView.hidden = NO;
    }
    
    else
        self.tableView.hidden = YES;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
    }
    
    
    cell.textLabel.text = [[self.data objectAtIndex:indexPath.row] stringValue] ;
    
    
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.data count];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self.btnOutlet setTitle:cell.textLabel.text forState:UIControlStateNormal];
    _brush = [cell.textLabel.text doubleValue];
   
    
    
    self.tableView.hidden = YES;
    
    
    
}


@end
