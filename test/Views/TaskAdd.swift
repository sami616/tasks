
import SwiftUI

struct TaskAdd: View {
    @ObservedObject var taskAddVM: TaskAddViewModel
    
    var body: some View {
        
        let taskNameBinding = Binding<String>(
            get: { self.taskAddVM.taskName },
            set: { self.taskAddVM.taskName = $0.trimmingCharacters(in: .whitespacesAndNewlines) }
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
            
            Button(action: taskAddVM.onAdd) {
                    Text("Add").font(.callout)
                    Image(systemName: "plus.circle")
                        .frame(width: 20, height: 20)
            }
            .frame(width: 100, height: 15, alignment: .center)
            .padding()
            .background(Color.pink)
            .opacity(taskAddVM.taskName.isEmpty ? 0.5 : 1)
            .foregroundColor(.white)
            .cornerRadius(100)
            .animation(.spring())
            .disabled(taskAddVM.taskName.isEmpty)
        }
    }
}
