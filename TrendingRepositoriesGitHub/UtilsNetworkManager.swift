//
//  UtilsNetworkManager.swift
//  TrendingRepositoriesGitHub
//
//  Created by Guy Twig on 10/04/2022.
//

import Foundation

class UtilsNetworkManager {
    
    static var shared = UtilsNetworkManager()
    var baseUrl = "https://api.github.com/search/repositories?"
    
    func getTodayDate() -> String {
        let todayDate = Calendar(identifier: .iso8601).date(byAdding: .second, value: -1, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .init(identifier: .iso8601)
        dateFormatter.locale = .init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayDateString = dateFormatter.string(from: todayDate)
        return todayDateString
    }
    
    func getYesterdayDate() -> String {
        let yesterdayDate = Calendar(identifier: .iso8601).date(byAdding: .day, value: -1, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .init(identifier: .iso8601)
        dateFormatter.locale = .init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let yesterdayDateString = dateFormatter.string(from: yesterdayDate)
        return yesterdayDateString
    }
    
    func getLastWeekDate() -> String {
        let lastWeekDate = Calendar(identifier: .iso8601).date(byAdding: .weekOfYear, value: -1, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .init(identifier: .iso8601)
        dateFormatter.locale = .init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let lastWeekDateString = dateFormatter.string(from: lastWeekDate)
        return lastWeekDateString
    }
    
    func getLastMonthDate() -> String {
        let lastMonthDate = Calendar(identifier: .iso8601).date(byAdding: .month, value: -1, to: Date())!
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = .init(identifier: .iso8601)
        dateFormatter.locale = .init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let lastMonthDateString = dateFormatter.string(from: lastMonthDate)
        return lastMonthDateString
    }
    
    func getYesterdayRepositories(page: Int = 1, callBack: @escaping (Bool, [Items]?) -> Void) {
        
        let queries = "q=created:\(getYesterdayDate())..\(getTodayDate())&sort=stars&order=desc&page=\(page)"
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
                return callBack(true, response.items)
            } catch {
                print("Failure to load Repositories")
                return callBack(false, nil)
            }
        }
        task.resume()
    }
    
    func getLastWeekRepositories(page: Int = 1, callBack: @escaping (Bool, [Items]?) -> Void) {
        
        let queries = "q=created:\(getLastWeekDate())..\(getTodayDate())&sort=stars&order=desc&page=\(page)"
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
                return callBack(true, response.items)
            } catch {
                print("Failure to load Repositories")
                return callBack(false, nil)
            }
        }
        task.resume()
    }
    
    func getLastMonthRepositories(page: Int = 1, callBack: @escaping (Bool, [Items]?) -> Void) {
        
        let queries = "q=created:\(getLastMonthDate())..\(getTodayDate())&sort=stars&order=desc&page=\(page)"
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
                return callBack(true, response.items)
            } catch {
                print("Failure to load Repositories")
                return callBack(false, nil)
            }
        }
        task.resume()
    }
}



