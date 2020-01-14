//
//  PixavenClient.swift
//  Pixaven
//
//  Created by Dawid Płatek on 12/11/2019.
//  Copyright © 2019 Pixaven. All rights reserved.
//

import Foundation
import MobileCoreServices

class PixavenClient {
    let key: String
    var request: BaseRequest?
    
    private let sessionConfiguration = URLSessionConfiguration.default
    
    private lazy var session = {
        return URLSession(configuration: self.sessionConfiguration)
    }()
    
    init(key: String) {
        self.key = key
    }
    
    func fetch(url: URL) -> PixavenClient {
        request = FetchRequest(key: key, url: url)
        
        return self
    }
    
    func upload(fileUrl: URL) -> PixavenClient {
        request = UploadRequest(key: key, fileUrl: fileUrl)
        
        return self
    }
    
    func proxy(url: URL) -> PixavenClient {
        sessionConfiguration.connectionProxyDictionary = [
            kCFNetworkProxiesHTTPEnable as AnyHashable: true,
            kCFNetworkProxiesHTTPProxy as AnyHashable: url.absoluteString
        ]
        
        return self
    }

    func toJson(completionHandler: @escaping (Result<Data, Error>) -> Void) throws {
        request?.isBinary = false
        
        guard let urlRequest = request?.urlRequest else {
            throw PixavenError.unknownError
        }
        
        let requestData = try request?.data()

        let task = session.uploadTask(with: urlRequest, from: requestData) { (responseData, _, error) in
            if let responseData = responseData {
                completionHandler(.success(responseData))
                return
            }
            
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            completionHandler(.failure(PixavenError.unknownError))
        }
        
        task.resume()
    }
    
    func toImageData(completionHandler: @escaping (Result<Data, Error>) -> Void) throws {
        request?.isBinary = true
        
        guard let urlRequest = request?.urlRequest else {
            throw PixavenError.unknownError
        }
        
        let requestData = try request?.data()

        let task = session.uploadTask(with: urlRequest, from: requestData) { (responseData, response, error) in
            if let responseData = responseData {
                completionHandler(.success(responseData))
                return
            }
            
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            completionHandler(.failure(PixavenError.unknownError))
        }
        
        task.resume()
    }
    
    func adjust(_ parameters: [String: Any]) -> PixavenClient {
        request?.parameters["adjust"] = parameters
        
        return self
    }
    
    func auto(_ parameters: [String: Any]) -> PixavenClient {
        request?.parameters["auto"] = parameters
        
        return self
    }
    
    func border(_ parameters: [String: Any]) -> PixavenClient {
        request?.parameters["border"] = parameters
        
        return self
    }
    
    func crop(_ parameters: [String: Any]) -> PixavenClient {
        request?.parameters["crop"] = parameters
        
        return self
    }
    
    func mask(_ parameters: [String: Any]) -> PixavenClient {
        request?.parameters["mask"] = parameters
        
        return self
    }
    
    func output(_ parameters: [String: Any]) -> PixavenClient {
        request?.parameters["output"] = parameters
        
        return self
    }
    
    func padding(parameters: [String: Any]) -> PixavenClient {
        request?.parameters["padding"] = parameters
        
        return self
    }
    
    func resize(_ parameters: [String: Any]) -> PixavenClient {
        request?.parameters["resize"] = parameters
        
        return self
    }
    
    func response(_ parameters: [String: Any]) -> PixavenClient {
        request?.parameters["response"] = parameters
        
        return self
    }
    
    func scale(_ parameters: [String: Any]) -> PixavenClient {
        request?.parameters["scale"] = parameters
        
        return self
    }
    
    func store(_ parameters: [String: Any]) -> PixavenClient {
        request?.parameters["store"] = parameters
        
        return self
    }
    
    func filter(_ parameters: [String: Any]) -> PixavenClient {
        request?.parameters["filter"] = parameters
        
        return self
    }
    
    func watermark(_ parameters: [String: Any]) -> PixavenClient {
        request?.parameters["watermark"] = parameters
        
        return self
    }
    
    func webhook(_ parameters: [String: Any]) -> PixavenClient {
        request?.parameters["webhook"] = parameters
        
        return self
    }
    
    func cdn(_ parameters: [String: Any]) -> PixavenClient {
        request?.parameters["cdn"] = parameters
        
        return self
    }
    
    func flip(_ parameters: [String: Any]) -> PixavenClient {
        request?.parameters["flip"] = parameters
        
        return self
    }
}
