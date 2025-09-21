//
//  HomeView.swift
//  Stock
//
//  Created by Jedidiah Too on 3/9/25.
//


import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.green.ignoresSafeArea()
                VStack(spacing: 20){
                    Image(systemName: "checklist.checked")
                        .font(.system(size: 200))
                    NavigationLink{
                        ParentView()
                    } label: {
                        Text(" E  N  T  E  R ")
                            .bold()
                            .italic()
                            .font(.system(size: 50))
                            .foregroundColor(Color.white)
                            .overlay(
                                Text(" E  N  T  E  R ")
                                    .italic()
                                    .font(.system(size: 49))
                                    .foregroundColor(Color.black)
                                
                            )
                    }
                }
                .padding()
            }
        }
    }
}


#Preview {
    HomeView()
}
