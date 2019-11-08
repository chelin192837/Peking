//
//  SelectPhotoManager.m
//  SelectPhoto
//
//  Created by 吉祥 on 2017/8/29.
//  Copyright © 2017年 jixiang. All rights reserved.
//

#import "SelectPhotoManager.h"
#import<AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import<AssetsLibrary/AssetsLibrary.h>
#import<CoreLocation/CoreLocation.h>
#import <Photos/Photos.h>
#import <CoreServices/CoreServices.h>
#import "NSString+LW.h"
#import "FileTools.h"
@interface SelectPhotoManager()
@property(nonatomic,assign) int type;
@end
@implementation SelectPhotoManager {
    //图片名
    NSString *_imageName;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(instancetype)initWithMediaTypeArray:(NSArray *)mediaTypeArray{
    SelectPhotoManager *manager=[[SelectPhotoManager alloc] init];
    manager.mediaTypeArray=mediaTypeArray;
    return manager;
}

//开始选择照片
- (void)startSelectPhotoWithImageName:(NSString *)imageName{
    _imageName = imageName;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
//    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:imageName];
//    [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, 4)];
//    [alertController setValue:alertControllerStr forKey:@"attributedTitle"];
    [alertController addAction: [UIAlertAction actionWithTitle: LAN(@"拍摄") style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self selectPhotoWithType:0];
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: LAN(@"从相册选择") style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self selectPhotoWithType:1];
    }]];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:LAN(@"取消") style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [[self getCurrentVC] presentViewController:alertController animated:YES completion:nil];
}

//根据类型选取照片
//- (void)startSelectPhotoWithType:(SelectPhotoType)type andImageName:(NSString *)imageName {
//    _imageName = imageName;
//    UIImagePickerController *ipVC = [[UIImagePickerController alloc] init];
//    //设置跳转方式
//    ipVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//
//    if (_canEditPhoto) {
//        //设置是否可对图片进行编辑
//        ipVC.allowsEditing = YES;
//    }
//
//    ipVC.delegate = self;
//    if (type == PhotoCamera) {
//        NSLog(@"相机");
//        //后置相机
//        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
//        if (!isCamera) {
//            NSLog(@"没有摄像头");
//            if (_errorHandle) {
//                _errorHandle(@"没有摄像头");
//            }
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的设备不支持拍照" preferredStyle:UIAlertControllerStyleAlert];
//            [alertController addAction: [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            }]];
//            [[self getCurrentVC] presentViewController:alertController animated:YES completion:nil];
//            return ;
//        }
//
//        //相机权限
//        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
//        if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
//            authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
//        {
//            // 无权限 引导去开启
//            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//            if ([[UIApplication sharedApplication] canOpenURL:url]) {
//                [[UIApplication sharedApplication] openURL:url options:[NSDictionary dictionary] completionHandler:nil];
//            }
//            return ;
//        }
//
//        ipVC.sourceType = UIImagePickerControllerSourceTypeCamera;
//        NSString *requiredMediaType = ( NSString *)kUTTypeImage;
//        NSString *requiredMediaType1 = ( NSString *)kUTTypeMovie;
//        NSArray *arrMediaTypes=[NSArray arrayWithObjects:requiredMediaType, requiredMediaType1,nil];
//        [ipVC setMediaTypes:arrMediaTypes];
//
//    }else{
//        NSLog(@"相册");
//
//        //相册权限
//        if([UIDevice currentDevice].systemVersion.floatValue >= 9.0f){
//            PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
//            if (status == PHAuthorizationStatusRestricted ||
//                status == PHAuthorizationStatusDenied) {
//                //无权限 引导去开启
//                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//                if ([[UIApplication sharedApplication] canOpenURL:url]) {
//                    [[UIApplication sharedApplication]openURL:url options:[NSDictionary dictionary] completionHandler:nil];
//                }
//                return;
//            }
//        }else{
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//            ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
//            if (author ==kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied){
//                //无权限 引导去开启
//                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//                if ([[UIApplication sharedApplication] canOpenURL:url]) {
//                    [[UIApplication sharedApplication]openURL:url options:[NSDictionary dictionary] completionHandler:nil];
//                }
//                return ;
//            }
//#pragma clang diagnostic pop
//        }
//
//        ipVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        NSString *requiredMediaType = ( NSString *)kUTTypeImage;
//        NSString *requiredMediaType1 = ( NSString *)kUTTypeMovie;
//        NSArray *arrMediaTypes=[NSArray arrayWithObjects:requiredMediaType, requiredMediaType1,nil];
//        [ipVC setMediaTypes:arrMediaTypes];
//    }
//
//    [[self getCurrentVC] presentViewController:ipVC animated:YES completion:nil];
//}
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC {
    
    if (_superVC) {
        return _superVC;
    }
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
        
    }else{
        result = window.rootViewController;
    }
    return result;
}

#pragma mark 方法
-(void)selectPhotoWithType:(int)type {
    self.type=type;
    if (type == 2) {
        NSLog(@"取消");
    }else{
        if(self.updateFlagHandle){
            self.updateFlagHandle();
        }
        
        UIImagePickerController *ipVC = [[UIImagePickerController alloc] init];
        //设置跳转方式
        ipVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        ipVC.delegate = self;
        if (type == 0) {
            NSLog(@"相机");
            BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
            if (!isCamera) {
                NSLog(@"没有摄像头");
                if (_errorHandle) {
                    _errorHandle(@"没有摄像头");
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的设备不支持拍照" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction: [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                }]];
                [[self getCurrentVC] presentViewController:alertController animated:YES completion:nil];
                return ;
            }
            
            //相机权限
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
                authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"为了拍摄诉求内容,需要开启相机权限" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                }]];
                [alertController addAction: [UIAlertAction actionWithTitle: @"去设置" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    // 无权限 引导去开启
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication]canOpenURL:url]) {
                        [[UIApplication sharedApplication]openURL:url options:[NSDictionary dictionary] completionHandler:nil];
                    }
                }]];
                [[self getCurrentVC] presentViewController:alertController animated:YES completion:nil];
                return ;
            }
            
            ipVC.sourceType = UIImagePickerControllerSourceTypeCamera;
            if(!self.mediaTypeArray){
                NSString *requiredMediaType = ( NSString *)kUTTypeImage;
                NSString *requiredMediaType1 = ( NSString *)kUTTypeMovie;
                self.mediaTypeArray=[NSArray arrayWithObjects:requiredMediaType, requiredMediaType1,nil];
            }
            [ipVC setMediaTypes:self.mediaTypeArray];
            [ipVC setAllowsEditing:NO];
            [ipVC setVideoMaximumDuration:30.0f];
//            [ipVC setVideoQuality:UIImagePickerControllerQualityTypeLow];
        }else{
            NSLog(@"相册");
            
            //相册权限
            if([UIDevice currentDevice].systemVersion.floatValue >= 9.0f){
                PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
                if (status == PHAuthorizationStatusRestricted ||
                    status == PHAuthorizationStatusDenied) {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"为了选取诉求内容,需要开启相册权限" preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    }]];
                    [alertController addAction: [UIAlertAction actionWithTitle: @"去设置" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        // 无权限 引导去开启
                        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        if ([[UIApplication sharedApplication]canOpenURL:url]) {
                            [[UIApplication sharedApplication]openURL:url options:[NSDictionary dictionary] completionHandler:nil];
                        }
                    }]];
                    [[self getCurrentVC] presentViewController:alertController animated:YES completion:nil];
                    return ;
                }
            }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
                if (author ==kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied){
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"为了选取诉求内容,需要开启相册权限" preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                    }]];
                    [alertController addAction: [UIAlertAction actionWithTitle: @"去设置" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        // 无权限 引导去开启
                        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        if ([[UIApplication sharedApplication]canOpenURL:url]) {
                            [[UIApplication sharedApplication]openURL:url options:[NSDictionary dictionary] completionHandler:nil];
                        }
                    }]];
                    [[self getCurrentVC] presentViewController:alertController animated:YES completion:nil];
                    return ;
                }
#pragma clang diagnostic pop
            }
            
            ipVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            if(!self.mediaTypeArray){
                NSString *requiredMediaType = ( NSString *)kUTTypeImage;
                NSString *requiredMediaType1 = ( NSString *)kUTTypeMovie;
                self.mediaTypeArray=[NSArray arrayWithObjects:requiredMediaType, requiredMediaType1,nil];
            }
            [ipVC setMediaTypes:self.mediaTypeArray];
            [ipVC setAllowsEditing:NO];
        }
        [[self getCurrentVC] presentViewController:ipVC animated:YES completion:nil];
    }
}

#pragma mark -----------------imagePickerController协议方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"info = %@",info);
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // 判断获取类型：图片
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]){
        
        //图片旋转
//        if (image.imageOrientation != UIImageOrientationUp) {
//            //图片旋转
//            image = [self fixOrientation:image];
//        }
        if(self.type==0){
            //获取照片
            UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
            if (image == nil) {
                image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
            }
            // 保存图片到相册中
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
        
//        if (_imageName==nil || _imageName.length == 0) {
//            //获取当前时间,生成图片路径
//            NSDate *date = [NSDate date];
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateStyle:NSDateFormatterMediumStyle];
//            [formatter setTimeStyle:NSDateFormatterShortStyle];
//            [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
//            NSString *dateStr = [formatter stringFromDate:date];
//            _imageName = [NSString stringWithFormat:@"photo_%@.png",dateStr];
//        }
        
    }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
        
        if(self.type==0){
            // 判断获取类型：视频
            //获取视频文件的url  视频保存在temp文件目录下，系统自动清理
            NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
            // 将视频保存到相册中
            PHPhotoLibrary *photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
            [photoLibrary performChanges:^{
                [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:mediaURL];
            } completionHandler:^(BOOL success, NSError * _Nullable error) {
                if (success) {
                    NSLog(@"已将视频保存至相册");
                } else {
                    NSLog(@"未能保存视频到相册");
                }
            }];
        }
    }
    [[self getCurrentVC] dismissViewControllerAnimated:YES completion:nil];
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectPhotoManagerDidFinishImage:)]) {
        [_delegate selectPhotoManagerDidFinishImage:info];
    }

    //保存List 刷新页面
    if (_successHandle) {
        _successHandle(self,info);
    }
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        NSLog(@"保存失败");
    } else {
        NSLog(@"保存成功");
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [[self getCurrentVC] dismissViewControllerAnimated:YES completion:nil];
    if (_delegate && [_delegate respondsToSelector:@selector(selectPhotoManagerDidError:)]) {
        [_delegate selectPhotoManagerDidError:nil];
    }
    if (_errorHandle) {
        _errorHandle(@"撤销");
    }
}

#pragma mark 图片处理方法
//图片旋转处理
- (UIImage *)fixOrientation:(UIImage *)aImage {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;

        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
#pragma mark ---- 获取图片第一帧
+(UIImage *)firstFrameWithVideoURL:(NSURL *)url size:(CGSize)size
{
    // 获取视频第一帧
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(size.width, size.height);
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10) actualTime:NULL error:&error];
    {
        return [UIImage imageWithCGImage:img];
    }
    return nil;
}


+ (void)convertMovToMp4FromAVURLAsset:(NSURL *)url andCompeleteHandler:(void(^)(NSURL *fileUrl))fileUrlHandler{
    
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetLowQuality]) {
        NSString *resultPath = [[url.absoluteString stringByDeletingPathExtension] stringByAppendingString:@".mp4"];
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset
                                                                               presetName:AVAssetExportPresetMediumQuality];
        exportSession.outputURL = [NSURL URLWithString:resultPath];
        exportSession.outputFileType = AVFileTypeMPEG4;
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         {
             switch (exportSession.status) {
                 case AVAssetExportSessionStatusUnknown:
                     NSLog(@"AVAssetExportSessionStatusUnknown");
                     fileUrlHandler(nil);
                     break;
                 case AVAssetExportSessionStatusWaiting:
                     NSLog(@"AVAssetExportSessionStatusWaiting");
                     fileUrlHandler(nil);
                     break;
                 case AVAssetExportSessionStatusExporting:
                     NSLog(@"AVAssetExportSessionStatusExporting");
                     fileUrlHandler(nil);
                     break;
                 case AVAssetExportSessionStatusCompleted:
                     NSLog(@"AVAssetExportSessionStatusCompleted");
                     NSLog(@"转换MP4 = %@",resultPath);
                     fileUrlHandler(exportSession.outputURL);
                     break;
                 case AVAssetExportSessionStatusFailed:
                     NSLog(@"AVAssetExportSessionStatusFailed %@",exportSession.error);
                     fileUrlHandler(nil);
                     break;
                     
                 case AVAssetExportSessionStatusCancelled:
                     NSLog(@"AVAssetExportSessionStatusCancelled");
                     fileUrlHandler(nil);
                     break;
             }
         }];
    }
}


//检查文件合规性 30*1024*1024 B 字节
#define VideoSizeMax  31457280
+(void)checkFileMaxSize:(NSURL *)FileUrl{
    // 检查文件属性 查看文件大小 是否超标
    NSError *mp4Rrror;
    NSDictionary *infoDict = [[NSFileManager defaultManager]attributesOfItemAtPath:FileUrl.path error:&mp4Rrror];
    NSString *fileSizeString = infoDict[@"NSFileSize"];
    NSInteger fileSize = fileSizeString.integerValue;
    NSLog(@"视频大小%.2ldB",(long)fileSize);
//  [[NSFileManager defaultManager] removeItemAtPath:MP4FileUrl.path error:&error];
}
+ (NSInteger)getVideoTimeByUrlString:(NSString*)urlString {
    NSURL*videoUrl = [NSURL URLWithString:urlString];
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:videoUrl];
    CMTime time = [avUrl duration];
    int seconds = ceil(time.value/time.timescale);
    return seconds;
}

@end

