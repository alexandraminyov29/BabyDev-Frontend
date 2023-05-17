//
//  NetworkManager.swift
//  BabyDev
//
//  Created by Alexandra Minyov on 06.03.2023.
//

import Foundation
import SwiftUI

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func postRequest<T: Codable>(fromURL url: URL, task: T, completion: @escaping (Result<T, Error>) -> Void) {
        
        // Create the request
        var request = buildRequest(from: url, httpMethod: HttpMethod.post)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let taskData = try! JSONEncoder().encode(task)
        request.httpBody = taskData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                if let data = data {
                    print(String(data: data, encoding: .utf8)!)
                    if httpResponse.statusCode == 200 {
                        completion(.success(task))
                    }
                }
            }
        }
        task.resume()
    }
    
    func getRequest<T: Decodable>(fromURL url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        // Create the request
        let request = buildRequest(from: url, httpMethod: HttpMethod.get)
        
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completionOnMain(.failure(error))
                return
            }
            
            guard let urlResponse = response as? HTTPURLResponse else { return completionOnMain(.failure(ManagerErrors.invalidResponse)) }
            if !(200..<300).contains(urlResponse.statusCode) {
                return completionOnMain(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
            }
            
            guard let data = data else { return }
            do {
                let users = try JSONDecoder().decode(T.self, from: data)
                completionOnMain(.success(users))
            } catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
                completionOnMain(.failure(error))
            }
        }
        urlSession.resume()
    }
    
    func applyJobRequest<T: Codable>(fromURL url: URL, jobId: Int, task: T, completion: @escaping (Result<T, Error>) -> Void) {
        
        // Add the jobId as a query parameter in the request URL
        let urlWithUserID = url.appending(queryItems: [URLQueryItem(name: "jobId", value: "\(jobId)")])
        var urlComponents = URLComponents(string: "http://localhost:8080/api/jobs/apply")
        urlComponents?.queryItems = [URLQueryItem(name: "jobId", value: "\(jobId)")]
        
        // Create the request
        var request = buildRequest(from: urlWithUserID, httpMethod: HttpMethod.post)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \( UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")
        let taskData = try! JSONEncoder().encode(task)
        
        request.httpBody = taskData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                if let data = data {
                    print(String(data: data, encoding: .utf8)!)
                    if httpResponse.statusCode == 200 {
                        completion(.success(task))
                    }
                }
            }
        }
        task.resume()
    }

    func searchRequest<T: Decodable>(keyword: String, fromURL url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        // Create the request
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            components.queryItems = [URLQueryItem(name: "keyword", value: keyword)]
            let request = buildRequest(from: components.url!, httpMethod: HttpMethod.get)
        
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                completionOnMain(.failure(error))
                return
            }
            
            guard let urlResponse = response as? HTTPURLResponse else { return completionOnMain(.failure(ManagerErrors.invalidResponse)) }
            if !(200..<300).contains(urlResponse.statusCode) {
                return completionOnMain(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
            }
            
            guard let data = data else { return }
            do {
                let users = try JSONDecoder().decode(T.self, from: data)
                completionOnMain(.success(users))
            } catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
                completionOnMain(.failure(error))
            }
        }
        urlSession.resume()
    }
    
    func loginRequest<T: Codable, U: Codable>(fromURL url: URL, task: T, responseType: U, completion: @escaping (Result<U, Error>) -> Void) {
        
        // Create the request
        var request = buildRequest(from: url, httpMethod: HttpMethod.post)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let taskData = try! JSONEncoder().encode(task)
        request.httpBody = taskData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                if let data = data {
                    print(String(data: data, encoding: .utf8)!)
                    if httpResponse.statusCode == 200 {
                        do {
                            let decodedResponse = try JSONDecoder().decode(U.self, from: data)
                            completion(.success(decodedResponse))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                }
            }
        }
        task.resume()
    }

}

extension NetworkManager {
    enum HttpMethod{
        case get
        case post
    }
}

enum ManagerErrors: Error { // Errors this class might return
    case invalidResponse
    case invalidStatusCode(Int)
}

private extension NetworkManager {
    func buildRequest(from url: URL, httpMethod: HttpMethod) -> URLRequest {
        var request = URLRequest(url: url)
        switch httpMethod {
        case .get:
            request.httpMethod = "GET"
        case .post:
            request.httpMethod = "POST"
        }
        return request
    }
}
