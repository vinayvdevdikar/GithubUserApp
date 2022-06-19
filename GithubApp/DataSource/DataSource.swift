//
//  DataSource.swift
//  SwiftUICharts
//
//  Created by Vinay Devdikar on 14/06/22.
//

import Foundation
struct TableData: Identifiable {
    var id = UUID()
    let name: String
    let description: String
    let lastCommitSHA: String
    let stars: Int
    let forks: Int
    let language: String
}
