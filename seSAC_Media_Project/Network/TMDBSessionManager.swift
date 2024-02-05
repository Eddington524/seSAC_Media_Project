//
//  TMDBSessionManager.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/5/24.
//

import Foundation

enum apiError: Error {
    case failRequest
    case noData
    case invalidResponse
    case invalidData
    
    var errorMessage: String {
        switch self {
        case .failRequest:
            "네트워크 통신을 확인해주세요. 네트워크 설정으로 이동하겠습니까?"
        case .noData:
            "데이터가 없습니다"
        case .invalidResponse:
            "유효하지 않은 네트워크 응답입니다"
        case .invalidData:
            "유효하지 않은 데이터 응답입니다."
        }
    }
}

class TMDBSessionManager {
    static let shared = TMDBSessionManager()
    
    // 성공모델과, apiError model, error둘다 빼주기!
    func fetchDrama(api: TMDBAPI, completionHandler: @escaping(DramaModel?, apiError?) -> Void) {
        
        //1번 urlRequest로 가져오기
        var url = URLRequest(url: api.endpoint)
        
        //2번 addValue 인증키
        url.addValue(APIkey.TMDB, forHTTPHeaderField: "Authorization")
        
        //3번httpMethod
        url.httpMethod = "GET"
        
        //4번 URLSession 만들고 dataTask
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                //5번 각각 nil 처리
                
                guard error == nil else {
                    completionHandler(nil, .failRequest)
                    return
                }
                
                guard let data = data else{
                    completionHandler(nil, .noData)
                    return
                }
//                print(String(data: data, encoding: .utf8))
                
                guard let response = response as? HTTPURLResponse else {
                    print("통신은 성공했지만, 응답값(ex.상태코드)이 오지 않음")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("통신은 성공했지만, 올바른 값이 오지 않은 상태")
                    completionHandler(nil, .failRequest)
                    return
                }
                
                do{
                    //6번 do let result = try JsonDecoder().decode()catch
                    let result = try JSONDecoder().decode(DramaModel.self, from: data)
                    completionHandler(result,nil)
                    
                }catch{
                    completionHandler(nil, .invalidData)
                }
            }
            
        }.resume()
    
    }

}

