//
//  publicMethod.m
//  TestDemo1
//
//  Created by Hou on 2/25/16.
//  Copyright © 2016 Hou. All rights reserved.
//

#import "publicMethod.h"

@implementation publicMethod

-(CGFloat)calculateFontForButtonOrLabel:(CGFloat)width high:(CGFloat)height
{
    CGFloat temp;
    if(width < height)
    {
        temp = (width / 96) * 72;
        temp -= 2;//根据实际测试，在label中的字号要比计算的小2pt才能正常显示
    }
    else
    {
        temp = (height / 96) * 72;
        temp -= 2;
    }
    return temp;
}

//图片圆形裁剪
-(UIImage *)circleImage:(UIImage *) image withParam:(CGFloat) inset {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,0); //边框线
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

//图片高斯模糊处理
-(UIImage *)blurredPicture:(UIImage *)image
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    // create gaussian blur filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:10.0] forKey:@"inputRadius"];
    // blur image
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *imageProduct = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return imageProduct;
}


@end
