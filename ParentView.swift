//
//  ParentView.swift
//  Stock
//
//  Created by Jedidiah Too on 26/8/25.
//

import SwiftUI

struct ParentView: View {
    @StateObject var store = TaskStore()
    @State private var showChild = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(store.items.sorted(by: { $0.importance > $1.importance })) { item in
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text("Due: \(item.date.formatted(date: .abbreviated, time: .omitted)) (\(item.remaining))")
                                .font(.subheadline)
                                .foregroundColor(.red)
                            HStack {
                                Text("Priority Level: \(item.importance)")
                            }
                            .font(.subheadline)
                    }
                    .onTapGesture {
                        if let index = store.items.firstIndex(where: { $0.id == item.id }) {
                            store.items.remove(at: index)
                        }
                    }
                }
            }
            Button(action: {
                showChild = true
            }) {
                Text("Add Item")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .navigationTitle("HW List")
        .bold()
        .sheet(isPresented: $showChild) {
            ChildView(items: $store.items)
                .presentationDetents([.large])
                .presentationDragIndicator(.hidden)
        }
    }
}
}


#Preview {
    ParentView()
}
