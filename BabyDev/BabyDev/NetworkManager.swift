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
    
    func getRequest<T: Decodable>(tab: String?, location: String?, jobType: String?, fromURL url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        // Create the request
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        if location != nil {
            components.queryItems = [URLQueryItem(name: "location", value: location ?? nil)]
        }
        
        if jobType != nil {
            components.queryItems = [URLQueryItem(name: "jobType", value: jobType ?? nil)]
        }
        
        if tab != nil {
            components.queryItems = [URLQueryItem(name: "tab", value: tab ?? nil)]
        }
            var request = buildRequest(from: components.url!, httpMethod: HttpMethod.get)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \( UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")
        
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
    
    func getJobDetailsRequest<T: Decodable>(id: Int, fromURL url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        // Create the request
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        components.queryItems = [URLQueryItem(name: "id", value: String(id))]
        
        var request = buildRequest(from: components.url!, httpMethod: HttpMethod.get)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \( UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")
        
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
    
    func getRecommendedJobsRequest<T: Decodable>(tab: String?, location: String?, jobType: String?, fromURL url: URL, completion: @escaping (Result<T, Error>) -> Void)  {
        let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        // Create the request
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        if let location = location {
            components.queryItems = [URLQueryItem(name: "location", value: location)]
        }
        
        if let jobType = jobType {
            components.queryItems = [URLQueryItem(name: "jobType", value: jobType)]
        }
        
        if let tab = tab {
            components.queryItems = [URLQueryItem(name: "tab", value: tab)]
        }
        
        guard components.url != nil else {
            completionOnMain(.failure(ManagerErrors.invalidResponse))
            return
        }
        
        // Create the request
        var request = buildRequest(from: url, httpMethod: HttpMethod.get)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 120
        
        let session = URLSession(configuration: configuration)
        
        let urlSession = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completionOnMain(.failure(error))
                return
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                return completionOnMain(.failure(ManagerErrors.invalidResponse))
            }
            
            if !(200..<300).contains(urlResponse.statusCode) {
                return completionOnMain(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
            }
            
            guard let data = data else {
                return completionOnMain(.failure(ManagerErrors.invalidResponse))
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                UserDefaults.standard.set(data, forKey: "fetchedData")
                completionOnMain(.success(result))
            } catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
                completionOnMain(.failure(error))
            }
        }
        
        urlSession.resume()
    }
    
    func postUserDetailsRequest<T: Codable>(fromURL url: URL, newPhoneNumber: String, task: T, completion: @escaping (Result<T, Error>) -> Void) {
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        components.queryItems = [URLQueryItem(name: "newPhoneNumber", value: newPhoneNumber)]

        // Create the request
        var request = buildRequest(from: components.url!, httpMethod: HttpMethod.patch)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \( UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")
        
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
    
    func addJobRequest<T: Codable>(fromURL url: URL, model: JobModel, completion: @escaping (Result<T, Error>) -> Void) {
        
        do {
            let jsonData = try JSONEncoder().encode(model)
            
            // Create the request
            var request = buildRequest(from: url, httpMethod: HttpMethod.post)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \( UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")
            request.httpBody = Data(jsonData)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if let data = data {
                        print(String(data: data, encoding: .utf8)!)
                    }
                }
            }
            task.resume()
        }
        catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
            }
        }
    
    func getApplicantsRequest<T: Decodable>(jobId: Int, fromURL url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        // Create the request
        // Add the jobId as a query parameter in the request URL
        let urlWithJobId = url.appending(queryItems: [URLQueryItem(name: "jobId", value: "\(jobId)")])
        
            var request = buildRequest(from: urlWithJobId, httpMethod: HttpMethod.get)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \( UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")
        
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
    
    func getProfileRequest<T: Decodable>(tab: String?, email: String?, fromURL url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        // Create the request
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        if tab != nil {
            components.queryItems = [URLQueryItem(name: "tab", value: tab ?? nil)]
        }
        
        if email != nil {
            components.queryItems = [URLQueryItem(name: "email", value: email ?? nil)]
        }
        
            var request = buildRequest(from: components.url!, httpMethod: HttpMethod.get)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \( UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")
        
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
    
    func editJobRequest<T: Codable>(fromURL url: URL, jobId: Int, model: JobModel, completion: @escaping (Result<T, Error>) -> Void) {
        // Add the jobId as a query parameter in the request URL
        let urlWithUserID = url.appending(queryItems: [URLQueryItem(name: "jobId", value: "\(jobId)")])
        do {
            let jsonData = try JSONEncoder().encode(model)
            // Create the request
            var request = buildRequest(from: urlWithUserID, httpMethod: HttpMethod.put)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \( UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")
            
            request.httpBody = Data(jsonData)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if let data = data {
                        print(String(data: data, encoding: .utf8)!)
                    }
                }
            }
            task.resume()
        }
        catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
            }
        }
            
    func applyJob(url: URL, jobId: Int, completion: @escaping (Int?, Error?) -> Void) {
        // Add the jobId as a query parameter in the request URL
        let urlWithUserID = url.appending(queryItems: [URLQueryItem(name: "jobId", value: "\(jobId)")])
       
        // Create the request
        var request = buildRequest(from: urlWithUserID, httpMethod: HttpMethod.post)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \( UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, nil)
                return
            }
            completion(httpResponse.statusCode, nil)
        }
        task.resume()
    }

    
    func addJobToFavoritesRequest<T: Codable>(fromURL url: URL, jobId: Int, isfavorite: Bool, task: T, completion: @escaping (Result<T, Error>) -> Void) {
        
        // Add the jobId as a query parameter in the request URL
        let urlWithUserID = url.appending(queryItems: [URLQueryItem(name: "jobId", value: "\(jobId)")])
        let finalURL = urlWithUserID.appending(queryItems: [URLQueryItem(name: "isFavorite", value: "\(isfavorite)")])

        // Create the request
        var request = buildRequest(from: finalURL, httpMethod: HttpMethod.post)
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
                if data != nil {
                    if httpResponse.statusCode == 200 {
                        completion(.success(task))
                    }
                }
            }
        }
        task.resume()
    }
    
    func acceptRequestRecruiterRequest<T: Codable>(fromURL url: URL, email: String, task: T, completion: @escaping (Result<T, Error>) -> Void) {
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        components.queryItems = [URLQueryItem(name: "email", value: email)]

        // Create the request
        var request = buildRequest(from: components.url!, httpMethod: HttpMethod.patch)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \( UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")
        
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
    
    func declineRecruiterRequestRequest<T: Codable>(fromURL url: URL, email: String, completion: @escaping (Result<T, Error>) -> Void) {
        
        // Create the request
        let urlWithUserID = url.appending(queryItems:[URLQueryItem(name: "email", value: email)])
        var request = buildRequest(from: urlWithUserID, httpMethod: HttpMethod.delete)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \( UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")
                
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                if let data = data {
                    print(String(data: data, encoding: .utf8)!)
                }
            }
        }
        task.resume()
    }
    
    func addUserPhotoRequest<T: Codable>(fromURL url: URL, array: [UInt8]?, completion: @escaping (Result<T, Error>) -> Void) {
        
        // Create the request
        var request = buildRequest(from: url, httpMethod: HttpMethod.patch)
        request.setValue("Bearer \( UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")

        request.httpBody = Data(array ?? [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                if let data = data {
                    print(String(data: data, encoding: .utf8)!)
                }
            }
        }
        task.resume()
    }
    
    func editUserEducationRequest<T: Codable>(fromURL url: URL, email: String?, model: EducationModel, completion: @escaping (Result<T, Error>) -> Void) {
        
        // Create the request
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        if email != nil {
            components.queryItems = [URLQueryItem(name: "email", value: email ?? nil)]
        }
        do {
            let jsonData = try JSONEncoder().encode(model)
            
            var request = buildRequest(from: components.url!, httpMethod: HttpMethod.put)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \( UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")
            
            request.httpBody = Data(jsonData)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if let data = data {
                        print(String(data: data, encoding: .utf8)!)
                    }
                }
            }
            task.resume()
        }
        catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
            }
        }
    
    func addUserEducationRequest<T: Codable>(fromURL url: URL, email: String?, model: EducationModel, completion: @escaping (Result<T, Error>) -> Void) {
        
        // Create the request
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        if email != nil {
            components.queryItems = [URLQueryItem(name: "email", value: email ?? nil)]
        }
        do {
            let jsonData = try JSONEncoder().encode(model)
            
            var request = buildRequest(from: components.url!, httpMethod: HttpMethod.post)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \( UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")
            
            request.httpBody = Data(jsonData)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if let data = data {
                        print(String(data: data, encoding: .utf8)!)
                    }
                }
            }
            task.resume()
        }
        catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
            }
        }
    
    func addUserExperienceRequest<T: Codable>(fromURL url: URL, email: String?, model: ExperienceModel, completion: @escaping (Result<T, Error>) -> Void) {
        
        // Create the request
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        if email != nil {
            components.queryItems = [URLQueryItem(name: "email", value: email ?? nil)]
        }
        do {
            let jsonData = try JSONEncoder().encode(model)
            
            var request = buildRequest(from: components.url!, httpMethod: HttpMethod.post)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \( UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")
            
            request.httpBody = Data(jsonData)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if let data = data {
                        print(String(data: data, encoding: .utf8)!)
                    }
                }
            }
            task.resume()
        }
        catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
            }
        }
    
    func addUserSkillRequest<T: Codable>(fromURL url: URL, email: String?, model: SkillModel, completion: @escaping (Result<T, Error>) -> Void) {
        
        // Create the request
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        if email != nil {
            components.queryItems = [URLQueryItem(name: "email", value: email ?? nil)]
        }
        do {
            let jsonData = try JSONEncoder().encode(model)
            
            var request = buildRequest(from: components.url!, httpMethod: HttpMethod.post)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \( UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")
            
            request.httpBody = Data(jsonData)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if let data = data {
                        print(String(data: data, encoding: .utf8)!)
                    }
                }
            }
            task.resume()
        }
        catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
            }
        }
    
    func removeUserEducationRequest<T: Codable>(fromURL url: URL, email: String?, id: String?, completion: @escaping (Result<T, Error>) -> Void) {
        
        // Create the request
 
        let urlWithUserID = url.appending(queryItems:[URLQueryItem(name: "email", value: email ?? nil)])

        let finalURL = urlWithUserID.appending(queryItems:[URLQueryItem(name: "id", value: id ?? nil)])
        
        var request = buildRequest(from: finalURL, httpMethod: HttpMethod.delete)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \( UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")
                
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                if let data = data {
                    print(String(data: data, encoding: .utf8)!)
                }
            }
        }
        task.resume()
    }
    
    func editUserExperienceRequest<T: Codable>(fromURL url: URL, email: String?, model: ExperienceModel, completion: @escaping (Result<T, Error>) -> Void) {
        
        // Create the request
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        if email != nil {
            components.queryItems = [URLQueryItem(name: "email", value: email ?? nil)]
        }
        do {
            let jsonData = try JSONEncoder().encode(model)
            
            var request = buildRequest(from: components.url!, httpMethod: HttpMethod.put)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \( UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")
            
            request.httpBody = Data(jsonData)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse.statusCode)
                    if let data = data {
                        print(String(data: data, encoding: .utf8)!)
                    }
                }
            }
            task.resume()
        }
        catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
            }
           // task.resume()
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
            var request = buildRequest(from: components.url!, httpMethod: HttpMethod.get)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \( UserDefaults.standard.value(forKey: "token")!)", forHTTPHeaderField: "Authorization")
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
        case patch
        case put
        case delete
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
        case .patch:
            request.httpMethod = "PATCH"
        case .put:
            request.httpMethod = "PUT"
        case .delete:
            request.httpMethod = "DELETE"
        }
        return request
    }
}
