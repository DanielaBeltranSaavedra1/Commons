//
//  PrimaryButtonState.swift
//  SwiftUI-theming-poc
//
//  Created by Daniela Paola Beltran Saavedra on 29/03/23.
//
import Foundation
import SwiftUI

public class PrimaryButtonState{
    public var currentState: ButtonState
    
    public init(state: ButtonState = ButtonState.ENABLED){
        self.currentState = state
    }
    
    public func enable() {
        currentState = ButtonState.ENABLED
    }
    
    public func isEnabled() -> Bool {
        return currentState == ButtonState.ENABLED
    }
    
    public func loading() {
        currentState = ButtonState.LOADING
    }
    
    public func isLoading() -> Bool {
        return currentState == ButtonState.LOADING
    }
    
    public func disable() {
        currentState = ButtonState.DISABLED
    }
    
    public func isDisabled() -> Bool {
        return currentState == ButtonState.DISABLED
    }
    
    public func enableButtonByCondition(condition: Bool) {
        currentState = condition ? ButtonState.ENABLED : ButtonState.DISABLED
    }
    
    public func getText(_ text: LocalizedStringKey) -> LocalizedStringKey{
        return isLoading() ? LocalizedStringKey("") : text
    }
    
    public func isDisabledOrLoading() -> Bool{
        return isDisabled() || isLoading()
    }
}

public enum ButtonState {
    case LOADING
    case ENABLED
    case PRESSED
    case DISABLED
}
