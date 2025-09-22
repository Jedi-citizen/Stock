//
//  ChildView.swift
//  TaskTracker
//
//  Created by Jedidiah Too on 26/8/25.
//

import SwiftUI

struct ChildView: View {
    @Binding var items: [Item]
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name: String = ""
    @State private var date: Date = Date()
    @State private var importance: Int = 1
    
    var body: some View {
        VStack() {
            Spacer()
            Text("Add Assignment")
                .bold()
                .font(.largeTitle)
            Spacer()
            VStack() {
                Spacer()
                Spacer()
                Spacer()
                TextField("HW Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocorrectionDisabled(true)
                    .frame(width: 360, height: 100)
                
                Stepper("Importance: \(importance)",
                        value: $importance, in: 1...10
                )
                .padding(-5)
                .frame(width: 320, height: 10)
                .bold()

                DatePicker("Enter Due Date", selection: $date, in: Date()..., displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
                
                Button(action: {
                    let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !trimmedName.isEmpty else { return }
                    let newItem = Item(name: trimmedName, date: date, importance: importance)
                    items.append(newItem)
                    
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Submit")
                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            .navigationTitle("Add Assignment")
        }
    }
}

#Preview {
    ChildView(items: .constant([]))
}
