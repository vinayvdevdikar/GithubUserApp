//
//  ListScene+ViewModel.swift
//  SwiftUICharts
//
//  Created by Vinay Devdikar on 15/06/22.
//

import SwiftUI

extension ListScene {
    @MainActor class ViewModel: ObservableObject {
        @Published var dataTypeList: [TableData] = [ ]
        @Published var gitUserName : String = ""
        @Published var isLoading: Bool = false
        
        func fetchUserDetails() {
            guard let url = URL(string: "https://api.github.com/users/\(self.gitUserName)/repos") else {
                self.isLoading = false
                return
            }
            print(url.absoluteString)
            let request = URLRequest(url: url)
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error in
                
                if let jsonData = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let list = try decoder.decode(RepoList.self, from: jsonData)
                        self.updateDataType(with: list)
                    } catch {
                        print(error)
                    }
                }
            })
            task.resume()
        }
        
        func updateDataType(with list: RepoList) {
            DispatchQueue.main.async {
                self.isLoading = false
                self.gitUserName = ""
                self.dataTypeList = list.map { repo in
                    return TableData(name: repo.name,
                              description: repo.repoDescription ?? "N/A",
                              lastCommitSHA: "",
                              stars: repo.stargazersCount,
                              forks: repo.forksCount,
                              language: repo.language ?? "-")
                }
            }
        }
    }
}


