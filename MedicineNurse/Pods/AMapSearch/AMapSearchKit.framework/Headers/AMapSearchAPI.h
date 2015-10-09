//
//  AMapSearchAPI.h
//  AMapSearchKit
//
//  Created by xiaoming han on 15/7/22.
//  Copyright (c) 2015年 AutoNavi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMapSearchObj.h"
#import "AMapCommonObj.h"

@protocol AMapSearchDelegate;

/// 搜索结果语言
typedef NS_ENUM(NSInteger, AMapSearchLanguage)
{
    AMapSearchLanguageZhCN = 0, //!< 中文
    AMapSearchLanguageEn = 1 //!< 英文
};

/// 搜索类
@interface AMapSearchAPI : NSObject

/*!
 @brief AMapSearch的初始化函数。注意，请不要直接使用init进行初始化，会因为有些属性没有初始化而发生错误。
 @param key 搜索模块鉴权Key(详情请访问 http://api.amap.com/ )
 @param delegate 实现AMapSearchDelegate协议的对象id
 @return AMapSearch类对象id
 */
- (id)initWithSearchKey:(NSString *)key Delegate:(id<AMapSearchDelegate>)delegate;

/// 实现了AMapSearchDelegate协议的类指针
@property (nonatomic, weak) id<AMapSearchDelegate> delegate;

/// 查询超时时间，单位秒，默认为20秒
@property (nonatomic, assign) NSInteger timeout;

/// 查询结果返回语言, 默认为中文
@property (nonatomic, assign) AMapSearchLanguage language;


/**
 *  AMapSearch的初始化函数。
 *
 *  初始化之前请设置 AMapSearchServices 中的APIKey，否则将无法正常使用搜索服务.
 *  @return AMapSearch类对象实例
 */
- (instancetype)init;

/**
 *  POI ID查询接口
 *
 *  @param request 查询选项。具体属性字段请参考 AMapPOIIDSearchRequest 类。
 */
- (void)AMapPOIIDSearch:(AMapPOIIDSearchRequest *)request;

/**
 *  POI 关键字查询接口
 *
 *  @param request 查询选项。具体属性字段请参考 AMapPOIKeywordsSearchRequest 类。
 */
- (void)AMapPOIKeywordsSearch:(AMapPOIKeywordsSearchRequest *)request;

/**
 *  POI 周边查询接口
 *
 *  @param request 查询选项。具体属性字段请参考 AMapPOIAroundSearchRequest 类。
 */
- (void)AMapPOIAroundSearch:(AMapPOIAroundSearchRequest *)request;

/**
 *  POI 多边形查询接口
 *
 *  @param request 查询选项。具体属性字段请参考 AMapPOIPolygonSearchRequest 类。
 */
- (void)AMapPOIPolygonSearch:(AMapPOIPolygonSearchRequest *)request;

/**
 *  地址编码查询接口
 *
 *  @param request 查询选项。具体属性字段请参考 AMapGeocodeSearchRequest 类。
 */
- (void)AMapGeocodeSearch:(AMapGeocodeSearchRequest *)request;

/**
 *  逆地址编码查询接口
 *
 *  @param request 查询选项。具体属性字段请参考 AMapReGeocodeSearchRequest 类。
 */
- (void)AMapReGoecodeSearch:(AMapReGeocodeSearchRequest *)request;

/**
 *  输入提示查询接口
 *
 *  @param request 查询选项。具体属性字段请参考 AMapInputTipsSearchRequest 类。
 */
- (void)AMapInputTipsSearch:(AMapInputTipsSearchRequest *)request;

/**
 *  公交站点查询接口
 *
 * @param request 查询选项。具体属性字段请参考 AMapBusStopSearchRequest 类。
 */
- (void)AMapBusStopSearch:(AMapBusStopSearchRequest *)request;

/**
 *  公交线路关键字查询
 *
 *  @param request 查询选项。具体属性字段请参考 AMapBusLineIDSearchRequest 类。
 */
- (void)AMapBusLineIDSearch:(AMapBusLineIDSearchRequest *)request;

/**
 *  公交线路关键字查询
 *
 *  @param request 查询选项。具体属性字段请参考 AMapBusLineIDSearchRequest 类。
 */
- (void)AMapBusLineNameSearch:(AMapBusLineNameSearchRequest *)request;

/**
 *  行政区域查询接口
 *
 *  @param request 查询选项。具体属性字段请参考 AMapDistrictSearchRequest 类。
 */
- (void)AMapDistrictSearch:(AMapDistrictSearchRequest *)request;

/**
 *  驾车路径规划查询接口
 *
 *  @param request 查询选项。具体属性字段请参考 AMapDrivingRouteSearchRequest 类。
 */
- (void)AMapDrivingRouteSearch:(AMapDrivingRouteSearchRequest *)request;

/**
 *  步行路径规划查询接口
 *
 *  @param request 查询选项。具体属性字段请参考 AMapWalkingRouteSearchRequest 类。
 */
- (void)AMapWalkingRouteSearch:(AMapWalkingRouteSearchRequest *)request;

/**
 *  公交路径规划查询接口
 *
 *  @param request 查询选项。具体属性字段请参考 AMapTransitRouteSearchRequest 类。
 */
- (void)AMapTransitRouteSearch:(AMapTransitRouteSearchRequest *)request;

/**
 *  天气查询接口
 *
 *  @param request 查询选项。具体属性字段请参考 AMapWeatherSearchRequest 类。
 */
- (void)AMapWeatherSearch:(AMapWeatherSearchRequest *)request;

#pragma mark - 周边搜索相关

/**
 *  附近搜索查询接口
 *
 *  @param request 查询选项。具体属性字段请参考 AMapNearbySearchRequest 类。
 */
- (void)AMapNearbySearch:(AMapNearbySearchRequest *)request;

@end

#pragma mark - AMapSearchDelegate

/**
 *  AMapSearchDelegate协议
 *  定义了搜索结果的回调方法，发生错误时的错误回调方法。
 */
@protocol AMapSearchDelegate<NSObject>
@optional

/**
 *  当请求发生错误时，会调用代理的此方法.
 *
 *  @param request 发生错误的请求.
 *  @param error   返回的错误.
 */
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error;

/**
 *  POI查询回调函数
 *
 *  @param request  发起的请求，具体字段参考 AMapPOISearchBaseRequest 及其子类。
 *  @param response 响应结果，具体字段参考 AMapPOISearchResponse 。
 */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response;

/**
 *  地理编码查询回调函数
 *
 *  @param request  发起的请求，具体字段参考 AMapGeocodeSearchRequest 。
 *  @param response 响应结果，具体字段参考 AMapGeocodeSearchResponse 。
 */
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response;

/**
 *  逆地理编码查询回调函数
 *
 *  @param request  发起的请求，具体字段参考 AMapReGeocodeSearchRequest 。
 *  @param response 响应结果，具体字段参考 AMapReGeocodeSearchResponse 。
 */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response;

/**
 *  输入提示查询回调函数
 *
 *  @param request  发起的请求，具体字段参考 AMapInputTipsSearchRequest 。
 *  @param response 响应结果，具体字段参考 AMapInputTipsSearchResponse 。
 */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response;

/**
 *  公交站查询回调函数
 *
 *  @param request  发起的请求，具体字段参考 AMapBusStopSearchRequest 。
 *  @param response 响应结果，具体字段参考 AMapBusStopSearchResponse 。
 */
- (void)onBusStopSearchDone:(AMapBusStopSearchRequest *)request response:(AMapBusStopSearchResponse *)response;

/**
 *  公交线路关键字查询回调
 *
 *  @param request  发起的请求，具体字段参考 AMapBusLineSearchRequest 。
 *  @param response 响应结果，具体字段参考 AMapBusLineSearchResponse 。
 */
- (void)onBusLineSearchDone:(AMapBusLineBaseSearchRequest *)request response:(AMapBusLineSearchResponse *)response;

/**
 *  行政区域查询回调函数
 *
 *  @param request  发起的请求，具体字段参考 AMapDistrictSearchRequest 。
 *  @param response 响应结果，具体字段参考 AMapDistrictSearchResponse 。
 */
- (void)onDistrictSearchDone:(AMapDistrictSearchRequest *)request response:(AMapDistrictSearchResponse *)response;

/**
 *  路径规划查询回调
 *
 *  @param request  发起的请求，具体字段参考 AMapRouteSearchBaseRequest 及其子类。
 *  @param response 响应结果，具体字段参考 AMapRouteSearchResponse 。
 */
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response;

/**
 *  天气查询回调
 *
 *  @param request  发起的请求，具体字段参考 AMapWeatherSearchRequest 。
 *  @param response 响应结果，具体字段参考 AMapWeatherSearchResponse 。
 */
- (void)onWeatherSearchDone:(AMapWeatherSearchRequest *)request response:(AMapWeatherSearchResponse *)response;

/**
 *  周边搜索回调
 *
 *  @param request  发起的请求，具体字段参考 AMapNearbySearchRequest 。
 *  @param response 响应结果，具体字段参考 AMapNearbySearchResponse 。
 */
- (void)onNearbySearchDone:(AMapNearbySearchRequest *)request response:(AMapNearbySearchResponse *)response;
/*!
 @brief AMapSearch的初始化函数。注意，请不要直接使用init进行初始化，会因为有些属性没有初始化而发生错误。
 @param key 搜索模块鉴权Key(详情请访问 http://api.amap.com/ )
 @param delegate 实现AMapSearchDelegate协议的对象id
 @return AMapSearch类对象id
 */
- (id)initWithSearchKey:(NSString *)key Delegate:(id<AMapSearchDelegate>)delegate;
@end
