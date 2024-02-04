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
    
    func fetchTVImages(url: String,completehandler: @escaping(([Drama]) -> Void)){
        
        let url = baseUrl + "\(url)" + "?language=\(language)"
        
        let header = header
        
        AF.request(url, headers: header).responseDecodable(of: DramaModel.self) { response in
            switch response.result {
            case .success(let success):
//                print("success", success)
                completehandler(success.results)
            case .failure(let failure):
                print(failure)
            }
        }
        
    }
    
    func fetchTvSeasonInfo(id:Int, completehandler:@escaping((SeasonModel)->Void)){
        let url = "\(baseUrl)tv/\(id)?language=\(language)"
        
        let header = header
        
        AF.request(url, headers: header).responseDecodable(of: SeasonModel.self) { response in
            switch response.result {
            case .success(let success):
//                print("success", success)
                completehandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchTvCastingInfo(id:Int, completehandler:@escaping(([Actor])->Void)){
        let url = "\(baseUrl)tv/\(id)/aggregate_credits"
        
        let header = header
        
        AF.request(url, headers: header).responseDecodable(of: ActorModel.self) { response in
            switch response.result {
            case .success(let success):
//                print("success", success)
                completehandler(success.cast)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
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
