//
//  EditProduct.swift
//  PracticaSwiftUI
//
//  Created by Juan Manuel Jimenez Alfaro on 8/6/23.
//

import SwiftUI

struct EditProduct: View {
    @State private var textFieldTitle: String = ""
    @State private var textFieldImage: String = ""
    @State private var textFieldCategory: String = ""
    @State private var textFieldDescription: String = ""
    @State private var textFieldPrice: String = ""
    @State private var textFieldRating: String = ""
    @State private var showAlertCorrect: Bool = false
    @State private var showAlertIncorrect: Bool = false
    @State private var showAlertInvalidRating: Bool = false
    @State private var showAlertInvalidPrice: Bool = false

    @FocusState private var checkoutInFocus: CheckoutFocusable?

    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) private var dismiss
    
    var product: FetchedResults<Product>.Element
    
    var body: some View {
        VStack(spacing: 35) {
            Text("Producto")
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
                        FormCustom(title: "Título") {
                            TextFieldCustom(textFieldValue: $textFieldTitle, placeholder: "Escriba aquí", color: .whiteCustom, colorPlaceholder: .black.opacity(0.58), colorText: .black)
                                .focused($checkoutInFocus, equals: .title)
                            
                        }
                        FormCustom(title: "Imagen URL") {
                            TextFieldCustom(textFieldValue: $textFieldImage, placeholder: "Escriba aquí", color: .whiteCustom, colorPlaceholder: .black.opacity(0.58), colorText: .black)
                                .focused($checkoutInFocus, equals: .image)
                            
                        }
                        FormCustom(title: "Categoria") {
                            TextFieldCustom(textFieldValue: $textFieldCategory, placeholder: "Escriba aquí", color: .whiteCustom, colorPlaceholder: .black.opacity(0.58), colorText: .black)
                                .focused($checkoutInFocus, equals: .category)
                            
                        }
                        FormCustom(title: "Valoración") {
                            TextFieldCustom(textFieldValue: $textFieldRating, placeholder: "Escriba aquí", color: .whiteCustom, colorPlaceholder: .black.opacity(0.58), colorText: .black)
                        }
                        FormDescription(title: "Descripción") {
                            TextFieldDescription(textFieldValue: $textFieldDescription, placeholder: "Escriba aquí", color: .whiteCustom, colorPlaceholder: .black.opacity(0.58), colorText: .black)
                        }
                        FormCustom(title: "Precio") {
                            TextFieldCustom(textFieldValue: $textFieldPrice, placeholder: "Escriba aquí", color: .whiteCustom, colorPlaceholder: .black.opacity(0.58), colorText: .black)
                                .keyboardType(.decimalPad)
                            
                        }
                        Spacer()
                        Button("Enviar") {
                            isValid()
                        }
                        .buttonStyle(StyleCustomButton())
                        .padding(.bottom, 20)
                    }
                    .onAppear {
                        textFieldTitle = product.title!
                        textFieldImage = product.imageURL!
                        textFieldPrice = "\(product.price)"
                        textFieldRating = "\(product.rating)"
                        textFieldCategory = product.type_p!
                        textFieldDescription = product.descriptions!
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
                    DataController().editProduct(product: product, title: textFieldTitle, imageURL: textFieldImage, category: textFieldCategory, rating: Int16(textFieldRating) ?? 0, description: textFieldDescription, price: Double(textFieldPrice) ?? 0.0, context: moc)
                    dismiss()
                }
            } message: {
                Text("Producto enviado correctamente")
            }
            .alert("Incorrecto", isPresented: $showAlertIncorrect) {
                Button("Ok",role: .cancel) {
                    
                }
            } message: {
                Text("Por favor, rellene todos los campos")
            }
            .alert("Invalido", isPresented: $showAlertInvalidRating) {
                Button("Ok",role: .cancel) {
                    
                }
            } message: {
                Text("Por favor, introduzca una valoracion correcta y entre 0 y 5")
            }
            .alert("Invalido", isPresented: $showAlertInvalidPrice) {
                Button("Ok", role: .cancel) {
                    
                }
            } message: {
                Text("Por favor, introduzca un precio valido")
            }

    }
    
    private func isValid() {
        if !textFieldTitle.isEmpty && !textFieldImage.isEmpty && !textFieldCategory.isEmpty && !textFieldRating.isEmpty && !textFieldDescription.isEmpty && !textFieldPrice.isEmpty {
            if let rating = Double(textFieldRating), (0...5).contains(rating) {
                if Double(textFieldPrice) != nil {
                    showAlertCorrect = true
                } else {
                    showAlertInvalidPrice = true
                }
            } else {
                showAlertInvalidRating = true
            }
        } else {
            showAlertIncorrect =  true
        }
    }

    
    private func resetFields() {
        textFieldTitle = ""
        textFieldImage = ""
        textFieldCategory = ""
        textFieldRating = ""
        textFieldDescription = ""
        textFieldPrice = ""
    }
    
    private func checkFocus() {
        if checkoutInFocus == .title {
            checkoutInFocus = .image
        } else if checkoutInFocus == .image {
            checkoutInFocus = .category
        } else if checkoutInFocus == .category {
            checkoutInFocus = nil
        }
    }
}

extension EditProduct {
    enum CheckoutFocusable: Hashable {
        case title
        case image
        case category
    }
}


//struct EditProduct_Previews: PreviewProvider {
//    static var previews: some View {
//        EditProduct()
//    }
//}
