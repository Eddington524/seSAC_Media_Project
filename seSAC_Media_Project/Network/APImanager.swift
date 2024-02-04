//
//  APImanager.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/2/24.
//

import Alamofire

class APImanager {
    
    static let shared = APImanager()
    let header: HTTPHeaders = ["Authorization": APIkey.TMDB]
    let baseUrl: String = "https://api.themoviedb.org/3/"
    let language: String = "ko-KR"
    
    func request<T: Decodable>(type: T.Type, api: TMDBAPI, completionHandler: @escaping((T)->Void)){
        
        AF.request(api.endpoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString), headers: api.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print("fail")
            }
        }
    }
    
}
