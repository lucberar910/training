//
//  ViewModellable.swift
//  Training
//
//  Created by Diego Riccardi on 24/06/21.
//

import Foundation

protocol ViewModellable {
    associatedtype ViewModelType : ViewModel
    var viewModel : ViewModelType { get set }
    
}
