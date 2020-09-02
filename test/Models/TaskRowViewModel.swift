import SwiftUI

final class TaskRowViewModel: ObservableObject, Identifiable {
    @Published var task: Task
    
    init(task: Task){
        self.task = task
    }
    
    func toggleCompleted(){
        withAnimation {
            self.task.completed.toggle()
        }
    }
}
