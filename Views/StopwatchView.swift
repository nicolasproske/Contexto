import SwiftUI

struct StopwatchView: View {
    let seconds: Int
    
    var body: some View {
        InfoBadgeView(title: "Elapsed Time", value: "\(formatTime(seconds: seconds))")
    }
}

extension StopwatchView {
    // Format seconds into a more readable string format
    private func formatTime(seconds: Int) -> String {
        // Define constants for time conversions
        let secondsInAMinute = 60
        let secondsInAnHour = 3600
        let secondsInADay = 86400
        
        // Calculate the number of days, hours, minutes, and seconds
        let days = seconds / secondsInADay
        let hours = (seconds % secondsInADay) / secondsInAnHour
        let minutes = (seconds % secondsInAnHour) / secondsInAMinute
        let secondsLeft = seconds % secondsInAMinute
        
        // Initialize an empty string to build the formatted time string
        var timeString = ""
        
        // Append days to the string if applicable
        if days > 0 {
            timeString += "\(days)d "
        }
        
        // Append hours to the string if applicable
        if hours > 0 {
            timeString += "\(hours)h "
        }
        
        // Append minutes to the string if applicable
        if minutes > 0 {
            timeString += "\(minutes)m "
        }
        
        // Append seconds to the string if applicable, or if the string is still empty
        if secondsLeft > 0 || timeString.isEmpty {
            timeString += "\(secondsLeft)s"
        }
        
        // Return the formatted string, trimming any unnecessary whitespace
        return timeString.trimmingCharacters(in: .whitespaces)
    }
}
