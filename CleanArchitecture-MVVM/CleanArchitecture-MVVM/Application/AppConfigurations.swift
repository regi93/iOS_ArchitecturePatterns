//
//  AppConfigurations.swift
//  CleanArchitecture-MVVM
//
//  Created by 유준용 on 2/28/24.
//

import Foundation

// 앱에서 전역적으로 사용되는 값들
final class AppConfiguration {
    lazy var apiKey: String = {
        return "live_Ja4hYajP0oh4y5OUyBBvitcEYIH6Zf7KtV48jFTQmxSD5yyMxLizz9CYsIue22a1"
//        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "ApiKey") as? String else {
//            fatalError("ApiKey must not be empty in plist")
//        }
//        return apiKey
    }()
//    lazy var apiBaseURL: String = {
//        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
//            fatalError("ApiBaseURL must not be empty in plist")
//        }
//        return apiBaseURL
//    }()
    lazy var imagesBaseURL: String = {
        return "https://api.thecatapi.com/v1/images/search"
//        guard let imageBaseURL = Bundle.main.object(forInfoDictionaryKey: "ImageBaseURL") as? String else {
//            fatalError("ApiBaseURL must not be empty in plist")
//        }
//        return imageBaseURL
    }()
}



//Use it as the 'x-api-key' header when making any request to the API, or by adding as a query string parameter e.g. 'api_key=live_Ja4hYajP0oh4y5OUyBBvitcEYIH6Zf7KtV48jFTQmxSD5yyMxLizz9CYsIue22a1'
