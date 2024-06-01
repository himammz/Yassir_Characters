//
//  HTTPRequest.swift
//  Yassir_Character
//
//  Created by Ibrahim Mostafa on 29/05/2024.
//


import Foundation

class HTTPRequest{
    
    enum HTTPMethod:String{
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    enum NetworkError: Error {
        case invalidURL
        case requestFailed
    }

    
    enum EndPoint{
        
        static let baseUrl = "https://rickandmortyapi.com"
        static let baseApiURL = EndPoint.baseUrl + "/api"
        
        
        case getCharacters(withStatus: String?)
        
        var stringValue:String{
            switch self {
            case .getCharacters(let withStatus):
                var endpoint =  EndPoint.baseApiURL + "/character"
                endpoint += withStatus == nil ? "" : "?status=\(withStatus ?? "")"
                return endpoint
            }
        }
        
        var url:URL{
            let escapedString =  stringValue.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) ?? ""
            return URL(string:escapedString)!
            
        }
        
    }
    
    class func request(url:URL, httpMethod:HTTPMethod, parameters:[String:Any] = [:], headers:[String:String] = ["Accept":"application/json","Content-Type":"application/json"] ) async throws -> Data {
        
        
        var request = URLRequest(url: url,cachePolicy: .reloadIgnoringLocalCacheData)
        request.httpMethod = httpMethod.rawValue
        request.allHTTPHeaderFields = headers
        
        
        if  httpMethod != .get {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters , options: .fragmentsAllowed)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.isResponseOK() else {
            throw NetworkError.requestFailed
        }
        
        return data
    }
    
    
    
    class func decode<T: Decodable> (type: T.Type , data: Data) -> T? {
        let decoder = JSONDecoder()
        do{
            let object = try decoder.decode(type.self, from: data)
            return object
        }catch{
            return nil
        }
    }
    
    
    
}



extension HTTPURLResponse {
    func isResponseOK() -> Bool {
        return (200...299).contains(self.statusCode)
    }
}


