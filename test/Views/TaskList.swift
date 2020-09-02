import SwiftUI


struct TaskList: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    
    var body: some View {
        
        VStack{
            NavigationView {
                VStack {
                    List {
                        ForEach(taskListVM.hideCompleted ? taskListVM.incomplete : taskListVM.tasks) { task in
                            TaskRow(taskRowVM: task)
                        }
                        .onMove(perform: taskListVM.moveRow)
                        .onDelete (perform: taskListVM.deleteRow)
                    }
                    .listStyle(PlainListStyle())
                    
                    Button( action: taskListVM.toggleSheet ) {
                        Image(systemName: "plus.circle")
                        Text("Add task")
                    }.foregroundColor(.pink).sheet(isPresented: $taskListVM.showSheet) {
                        TaskAdd(taskAddVM: TaskAddViewModel(taskListVM: taskListVM))
                    }
                }
                .navigationBarTitle("Tasks")
                .navigationBarItems(
                    leading: !taskListVM.tasks.isEmpty ? EditButton() : nil,
                    trailing:  !taskListVM.tasks.isEmpty ? Button( action: taskListVM.toggleComplete ) {
                        Text(taskListVM.hideCompleted ? "Show completed": "Hide completed")
                    } : nil
                ).foregroundColor(.pink)
            }
            
        }
    }
}
