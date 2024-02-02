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
    func fetchTVImages(url: String,completehandler: @escaping(([TV]) -> Void)){
        
        let url = baseUrl + "\(url)" + "?language=\(language)"
        
        let header = header
        
        AF.request(url, headers: header).responseDecodable(of: TvModel.self) { response in
            switch response.result {
            case .success(let success):
//                print("success", success)
                completehandler(success.results)
            case .failure(let failure):
                print(failure)
            }
        }
        
    }
    
    func fetchTvSeasonInfo(id:Int, completehandler:@escaping(([Season])->Void)){
        let url = "\(baseUrl)tv/\(id)?language=\(language)"
        
        let header = header
        
        AF.request(url, headers: header).responseDecodable(of: SeasonModel.self) { response in
            switch response.result {
            case .success(let success):
//                print("success", success)
                completehandler(success.seasons)
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
    
}
