//
//  FoodsApi.swift
//  Eatlimination

import Foundation

class FDCApi: BaseApi {
    
    static let apiKey = "2r6VHsfRTM80vXyvez2Pm4Xedmu5Rk3d1vknOHxk"
    
    private static var tasks: [String: URLSessionDataTask] = [:]
    
    enum Endpoints {
        static let version = "v1"
        static let base = "https://api.nal.usda.gov/fdc"

        case search
        
        var stringValue: String {
            switch self {
            case .search: return "\(Endpoints.base)/\(Endpoints.version)/foods/search?api_key=\(FDCApi.apiKey)"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
        
    }
    
    class func searchFoods(query: String, pageIndex: Int, completion: @escaping (FoodsResponse?, Error?) -> Void) {
        let body = FoodsRequest(query: query, pageSize: 50)
        taskForPOSTRequest(url: Endpoints.search.url, responseType: FoodsResponse.self, body: body) { response, error in
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
}
