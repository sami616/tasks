
//  TodoList.swift
//  test
//
//  Created by Samuel Resua on 24/08/2020.
//  Copyright © 2020 Samuel Resua. All rights reserved.
//

import SwiftUI


struct TaskList: View {
    @ObservedObject var taskStore = TaskStore()
    @State var showSheet = false
    @State var hideCompleted = false
    @Environment(\.presentationMode) var presentation
    
    func toggleSheet() {
        self.showSheet.toggle()
    }
    
    func toggleComplete() {
        withAnimation {
            self.hideCompleted.toggle()
        }
    }
    
    
    func moveRow(from source: IndexSet, to destination: Int) {
        self.taskStore.tasks.move(fromOffsets: source, toOffset: destination)
    }
    
    func deleteRow(at offsets: IndexSet) {
        self.taskStore.tasks.remove(atOffsets: offsets)
    }
    
    var incomplete: [Task] {
        return taskStore.tasks.filter { !$0.completed }
    }
    
    var body: some View {
        
        switch taskStore.status {
        case .idle: EmptyView()
        case .loading:
            if #available(iOS 14.0, *) {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .pink)).scaleEffect(1.5)
            } else {
                Text("Loading")
            }
        case .error: Text("Error")
        case .success:
            NavigationView {
                VStack {
                    List {
                        ForEach(hideCompleted ? incomplete : taskStore.tasks) { task in
                            TaskRow(task: task)
                        }
                        .onMove(perform: moveRow)
                        .onDelete (perform: deleteRow)
                    }
                    .listStyle(PlainListStyle())
                    Button( action: toggleSheet ) {
                        Image(systemName: "plus.circle")
                        Text("Add task")
                    }
                    .foregroundColor(.pink)
                    .sheet(isPresented: $showSheet) {
                        TaskAdd(toggleSheet: self.toggleSheet, tasks: self.$taskStore.tasks )
                    }
                }
                .navigationBarTitle("Tasks")
                .navigationBarItems(
                    leading: !taskStore.tasks.isEmpty ? EditButton() : nil,
                    trailing:  !taskStore.tasks.isEmpty ? Button( action: toggleComplete ) {
                        Text(hideCompleted ? "Show completed": "Hide completed")
                    } : nil
                ).foregroundColor(.pink)
                
                
            }
            
        }
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList()
    }
}
