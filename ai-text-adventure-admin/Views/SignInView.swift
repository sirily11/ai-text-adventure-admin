//
//  LoginView.swift
//  ai-text-adventure-admin
//
//  Created by Qiwei Li on 3/30/23.
//

import SwiftUI

struct SignInView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var hasError: Bool = false
    
    @EnvironmentObject var promptModel: PromptModel
    
    var body: some View {
        Form {
            Text("Sign In")
            TextField("User name", text: $username)
            TextField("Password", text: $password)
            HStack {
                Spacer()
                Button("Sign In") {
                    Task {
                        await signIn()
                    }
                }
            }
        }
        .alert(isPresented: $hasError, content: {
            Alert(title: Text("Cannot login"))
        })
        .padding()
    }
    
    func signIn() async {
        self.hasError = false
        let success =  await promptModel.login(username: username, password: password)
        if !success {
            self.hasError = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
