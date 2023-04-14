//
//  PrimaryButton.swift
//  SwiftUI-theming-poc
//
//  Created by Daniela Paola Beltran Saavedra on 29/03/23.
//
import SwiftUI
import Theme

public struct PrimaryButtonStyle: ButtonStyle {
    var isDisabled: Bool
    public init(isDisabled: Bool) {
        self.isDisabled = isDisabled
    }
    public func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .padding()
            .foregroundColor(isDisabled ? AppTheme.colors.buttonTextDisabled :  AppTheme.colors.textPrimary)
            .frame(maxWidth: .infinity, maxHeight: AppTheme.dimensions[.BUTTON_HEIGHT], alignment: .center)
            .font(AppTheme.typhography[.h5])
            .background(colorBackground(configuration.isPressed))
    }
    
    func colorBackground(_ isPressed: Bool) -> Color{
        return isDisabled ? AppTheme.colors.buttonDisabled : isPressed ? AppTheme.colors.buttonPressed : AppTheme.colors.buttonDefault
    }
}

public struct PrimaryButton<T: View>: View {
    let text: LocalizedStringKey
    var action: ButtonAction<T>
    var state: PrimaryButtonState
    @State var isActive = false
    
    public init(text: LocalizedStringKey, action: ButtonAction<T>, state: PrimaryButtonState = PrimaryButtonState()) {
        self.text = text
        self.action = action
        self.state = state
    }

    public var body: some View {
        ZStack {
            if action.destination is EmptyView  {
                Button(state.getText(text), action: action.onClick)
                    .clipShape(RoundedRectangle(cornerRadius: 16 , style: .circular))
                    .buttonStyle(PrimaryButtonStyle(isDisabled: state.isDisabledOrLoading()))
                    .disabled(state.isDisabledOrLoading())
            }else {
                NavigationLink(destination: action.destination, isActive: $isActive) {
                    Button(state.getText(text), action: {
                        isActive = true
                        action.onClick() })
                        .clipShape(RoundedRectangle(cornerRadius: 16 , style: .circular))
                        .buttonStyle(PrimaryButtonStyle(isDisabled: state.isDisabledOrLoading()))
                        .disabled(state.isDisabledOrLoading())
                }.disabled(state.isDisabledOrLoading())
                // Add empty navigation link for bug in versions below iOS15
                // Bug returning automatically to previous screen
                if #unavailable(iOS 15.0) {
                    NavigationLink(destination: EmptyView()) {
                        EmptyView()
                    }
                    
                }
            }
            
            if state.isLoading(){
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: AppTheme.colors.textPrimary))
                    .scaleEffect( x: 1.2, y: 1.2, anchor: .center)
            }
        }
    }
}
