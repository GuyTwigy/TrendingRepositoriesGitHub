//
//  NetworkManager.swift
//  TrendingRepositoriesGitHub
//
//  Created by Guy Twig on 11/04/2022.
//

import Foundation

class NetworkManager {
    
    static var shared = NetworkManager()
    var baseUrl = "https://api.github.com/search/repositories?"
    
    func getYesterdayRepositories(page: Int = 1, callBack: @escaping (Bool, [Items]?) -> Void) {
        
        let queries = "q=created:\(UtilsNetworkManager.shared.getYesterdayDate())..\(UtilsNetworkManager.shared.getTodayDate())&sort=stars&order=desc&page=\(page)"
        let apiUrl = baseUrl + queries
        
        guard let url = URL(string: apiUrl) else {
            print("Failure to load Repositories")
            return callBack(false, nil)
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Failure to load Repositories")
                return callBack(false, nil)
            }
            do {
                let response = try JSONDecoder().decode(Repositories.self, from: data)
                callBack(true, response.items)
            } catch {
                print("Failure to load Repositories")
                callBack(false, nil)
            }
        }
        task.resume()
    }
    
    func getLastWeekRepositories(page: Int = 1, callBack: @escaping (Bool, [Items]?) -> Void) {
        
        let queries = "q=created:\(UtilsNetworkManager.shared.getLastWeekDate())..\(UtilsNetworkManager.shared.getTodayDate())&sort=stars&order=desc&page=\(page)"
        let apiUrl = baseUrl + queries
        
        guard let url = URL(string: apiUrl) else {
            print("Failure to load Repositories")
            return callBack(false, nil)
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Failure to load Repositories")
                return callBack(false, nil)
            }
            do {
                let response = try JSONDecoder().decode(Repositories.self, from: data)
                callBack(true, response.items)
            } catch {
                print("Failure to load Repositories")
                callBack(false, nil)
            }
        }
        task.resume()
    }
    
    func getLastMonthRepositories(page: Int = 1, callBack: @escaping (Bool, [Items]?) -> Void) {
        
        let queries = "q=created:\(UtilsNetworkManager.shared.getLastMonthDate())..\(UtilsNetworkManager.shared.getTodayDate())&sort=stars&order=desc&page=\(page)"
        let apiUrl = baseUrl + queries
        
        guard let url = URL(string: apiUrl) else {
            print("Failure to load Repositories")
            return callBack(false, nil)
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Failure to load Repositories")
                return callBack(false, nil)
            }
            do {
                let response = try JSONDecoder().decode(Repositories.self, from: data)
                callBack(true, response.items)
            } catch {
                print("Failure to load Repositories")
                callBack(false, nil)
            }
        }
        task.resume()
    }
}
