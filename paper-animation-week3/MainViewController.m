//
//  MainViewController.m
//  paper-animation-week3
//
//  Created by Robert Thompson on 7/3/14.
//  Copyright (c) 2014 Google. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
- (IBAction)headlinePanGestureRecognizer:(UIPanGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet UIView *headlineNewsUIView;
@property (weak, nonatomic) IBOutlet UIScrollView *newsScrollView;
@property (nonatomic, assign) float headlineOffsetY;
@property (nonatomic, assign) float headlineOriginalY;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.newsScrollView.contentSize = CGSizeMake(1444, 253);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)headlinePanGestureRecognizer:(UIPanGestureRecognizer *)sender {
    
    
    //Setting location
    CGPoint location = [sender locationInView:self.view];
   // CGPoint veloctiy = [sender velocityInView:self.view];
 
    
    if (sender.state == UIGestureRecognizerStateBegan) {
    
        //setting the offset calculation with original finger location
        CGPoint offset = [sender locationInView:self.view];

        //setting offset in the global variable for future use
        self.headlineOffsetY = offset.y;
        
        //setting original frame location
        self.headlineOriginalY = self.headlineNewsUIView.frame.origin.y;
        
    }
    
    else if (sender.state == UIGestureRecognizerStateChanged){
        
        NSLog(@"Pan Guestre changed: %@", NSStringFromCGPoint(location));
        //NSLog(@"OFFSET: %@", NSStringFromCGPoint(offset));


        
        //if we're at the top and you try to drag up
        if (self.headlineOriginalY == 0 && self.headlineNewsUIView.frame.origin.y - self.headlineOriginalY < 0) {

     
            
                  self.headlineNewsUIView.frame = CGRectMake(self.headlineNewsUIView.frame.origin.x,(location.y - self.headlineOffsetY) * .08, self.headlineNewsUIView.frame.size.width, self.headlineNewsUIView.frame.size.height);
        
            
        } else {
            
            //changing position of the UI view such that it moves with your finger
            
            self.headlineNewsUIView.frame = CGRectMake(self.headlineNewsUIView.frame.origin.x,self.headlineOriginalY + location.y - self.headlineOffsetY, self.headlineNewsUIView.frame.size.width, self.headlineNewsUIView.frame.size.height);
            
        }
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
    NSLog(@"PANNING ENDED");
        
        
        //if we're at the starting position and the user drags down far enough
        if (self.headlineOriginalY == 0 && self.headlineNewsUIView.frame.origin.y - self.headlineOriginalY >= 50) {
            
            
            
            //go to bottom
            
          [UIView animateWithDuration:0.1 animations:^{
            self.headlineNewsUIView.frame = CGRectMake(0,520, self.headlineNewsUIView.frame.size.width, self.headlineNewsUIView.frame.size.height);
          }];
        }
        //if we're at the starting position and the user doesn't drag far enough
        else if (self.headlineOriginalY == 0 && self.headlineNewsUIView.frame.origin.y - self.headlineOriginalY < 50) {

        //return to origin
            [UIView animateWithDuration:0.1 animations:^{
               self.headlineNewsUIView.frame = CGRectMake(0,0, self.headlineNewsUIView.frame.size.width, self.headlineNewsUIView.frame.size.height);
           
            }];
        }
        
        //if we're at the bottom position and the user drags far enough
        else if (self.headlineOriginalY == 520 && self.headlineNewsUIView.frame.origin.y - self.headlineOriginalY <= -50) {
            

            //back to the top
            
       [UIView animateWithDuration:0.1 animations:^{
            self.headlineNewsUIView.frame = CGRectMake(0,0, self.headlineNewsUIView.frame.size.width, self.headlineNewsUIView.frame.size.height);
       }];
        }
        
        
        //if we're at the bottom position and the user doesn't drag far enough
        
        else if (self.headlineOriginalY == 520 && self.headlineNewsUIView.frame.origin.y - self.headlineOriginalY > -50 ) {
            
            //back to the bottom
            
       [UIView animateWithDuration:0.1 animations:^{
            self.headlineNewsUIView.frame = CGRectMake(0,520, self.headlineNewsUIView.frame.size.width, self.headlineNewsUIView.frame.size.height);
       }];
        
        }
        

        
        
    }
}
@end
