//
//  NetworkManager.swift
//  T2_ToDoListApp
//
//  Created by Knapptan on 10.02.2025.
//
import Foundation

final class NetworkManager {
    static let shered = NetworkManager()
    private init() {}
    
    private let apiUrl = "https://drive.google.com/file/d/1MXypRbK2CS9fqPhTtPonn580h1sHUs2W/view?usp=sharing"
    
    func fetchTodos(completion: @escaping (Result<[APITodo], Error>) -> Void) {
        guard let url = URL(string: apiUrl) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "No Data", code: 1)))
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response.todos))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
