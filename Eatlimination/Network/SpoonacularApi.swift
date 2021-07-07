//
//  SpoonacularApi.swift
//  Eatlimination

import Foundation

class SpoonacularApi: BaseApi {
    
    private static var tasks: [String: URLSessionDataTask] = [:]
    
    static let apiKey = "5eb7eb69d4194fe684ea0b9285705dac"
    
    enum ImageSize: Int {
        case size100 = 100
        case size250 = 250
        case size500 = 500
    }
    
    enum Endpoints {

        static let base = "https://api.spoonacular.com/"
        static let base_mock = "http://192.168.2.13:8089/"
        static let images_base = "https://spoonacular.com/cdn/"

        case searchAutocomplete(String)
        case downloadImage(ImageSize, String)
        
        var stringValue: String {
            switch self {
            case .searchAutocomplete(let query): return "\(Endpoints.base)food/ingredients/autocomplete?apiKey=\(SpoonacularApi.apiKey)&number=20&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")&metaInformation=true"
            case .downloadImage(let size, let image): return "\(Endpoints.images_base)ingredients_\(size.rawValue)x\(size.rawValue)/\(image)"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
        
    }
    
    class func searchAutocomplete(query: String, completion: @escaping ([SpoonFoodAuto]?, Error?) -> Void) {
        
        taskForGETRequest(url: Endpoints.searchAutocomplete(query).url, responseType: [SpoonFoodAuto].self) { response, error in
            
            if let response = response {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
            
        }
        
    }
    
    class func downloadImage(imageFile: String, size: ImageSize = .size100, completion: @escaping (_ result: NSData?, _ error: Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoints.downloadImage(size, imageFile).url) { data, response, error in
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299, let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(data as NSData, nil)
            }
        }
        task.resume()

        if tasks[imageFile] == nil {
           tasks[imageFile] = task
        }
    }
    
    class func cancelDownload(_ imageFile: String?) {
        if let imageFile = imageFile {
            tasks[imageFile]?.cancel()
            if tasks.removeValue(forKey: imageFile) != nil {
                print("\(#function) task canceled: \(imageFile)")
            }
        }
    }
    
}
