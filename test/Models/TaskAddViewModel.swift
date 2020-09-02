import SwiftUI

final class TaskAddViewModel: ObservableObject {
    @Published var taskName = ""
    @ObservedObject var taskListVM: TaskListViewModel

    

    
    init(taskListVM: TaskListViewModel){
        self.taskListVM = taskListVM
    }
    
    private func addRow(){
        self.taskListVM.tasks.insert(TaskRowViewModel(task: Task(title: self.taskName)), at: 0)
    }
    
    func onAdd(){
        taskListVM.toggleSheet()
        addRow()
    }
    

}
