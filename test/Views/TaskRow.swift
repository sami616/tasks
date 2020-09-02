import SwiftUI

struct TaskRow: View {
    
    @ObservedObject var taskRowVM: TaskRowViewModel
    @State var textfieldColor = Color.black
    
    func handleFocus(editingChanged: Bool){
        if editingChanged {
            self.textfieldColor = Color.gray
        } else {
            self.textfieldColor = Color.black
        }
    }
    
    var body: some View {
        HStack {
            Button(action: taskRowVM.toggleCompleted) {
                ZStack {
                    Capsule()
                        .trim(from: 0, to: 1)
                        .stroke(style: StrokeStyle(lineWidth: 2))
                        .foregroundColor(.pink)
                    if(taskRowVM.task.completed){
                        Capsule()
                            .trim(from: 0, to: 1)
                            .frame(width: 10, height: 10)
                            .foregroundColor(.pink)
                            .transition(.scale)
                    }
                }
            }.frame(width: 20, height: 20)
            TextField("Update title", text: $taskRowVM.task.title, onEditingChanged: handleFocus).foregroundColor(taskRowVM.task.completed ? Color.pink : textfieldColor)
        }
    }
}
