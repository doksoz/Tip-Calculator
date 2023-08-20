//
//  CalculatorVM.swift
//  Tip-Calculator
//
//  Created by berfin doksöz on 15.08.2023.
//

import Foundation
import Combine

class CalculatorVM {
    
    private var cancellables = Set<AnyCancellable>()
    
    struct Input {
        let billPublisher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
        let logoViewTapPublisher: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let updateViewPubliser: AnyPublisher<Result, Never>
        let resetCalculatorPublisher: AnyPublisher<Void, Never>
    }
    
    private let audioPlayerService: AudioPlayerService
    
    init(audioPlayerService: AudioPlayerService = DefaultAudioPlayer()){
        self.audioPlayerService = audioPlayerService
    }
    
    func transform(input: Input) -> Output {
        
        let updateViewPublisher = Publishers.CombineLatest3(
            input.billPublisher,
            input.tipPublisher,
            input.splitPublisher).flatMap { [unowned self] (bill, tip, split) in
                let totalTip = getTipAmount(bill: bill, tip: tip)
                let totalBill = bill  + totalTip
                let amountPerPerson = totalBill / Double(split)
                let result = Result(
                    amountPerPerson: amountPerPerson,
                    totalBill: totalBill,
                    totalTip: totalTip)
                return Just(result)
            }.eraseToAnyPublisher()
        
        let resetCalculatorPublisher = input
            .logoViewTapPublisher
            .handleEvents(receiveOutput: { [unowned self] in
            audioPlayerService.playSound()
        }).flatMap {
            return Just(())
        }.eraseToAnyPublisher()
        
        return Output(updateViewPubliser: updateViewPublisher,
                      resetCalculatorPublisher: resetCalculatorPublisher)
    }
    
    private func getTipAmount(bill: Double, tip: Tip) -> Double {
        switch tip {
        case .none:
            return 0
        case .tenPercent:
            return bill * 0.1
        case .fifteenPercent:
            return bill * 0.15
        case .twentyPercent:
            return bill * 0.2
        case .custom(let value):
            return Double(value)
        }
        
    }
}
