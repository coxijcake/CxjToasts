//
//  CxjToastDismisser+ByTimeUseCase.swift
//
//
//  Created by Nikita Begletskiy on 29/08/2024.
//

import Foundation

extension CxjToastDismisser {
	final class DimissByTimeUseCase: ToastDismissUseCase {
		//MARK: - Props
		private let displayingTime: TimeInterval
		private weak var delegate: ToastDismissUseCaseDelegate?
		
		private var dismissTimer: Timer?
		private var pausedTime: TimeInterval?
		
		//MARK: - Lifecycle
		init(
			displayingTime: TimeInterval,
			delegate: ToastDismissUseCaseDelegate?
		) {
			self.displayingTime = displayingTime
			self.delegate = delegate
		}
		
		//MARK: - Public
		func activate() {
			start()
		}
		
		func deactivate() {
			pausedTime = nil
			dismissTimer?.invalidate()
		}
		
		func pause() {
			pausedTime = dismissTimer?.fireDate.timeIntervalSinceNow
			dismissTimer?.invalidate()
		}
		
		//MARK: - Private
		private func start() {
			if let pausedTime {
				setupTimer(for: pausedTime)
			} else {
				setupTimer(for: displayingTime)
			}
		}
		
		private func setupTimer(
			for time: TimeInterval
		) {
			dismissTimer = Timer.scheduledTimer(
				withTimeInterval: time,
				repeats: false,
				block: { [weak self] _ in
					guard let self else { return }
					
					self.delegate?.didFinish(useCase: self)
				}
			)
		}
	}
}
