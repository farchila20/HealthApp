import SwiftUI
import AuthenticationServices

struct LoginView: View {

    @StateObject private var viewModel = LoginViewModel()

    private let oauthURL = URL(string: "https://auth.example.com/oauth/authorize?client_id=your_client_id&redirect_uri=HealthApp://callback&response_type=code&scope=openid profile email")!

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)
                    .accessibilityIdentifier("profileIcon")
                Text("HealthApp")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                inputField("Username or Email", text: $viewModel.email)
                    .accessibilityIdentifier("emailField")
                inputField("Password", text: $viewModel.password, isSecure: true)
                    .accessibilityIdentifier("passwordField")

                NavigationLink(destination: DocumentViewer(), isActive: $viewModel.shouldNavigate) {
                    EmptyView()
                }

                button(title: viewModel.isAuthenticating ? "Signing In..." : "Sign in with Username or email",
                       backgroundColor: .green,
                       action: viewModel.authenticateLocalUser)
                .accessibilityIdentifier("localLoginButton")

                button(title: viewModel.isAuthenticatingsso ? "Signing In..." : "Sign in with OAuth2",
                       icon: "lock.fill",
                       backgroundColor: .blue,
                       action: viewModel.authenticateUser)
                .accessibilityIdentifier("oauthLoginButton")

                if viewModel.showError {
                    Text("Login failed. Try again.")
                        .foregroundColor(.red)
                        .padding(.top, 10)
                        .accessibilityIdentifier("loginErrorLabel")
                }

                Spacer()
            }
            .padding()
        }
    }

    // MARK: - View Components

    private func inputField(_ placeholder: String, text: Binding<String>, isSecure: Bool = false) -> some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: text)
            } else {
                TextField(placeholder, text: text)
            }
        }
        .padding(10)
        .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.blue, lineWidth: 2))
        .padding(.horizontal, 40)
    }

    private func button(title: String, icon: String? = nil, backgroundColor: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                }
                Text(title)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal, 40)
            .padding(.top, 10)
        }
        .disabled(viewModel.isAuthenticating)
    }


}

#Preview {
    LoginView()
}
