//
//  CxjToastDismisser+ByTimeUseCase.swift
//
//
//  Created by Nikita Begletskiy on 29/08/2024.
//

import Foundation

extension CxjToastDismisser {
	@MainActor
	final class DimissByTimeUseCase: ToastDismissUseCase {
		//MARK: - Props
		private let timerUpdateInterval: TimeInterval = 0.1
		
		private let displayingTime: TimeInterval
		private var remainingTime: TimeInterval
		
		private weak var delegate: ToastDismissUseCaseDelegate?
		
		private var dismissTimer: Timer?
		private var pausedTime: TimeInterval?
		
		//MARK: - Lifecycle
		init(
			displayingTime: TimeInterval,
			delegate: ToastDismissUseCaseDelegate?
		) {
			self.displayingTime = displayingTime
			self.remainingTime = displayingTime
			self.delegate = delegate
			
			delegate?.didUpdateRemainingDisplayingTime(
				displayingTime,
				initialDisplayingTime: displayingTime,
				by: self
			)
		}
		
		//MARK: - Public
		func activate() {
			start()
		}
		
		func deactivate() {
			pausedTime = nil
			removeTimer()
		}
		
		func pause() {
			pausedTime = dismissTimer?.fireDate.timeIntervalSinceNow
			removeTimer()
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
			removeTimer()
			
			delegate?.didUpdateRemainingDisplayingTime(time, initialDisplayingTime: displayingTime, by: self)
			
			dismissTimer = Timer.scheduledTimer(
				withTimeInterval: timerUpdateInterval,
				repeats: true,
				block: { [weak self] timer in
					guard let self else { return }
					
					Task { @MainActor in
						self.remainingTime = max(.zero, self.remainingTime - self.timerUpdateInterval)
						self.delegate?.didUpdateRemainingDisplayingTime(self.remainingTime, initialDisplayingTime: displayingTime, by: self)
						
						if remainingTime <= 0 {
							self.delegate?.didFinish(useCase: self)
						}
					}
				}
			)
		}
		
		private func removeTimer() {
			dismissTimer?.invalidate()
			dismissTimer = nil
		}
	}
}
