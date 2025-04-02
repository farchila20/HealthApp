//
//  ContentView.swift
//HealthApp
//
//  Created by Fernando Archila on 29.03.25.
//



import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var isAuthenticating = false
    @State private var authURL = URL(string: "https://auth.example.com/oauth/authorize?client_id=your_client_id&redirect_uri=HealthApp://callback&response_type=code&scope=openid profile email")!
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false
    @State private var loginMode: LoginMode = .none
    @State private var shouldNavigate = false
    
    
    enum LoginMode {
        case none, basic, oauth
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment:  .center){
                Spacer()
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)
                
                Text("HealthApp")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("Username or Email", text: $email)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .padding(.horizontal,40)
                
                SecureField("Password", text: $password)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.blue, lineWidth: 2)
                    )
                    .padding(.horizontal,40)
                
                
                
                //              NavigationLink( destination: DocumentViewer()){
                //                
                //                      HStack {
                //                          Text(isAuthenticating ? "Signing In..." : "Sign in with Username or email")
                //                      }
                //                      .frame(maxWidth: .infinity)
                //                      .padding()
                //                      .background(Color.green)
                //                      .foregroundColor(.white)
                //                      .cornerRadius(10)
                //                      .padding(.horizontal, 40)
                //                      .disabled(isAuthenticating)
                //                      .simultaneousGesture(TapGesture().onEnded {
                //                          authenticateLocalUser()
                //                  })
                //                      }
                NavigationLink(destination: DocumentViewer(), isActive: $shouldNavigate) {
                    EmptyView()
                }
                
                Button(action: {
                    authenticateLocalUser()
                }) {
                    HStack {
                        Text(isAuthenticating ? "Signing In..." : "Sign in with Username or email")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                    .padding(.top,20)
                }
                .disabled(isAuthenticating)
                
                
                Button(action: {
                    authenticateUser()
                }) {
                    HStack {
                        Image(systemName: "lock.fill")
                        Text(isAuthenticating ? "Signing In..." : "Sign in with OAuth2")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
                }
                .disabled(isAuthenticating)
                if showError {
                    Text("Login failed. Try again.")
                        .foregroundColor(.red)
                }
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            
        }
    }
    
    func authenticateUser() {
        loginMode = .oauth
        // Simulate OAuth success after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoggedIn = true
        }
    }
    
    func authenticateLocalUser(){
        if email.lowercased() == "test@healthapp.com" && password == "test" {
            showError = false
            shouldNavigate = true
        } else {
            showError = true
            shouldNavigate = false
        }
    }
}





#Preview {
    LoginView()
}
