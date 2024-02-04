//
//  TMDBAPI.swift
//  seSAC_Media_Project
//
//  Created by Sammy Jung on 2/4/24.
//
import Alamofire
import Foundation

enum TMDBAPI {
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    case trending
    case topRated
    case popular
    case dramaDetail(id:Int)
    case casting(id: Int)
    case recommend(id: Int)
    case search(query: String)
    
    var endpoint: URL {
        switch self {
        case .trending:
            return URL(string: baseURL + "trending/tv/week")!
        case .topRated:
            return URL(string: baseURL + "tv/top_rated")!
        case .popular:
            return URL(string: baseURL + "tv/popular")!
        case .dramaDetail(let id):
            return URL(string: baseURL + "tv/\(id)")!
        case .casting(let id):
            return URL(string: baseURL + "tv/\(id)/aggregate_credits")!
        case .recommend(let id):
            return URL(string: baseURL + "tv/\(id)/recommendations")!
            
        case .search(query: let query):
            return URL(string: baseURL + "search/tv")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIkey.TMDB]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .trending:
            ["":""]
        case .topRated:
            ["":""]
        case .popular:
            ["":""]
        case .dramaDetail(let id):
            ["language":"ko-KR"]
        case .casting(let id):
            ["":""]
        case .recommend(let id):
            ["":""]
        case .search(query: let query):
            ["language": "ko-KR", "query": query]
        }
    }
}
