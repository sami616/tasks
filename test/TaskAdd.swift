//
//  TodoDetail.swift
//  test
//
//  Created by Samuel Resua on 24/08/2020.
//  Copyright © 2020 Samuel Resua. All rights reserved.
//

import SwiftUI

struct TaskAdd: View {
    var toggleSheet: () -> Void
    @State var taskName: String = ""
    @Binding var tasks: [Task]
    
    func addTodo(){
        self.tasks.insert(Task(id: UUID().hashValue, title: self.taskName), at: 0)
    }
    
    func onAdd(){
        addTodo();
        toggleSheet();
    }
    
    var body: some View {
        
        let taskNameBinding = Binding<String>(
            get: { self.taskName },
            set: { self.taskName = $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        )
        
        return VStack {
            VStack {
                Text("Task")
                TextField("Learn SwiftUI", text: taskNameBinding )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.pink)
                    .font(.largeTitle)
            }
            .padding()
            
            Button(action: onAdd) {
                    Text("Add").font(.callout)
                    Image(systemName: "plus.circle")
                        .frame(width: 20, height: 20)
            }
            .frame(width: 100, height: 15, alignment: .center)
            .padding()
            .background(Color.pink)
            .opacity(taskName.isEmpty ? 0.5 : 1)
            .foregroundColor(.white)
            .cornerRadius(100)
            .animation(.spring())
            .disabled(taskName.isEmpty)
        }
    }
}

func togglePreview(){}

struct TaskAdd_Previews: PreviewProvider {
    static var previews: some View {
        TaskAdd(toggleSheet: togglePreview, tasks: .constant(TaskStore().tasks))
    }
}

