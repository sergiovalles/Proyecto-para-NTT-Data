//
//  DetailView.swift
//  pruebaapp
//
//  Created by sergio manuel pozos moran on 05/07/23.
//
import SwiftUI

struct DetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let fontSize: CGFloat = 12
    let product: Product
    
    var body: some View {
        NavigationView {
            VStack {
                Text(product.description)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 24)
                    .font(.system(size: fontSize))
                    .multilineTextAlignment(.center)
                    .frame(height: 100)
                
                Text("Precio " + (roundPriceString("\(product.price)") ?? "0.0000"))
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 24)
                    .padding(.bottom, 32)
                
                AsyncImage(url: URL(string: product.images[0])) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 24)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 200)
                .padding()
                
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cerrar")
                        .foregroundColor(Color(hex: "#0A4AA3"))
                        .frame(width: 250, height: 15)
                        .padding(.horizontal, 35)
                        .padding(.top, 32)
                        .padding(.bottom, 24)
                        .foregroundColor(.white)
                        .background(.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(#colorLiteral(red: 0.039, green: 0.29, blue: 0.639, alpha: 1)), lineWidth: 2)
                        )
                }
                
                .padding()
            }
            .navigationTitle(product.title)
            .font(.title)
            .padding(.vertical, 24)
            .navigationBarTitleDisplayMode(.inline)
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    func roundPriceString(_ priceString: String) -> String? {
        if let price = Double(priceString) {
            let roundedPrice = String(format: "%.2f", price)
            return roundedPrice
        }
        return nil
    }
    
}

