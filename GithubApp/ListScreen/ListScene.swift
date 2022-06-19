//
//  ContentView.swift
//  SwiftUICharts
//
//  Created by Vinay Devdikar on 14/06/22.
//

import SwiftUI

struct ListScene: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationView {
            if viewModel.isLoading {
                ZStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                }
            }
        
            VStack(alignment: .center, spacing: 0.0) {
                TextField("Enter github username", text: $viewModel.gitUserName)
                    .padding([.leading, .trailing], Constant.baseUnit * 2.0)
                    .padding([.top, .bottom], Constant.baseUnit)
                    .multilineTextAlignment(.leading)
                    .onSubmit {
                        viewModel.isLoading = true
                        viewModel.fetchUserDetails()
                    }
                List(viewModel.dataTypeList) { dataType in
                    VStack(alignment: .leading, spacing: Constant.baseUnit) {
                        Text(dataType.name)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .font(.title)
                            .lineLimit(nil)
                            .padding(.leading, 0.0)
                        Text(dataType.description)
                            .fontWeight(.regular)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .font(.body)
                        HStack(alignment: .center, spacing: Constant.baseUnit) {
                            Text("Stars: \(dataType.stars)")
                                .fontWeight(.light)
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.leading)
                                .font(.footnote)
                                .padding(.leading, 0.0)
                            
                            Text("Forks: \(dataType.forks)")
                                .fontWeight(.light)
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.leading)
                                .font(.footnote)
                                .padding(.leading, 0.0)
                            
                            Text("Language: \(dataType.language)")
                                .fontWeight(.light)
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.leading)
                                .font(.footnote)
                                .padding(.leading, 0.0)
                        }
                    }
                }
              
            }.navigationTitle("Home")
        }.navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListScene()
    }
}
