import SwiftUI

#if DEBUG
let testDataTasks = [
    Task(title: "Task 1"),
    Task(title: "Task 2"),
    Task(title: "Task 3"),
    Task(title: "Task 4")
]
#endif

final class TaskListViewModel: ObservableObject {
    @Published var taskName = ""
    @Published var tasks = [TaskRowViewModel]()
    @Published var showSheet = false
    @Published var hideCompleted = false
    @Published var incomplete = [TaskRowViewModel]()
    
    init() {
        self.tasks = testDataTasks.map { task in TaskRowViewModel(task: task) }
    }
    
    func toggleComplete() {
        withAnimation {
            self.hideCompleted.toggle()
        }
    }
    
    func moveRow(from source: IndexSet, to destination: Int) {
        self.tasks.move(fromOffsets: source, toOffset: destination)
    }
    
    func deleteRow(at offsets: IndexSet) {
        self.tasks.remove(atOffsets: offsets)
    }
    
    func toggleSheet() {
        self.showSheet.toggle()
    }
}
