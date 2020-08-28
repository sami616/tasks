//
//  Models.swift
//  test
//
//  Created by Samuel Resua on 24/08/2020.
//  Copyright © 2020 Samuel Resua. All rights reserved.
//

import SwiftUI


final class Task: ObservableObject, Identifiable, Decodable {
    
    var id: Int
    @Published var title: String
    @Published var completed: Bool
    
    enum CodingKeys: CodingKey {
        case id, title, completed
    }
    
    init(id: Int, title: String) {
        self.id = id
        self.title = title
        self.completed = false
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        completed = try container.decode(Bool.self, forKey: .completed)
    }
    
}

final class TaskStore: ObservableObject {
    
    enum networkStatus {
        case idle, loading, error, success
    }
    
    @Published var tasks: [Task] = [
        Task(id: 1, title: "Task 1"),
        Task(id: 2, title: "Task 2")
    ]
    @Published var error = false
    @Published var loading = false
    @Published var status: networkStatus = .idle
    
    init() {
         self.fetch()
    }

    func fetch(){
        
        DispatchQueue.main.async {
            self.loading = true;
            self.error = false
            self.status = .loading
        }
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/todos?userId=1") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    if let decodedData = try? JSONDecoder().decode([Task].self, from: data) {
                        DispatchQueue.main.async {
                            self.tasks = decodedData
                            self.loading = false;
                            self.error = false
                            self.status = .success
                        }
                        return
                    }
                    
                }
                DispatchQueue.main.async {
                    self.loading = false;
                    self.error = true
                    self.status = .error
                }
            }.resume()
        } else {
            DispatchQueue.main.async {
                self.loading = false;
                self.error = true
                self.status = .error
            }
            
        }
        
        
    }
}
