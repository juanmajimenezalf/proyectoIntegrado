//
//  LoginView.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 4/1/23.
//

import SwiftUI

struct LoginView: View {
    @State private var textFieldUser: String = ""
    @State private var textFieldPass: String = ""
    @State private var showAlertCorrect: Bool = false
    @State private var showAlertIncorrect: Bool = false
    @State private var showForgotPassword: Bool = false
    @State private var showNavegationHidden: Bool = false

    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 25) {
                    Spacer(minLength: 20)
                    Image("logo")
                    Spacer(minLength: 20)
                    TextFieldCustom(textFieldValue: $textFieldUser, placeholder: "Usuario", color: .whiteCustom.opacity(0.4), colorPlaceholder: .whiteCustom.opacity(0.7), colorText: .whiteCustom)
                    SecureFieldCustom(textFieldValue: $textFieldPass, placeholder: "Contraseña", color: .whiteCustom.opacity(0.4), colorPlaceholder: .whiteCustom.opacity(0.7), colorText: .whiteCustom)
                    NavigationLink(isActive: $showForgotPassword, destination: {
                        ForgotpasswordView()
                    }, label: {
                        Text("He olvidado mi contraseña")
                            .foregroundColor(.whiteCustom)
                            .font(.regular(size: 14))
                            .underline()
                    })
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    Spacer()
                    Spacer(minLength: 20)
                    HStack(spacing: 2) {
                        Text("¿Aún no tienes cuenta?")
                        NavigationLink {
                            RegisterView()
                        } label: {
                            Text("Regístrate")
                                .underline()
                        }
                    }
                    .foregroundColor(.whiteCustom)
                    .font(.regular(size: 14))
                    Button("Acceder") {
                        isValid()
                    }
                    .buttonStyle(StyleCustomButton())
                    .padding(.bottom, 20)
                }
                .frame(minHeight: proxy.size.height)
                .padding(.horizontal, 40)
                
            }
            .frame(maxWidth: .infinity)
            .background(LinearGradient(colors: [Color.navy, Color.lightNavy], startPoint: .top, endPoint: .bottom))
        }
        .onChange(of: showForgotPassword) { newValue in
            print(newValue)
        }
        .background(alert)
        .background(navegation)
        .onTapGesture {
            self.hideKeyboard()
        }
        .preferredColorScheme(.dark)
    }
    
    @ViewBuilder
    private var navegation: some View {
        EmptyView()
            .background {
                NavigationLink(isActive: $showNavegationHidden) {
                    CustomTabView()
                } label: {
                    EmptyView()
                }

            }
    }
    
    @ViewBuilder
    private var alert: some View {
        EmptyView()
            .alert("Correcto", isPresented: $showAlertCorrect) {
                Button("Ok", role: .cancel) {
                    showNavegationHidden = true
                }
            } message: {
                Text("Usuaro logueado correctamente, \(users.count) en la base de datos")
            }
            .alert("Incorrecto", isPresented: $showAlertIncorrect) {
                Button("Aceptar", role: .cancel) { }
            } message: {
                Text("Usuario o contraseña incorrectos, \(users.count) en la base de datos")
            }
    }
    
    private func isValid() {
        if !textFieldUser.isEmpty && !textFieldPass.isEmpty && DataController().login(username: textFieldUser, password: textFieldPass, context: moc) {
            showAlertCorrect = true
        } else {
            showAlertIncorrect = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
