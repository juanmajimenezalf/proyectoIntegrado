//
//  ContentView.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 23/12/22.
//

import SwiftUI

struct ForgotpasswordView: View {
    @State private var textFieldValue: String = ""
    @State private var showAlertEmptyEmail = false
    @State private var showAlertCorrectEmail = false
    @State private var showAlertIncorrectEmail = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .tint(.whiteCustom)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                    .padding(.leading, 25)
                    VStack {
                        Spacer(minLength: 20)
                        VStack(spacing: 10) {
                            Text("¿No recuerdas tu contraseña?")
                                .font(.custom("OpenSans-Bold", size: 20))
                            Text("Introduce tu email y te enviaremos un enlace de restablecimiento")
                                .font(.custom("OpenSans-Regular", size: 16))
                                .multilineTextAlignment(.center)
                        }
                        .foregroundColor(Color("white"))
                        Spacer(minLength: 20)
                        TextFieldCustom(textFieldValue: $textFieldValue, placeholder: "Email", color: Color("white").opacity(0.4), colorPlaceholder: .whiteCustom.opacity(0.7), colorText: .whiteCustom)
                            .onSubmit {
                                showAlert()
                            }
                            .keyboardType(.emailAddress)
                        Spacer()
                        Spacer(minLength: 10)
                        Button("Continuar") {
                            showAlert()
                        }
                        .buttonStyle(StyleCustomButton())
                        .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 46)
                }
                .frame(minHeight: proxy.size.height)
                .background(alertEmptyEmail)
                .background(alertCorrectEmail)
                .background(alertIncorrectEmail)
            }
        }
        .background(LinearGradient(colors: [Color("navy"), Color("lightNavy")], startPoint: .top, endPoint: .bottom))
        .preferredColorScheme(.dark)
        .onTapGesture {
            self.hideKeyboard()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    private var alertEmptyEmail: some View {
        EmptyView()
            .alert("Fallo", isPresented: $showAlertEmptyEmail) {
                Button("Ok", role: .none) {
                }
            } message: {
                    Text("Por favor, introduzca un email")
            }
    }
    
    @ViewBuilder
    private var alertCorrectEmail: some View {
        EmptyView()
            .alert("Correcto", isPresented: $showAlertCorrectEmail) {
                Button("Ok", role: .none) {
                    textFieldValue = ""
                }
            } message: {
                    Text("Email correcto")
            }
    }
    
    @ViewBuilder
    private var alertIncorrectEmail: some View {
        EmptyView()
            .alert("Incorrecto", isPresented: $showAlertIncorrectEmail) {
                Button("Ok", role: .none) {
                }
            } message: {
                    Text("Email incorrecto")
            }
    }
    
    private func showAlert() {
        if textFieldValue.isEmpty {
            showAlertEmptyEmail = true
        } else if textFieldValue.isValidEmail() {
            showAlertCorrectEmail = true
        } else {
            showAlertIncorrectEmail = true
        }
    }
}



struct ForgotpasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotpasswordView()
    }
}



