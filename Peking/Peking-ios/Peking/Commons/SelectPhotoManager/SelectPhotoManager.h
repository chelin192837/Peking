//
//  SelectPhotoManager.h
//  SelectPhoto
//
//  Created by 吉祥 on 2017/8/29.
//  Copyright © 2017年 jixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import<AVFoundation/AVFoundation.h>
typedef enum {
    PhotoCamera = 0,
    PhotoAlbum,
}SelectPhotoType;

@protocol selectPhotoDelegate <NSObject>
//照片选取成功
- (void)selectPhotoManagerDidFinishImage:(NSDictionary *)info;
//照片选取失败
- (void)selectPhotoManagerDidError:(NSError *)error;
@end

@interface SelectPhotoManager : NSObject<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

//代理对象
@property(nonatomic, weak)__weak id<selectPhotoDelegate>delegate;
//跳转的控制器 可选参数
@property(nonatomic, weak)__weak UIViewController *superVC;
//MediaType
@property(nonatomic,strong)NSArray *mediaTypeArray;
//照片选取成功回调
@property(nonatomic, strong)void (^successHandle)(SelectPhotoManager *manager, NSDictionary *info);
//照片选取失败回调
@property(nonatomic, strong)void (^errorHandle)(NSString *error);

@property(nonatomic, strong)void (^updateFlagHandle)(void);
//开始选取照片
- (void)startSelectPhotoWithImageName:(NSString *)imageName;
//- (void)startSelectPhotoWithType:(SelectPhotoType )type andImageName:(NSString *)imageName;
+(instancetype)initWithMediaTypeArray:(NSArray *)mediaTypeArray;
//获取视频第一帧图片
+(UIImage *)firstFrameWithVideoURL:(NSURL *)url size:(CGSize)size;
//转换MOV T MP4
+ (void)convertMovToMp4FromAVURLAsset:(NSURL *)url andCompeleteHandler:(void(^)(NSURL *fileUrl))fileUrlHandler;
//获取文件大小
+(void)checkFileMaxSize:(NSURL *)FileUrl;
//获取文件时长
+ (NSInteger)getVideoTimeByUrlString:(NSString*)urlString;
//转换完成后调用
@property (nonatomic, copy) void (^coverFinishOperationBlock)(NSURL* url);
@end
