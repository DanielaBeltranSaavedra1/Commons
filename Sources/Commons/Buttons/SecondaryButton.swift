//
//  SecondaryButton.swift
//  SwiftUI-theming-poc
//
//  Created by Daniela Paola Beltran Saavedra on 29/03/23.
//
import SwiftUI
import Theme

public struct SecondaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .padding()
            .foregroundColor(colorFont())
            .frame(maxWidth: .infinity, maxHeight: AppTheme.dimensions[.BUTTON_HEIGHT], alignment: .center)
            .background(colorBackground(configuration.isPressed))
            .font(AppTheme.typhography[.h5])
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(colorBorder(configuration.isPressed), lineWidth: 4))
    }
    
    public func colorBorder(_ isPressed: Bool) -> Color{
        return isEnabled ? AppTheme.colors.buttonDefault : isPressed ? AppTheme.colors.buttonPressed : AppTheme.colors.buttonDisabled
    }
    public func colorBackground(_ isPressed: Bool) -> Color{
        return isPressed ? AppTheme.colors.buttonPressed : .white
    }
    public func colorFont() -> Color{
        return isEnabled ? AppTheme.colors.textPrimary : AppTheme.colors.buttonDisabled
    }
}

public struct SecondaryButton<T: View>: View {
    let text: LocalizedStringKey
    var action: ButtonAction<T>
    var icon: String?
    @State var isActive = false
    
    public init(text: LocalizedStringKey, action: ButtonAction<T>, icon: String? = "") {
        self.text = text
        self.action = action
        self.icon = icon
    }
    
    public var body: some View {
        if action.destination is EmptyView {
            Button(action: action.onClick) {
                HStack {
                    Text(text)
                    if let icon = icon, !icon.isEmpty {
                        Image(self.icon!)
                            .resizable()
                            .frame(width: 16, height: 20)
                            .padding(.leading, 5)
                    }
                }
            }.clipShape(RoundedRectangle(cornerRadius: 16 , style: .circular))
                .buttonStyle(SecondaryButtonStyle())
        }else {
            NavigationLink(destination: action.destination, isActive: $isActive) {
                Button(self.text, action: {
                    isActive = true
                    action.onClick() })
                    .clipShape(RoundedRectangle(cornerRadius: 16 , style: .circular))
                    .buttonStyle(SecondaryButtonStyle())
            }
        }
    }
}
