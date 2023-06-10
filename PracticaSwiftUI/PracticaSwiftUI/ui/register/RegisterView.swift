//
//  RegisterView.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 29/12/22.
//

import SwiftUI


struct RegisterView: View {
    @State private var textFieldName: String = ""
    @State private var textFieldSurName: String = ""
    @State private var textFieldId: String = "--"
    @State private var textFieldNumber: String = ""
    @State private var textFieldDate: String = "--"
    @State private var textFieldUsername: String = ""
    @State private var textFieldEmail: String = ""
    @State private var textFieldPass: String = ""
    @State private var textFieldRePass: String = ""
    @State private var datePickerValue: Date = Date()
    @State private var showAlertCorrect: Bool = false
    @State private var showAlertIncorrect: Bool = false
    @State private var showAlertInvalidId: Bool = false
    @State private var showAlertInvalidEmail: Bool = false
    @State private var showAlertPassNotMacth: Bool = false
    @FocusState private var checkoutInFocus: CheckoutFocusable?

    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 35) {
            Text("Registro")
                .font(.bold(size: 20))
                .foregroundColor(.whiteCustom)
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(Color.marine)
                .overlay {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .tint(.whiteCustom)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 25)
                }
            GeometryReader { proxy in
                ScrollView {
                    VStack(spacing: 30) {
                        FormCustom(title: "nombre") {
                            TextFieldCustom(textFieldValue: $textFieldName, placeholder: "Escriba aquí", color: .whiteCustom, colorPlaceholder: .black.opacity(0.58), colorText: .black)
                                .focused($checkoutInFocus, equals: .name)
                            
                        }
                        FormCustom(title: "apellidos") {
                            TextFieldCustom(textFieldValue: $textFieldSurName, placeholder: "Escriba aquí", color: .whiteCustom, colorPlaceholder: .black.opacity(0.58), colorText: .black)
                                .focused($checkoutInFocus, equals: .surname)
                            
                        }
                        HStack {
                            FormCustom(title: "identificación") {
                                Menu {
                                    Button("NIF") {
                                        textFieldId = "NIF"
                                    }
                                    Button("NIE") {
                                        textFieldId = "NIE"
                                    }
                                } label: {
                                    HStack {
                                        Text(textFieldId)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        Image("arrow")
                                    }
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(textFieldId == "--" ? .black.opacity(0.58) : .black)
                                }
                                .padding(.horizontal, 15)
                            }
                            .frame(width: 112)
                            FormCustom(title: "número") {
                                TextFieldCustom(textFieldValue: $textFieldNumber, placeholder: "Escriba aquí", color: .whiteCustom, colorPlaceholder: .black.opacity(0.58), colorText: .black)
                                    .keyboardType(.numbersAndPunctuation)
                                    .focused($checkoutInFocus, equals: .id)
                            }
                        }
                        FormCustom(title: "fecha nacimiento") {
                            Text(textFieldDate)
                                .foregroundColor(textFieldDate == "--" ? .black.opacity(0.58) : .black)
                                .allowsHitTesting(false)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .clipShape(RoundedRectangle(cornerRadius: 3))
                                .overlay {
                                    Image(systemName: "calendar")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .foregroundColor(.black.opacity(0.58))
                                        .padding()
                                        .allowsHitTesting(false)
                                }
                                .background {
                                    Color.whiteCustom
                                        .allowsHitTesting(false)
                                        .background {
                                            DatePicker(selection: $datePickerValue, in: ...Date(), displayedComponents: .date) {
                                                
                                            }
                                            .fixedSize()
                                            .scaleEffect(x: 7, y: 2, anchor: .center)
                                            .onChange(of: datePickerValue) { date in
                                                textFieldDate = "\(date.formatted(date: .numeric, time: .omitted))"
                                            }
                                        }
                                        .clipped()
                                }
                        }
                        FormCustom(title: "Correo") {
                            TextFieldCustom(textFieldValue: $textFieldEmail, placeholder: "Escriba aquí", color: .whiteCustom, colorPlaceholder: .black.opacity(0.58), colorText: .black)
                        }
                        FormCustom(title: "Usuario") {
                            TextFieldCustom(textFieldValue: $textFieldUsername, placeholder: "Escriba aquí", color: .whiteCustom, colorPlaceholder: .black.opacity(0.58), colorText: .black)
                        }
                        FormCustom(title: "Contraseña") {
                            SecureFieldCustom(textFieldValue: $textFieldPass, placeholder: "Escriba aquí", color: .whiteCustom, colorPlaceholder: .black.opacity(0.58), colorText: .black)
                        }
                        FormCustom(title: "Repite Contraseña") {
                            SecureFieldCustom(textFieldValue: $textFieldRePass, placeholder: "Escriba aquí", color: .whiteCustom, colorPlaceholder: .black.opacity(0.58), colorText: .black)
                        }
                        Spacer()
                        Button("Enviar") {
                            isValid()
                        }
                        .buttonStyle(StyleCustomButton())
                        .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 16)
                    .frame(minHeight: proxy.size.height)
                    .onSubmit {
                        checkFocus()
                    }
                }
            }
        }
        .background(Color.marine.opacity(0.02))
        .background(Color.whiteCustom)
        .background(alert)
        .onTapGesture {
            self.hideKeyboard()
        }
        .preferredColorScheme(.dark)
        .navigationBarBackButtonHidden(true)
    }
    
    @ViewBuilder
    private var alert: some View {
        EmptyView()
            .alert("Correcto", isPresented: $showAlertCorrect) {
                Button("Ok",role: .cancel) {
                    DataController().createUser(name: textFieldName, last_name: textFieldSurName, type_id: textFieldId, number_id: textFieldNumber, date: textFieldDate, username: textFieldUsername, password: textFieldPass, email: textFieldEmail, admin: true, context: moc)
                    resetFields()
                }
            } message: {
                Text("Registro enviado correctamente")
            }
            .alert("Incorrecto", isPresented: $showAlertIncorrect) {
                Button("Ok",role: .cancel) {
                    
                }
            } message: {
                Text("Por favor, rellene todos los campos")
            }
            .alert("Invalido", isPresented: $showAlertInvalidId) {
                Button("Ok",role: .cancel) {
                    
                }
            } message: {
                Text("Por favor, introduzca un Identificador correcto")
            }
            .alert("Email incorrecto", isPresented: $showAlertInvalidEmail) {
                Button("Ok", role: .cancel) {
                    
                }
            } message: {
                Text("Por favor, introduzca un email correcto")
            }
            .alert("Contraseñas no coinciden", isPresented: $showAlertPassNotMacth) {
                Button("Ok", role: .cancel) {
                    
                }
            } message: {
                Text("Las contraseñas no coinciden, por favor vuelva a intentarlo")
            }

    }
    
    private func isValid() {
        if !textFieldName.isEmpty && !textFieldSurName.isEmpty && textFieldId != "--" && !textFieldNumber.isEmpty && textFieldDate != "--" && !textFieldEmail.isEmpty && !textFieldUsername.isEmpty && !textFieldPass.isEmpty && !textFieldRePass.isEmpty {
            if textFieldId == "NIF" {
                if textFieldNumber.validation(document: .dni(number: textFieldNumber)) {
                    if textFieldEmail.isValidEmail() {
                        if textFieldPass != textFieldRePass {
                            showAlertPassNotMacth = true
                        } else {
                            showAlertCorrect = true
                        }
                    } else {
                        showAlertInvalidEmail = true
                    }
                } else {
                    showAlertInvalidId = true
                }
            } else if textFieldId == "NIE" {
                if textFieldNumber.validation(document: .nie(number: textFieldNumber)) {
                    if textFieldEmail.isValidEmail() {
                        if textFieldPass != textFieldRePass {
                            showAlertPassNotMacth = true
                        } else {
                            showAlertCorrect = true
                        }
                    } else {
                        showAlertInvalidEmail = true
                    }
                } else {
                    showAlertInvalidId = true
                }
            }
        } else {
            showAlertIncorrect =  true
        }
    }

    
    private func resetFields() {
        textFieldId = "--"
        textFieldDate = "--"
        textFieldName = ""
        textFieldSurName = ""
        textFieldNumber = ""
        textFieldEmail = ""
        textFieldPass = ""
        textFieldUsername = ""
        textFieldRePass = ""
    }
    
    private func checkFocus() {
        if checkoutInFocus == .name {
            checkoutInFocus = .surname
        } else if checkoutInFocus == .surname {
            checkoutInFocus = .id
        } else if checkoutInFocus == .id {
            checkoutInFocus = nil
        }
    }
}

extension RegisterView {
    enum CheckoutFocusable: Hashable {
        case name
        case surname
        case id
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
