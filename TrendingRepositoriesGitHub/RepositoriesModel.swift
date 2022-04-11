//
//  RepositoriesModel.swift
//  TrendingRepositoriesGitHub
//
//  Created by Guy Twig on 10/04/2022.
//

import Foundation

struct ResponseRepositories: Decodable {
    let repositories: Repositories
}

struct Repositories: Decodable {
    let total_count: Int?
    let incomplete_results: Bool
    let items: [Items]?
}

struct Items: Decodable {
    let name: String?
    let owner: Owner?
    let html_url: String?
    let description: String?
    let created_at: String?
    let stargazers_count: Int?
    let language: String?
    let forks: Int?
}

struct Owner: Decodable {
    let login: String?
    let avatar_url: String?
}

