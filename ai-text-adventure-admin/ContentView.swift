//
//  ContentView.swift
//  ai-text-adventure-admin
//
//  Created by Qiwei Li on 3/30/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("signedIn") var signedIn: Bool = false
    
    var body: some View {
        NavigationView {
//            if !signedIn {
//                SignInView()
//            }
            if signedIn {
                PromptView()
            }
            Text("Admin")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
