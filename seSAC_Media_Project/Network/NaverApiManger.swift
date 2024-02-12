//
//  NaverAPImanger.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/12/24.
//

import Foundation
import Alamofire


enum ApiError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}

struct NaverApiManager {

    static let shared = NaverApiManager()
    
    typealias CompletionHandler = (ProfileImgModel?, ApiError?) -> Void
    
    func callRequest(text: String, start:Int, sortType:String, completionHandler:@escaping CompletionHandler) {
        
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let strStart = String(start)
        
//        let link = "https://openapi.naver.com/v1/search/image"
        
        let scheme = "https"
        let host = "openapi.naver.com"
        let path = "/v1/search/image"
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "display", value: "30"),
            URLQueryItem(name: "start", value: strStart),
            URLQueryItem(name: "sort", value: sortType)
        ]
        
        guard let notNilurl = component.url else{
            print("component.url 오류입니다")
            return
        }
        
        var url = URLRequest(url: notNilurl)
        
        url.addValue(APIkey.NAVER_Clientid, forHTTPHeaderField: "X-Naver-Client-Id")
        url.addValue(APIkey.NAVER_ClientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")

        url.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    print("네트워크 통신 실패")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                //네트워크 통신 성공
                
                guard let data = data else{
                    print("통신은 성공했지만, 데이터가 안옴")
                    completionHandler(nil, .noData)
                    return
                }
         
                guard let response = response as? HTTPURLResponse else {
                    print("통신은 성공했지만, 응답값(ex.상태코드)이 오지 않음")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("통신은 성공했지만, 올바른 값이 오지 않은 상태")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(ProfileImgModel.self, from: data)
    
                    completionHandler(result, nil)
                } catch {
                    print(error)
                    completionHandler(nil, .invalidData)
                }
            }
        }.resume()

    }
}
