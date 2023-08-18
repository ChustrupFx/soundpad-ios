//
//  MusicButtonComponent.swift
//  soundpad-ios
//
//  Created by Victor Soares on 18/08/23.
//

import SwiftUI

struct MusicButtonComponent: View {
    
    var name: String
    
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "pause.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
            
            
            Text(name).lineLimit(1)
            
            Spacer()
            
            Menu {
                Button(role: .destructive) {
                    
                } label: {
                    Label("Delete", image: "trash")
                }
            } label: {
                Image(systemName: "ellipsis.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
        }
        .padding()
        .cornerRadius(8, antialiased: true)
        .background(.blue)
        .foregroundColor(.white)
        .padding()
    }
}

struct MusicButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        MusicButtonComponent(name: "ASD")
    }
}
