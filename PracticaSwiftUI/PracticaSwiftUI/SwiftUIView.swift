//
//  SwiftUIView.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 8/6/23.
//

import SwiftUI

struct SwiftUIView: View {
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
    
    var body: some View {
        VStack {
            List {
                ForEach(users) { user in
                    Text(user.username ?? "yo")
                }
            }
            Text("\(users.count)")
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
