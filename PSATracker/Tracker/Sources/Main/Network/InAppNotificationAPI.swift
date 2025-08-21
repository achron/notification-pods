import Foundation
import UIKit

class InAppNotificationAPI {
    static let shared = InAppNotificationAPI()
    private init() {}

    private let baseURL = "https://pdev.proemsportsanalytics.com/api/ccgt/inapp/campaign/"

    func fetchNotifications(completion: @escaping ([InAppNotification]?) -> Void) {
        // 1. Create the URL
        guard let url = URL(string: baseURL) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        // 2. Build the URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // 3. Use URLSession
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            do {
                let notifications = try JSONDecoder().decode([InAppNotification].self, from: data)
                completion(notifications)
            } catch {
                print("JSON decode error: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}


class InAppNotificationManager {
    static let shared = InAppNotificationManager()
    private init() {}
    
    func showNotification(_ notification: InAppNotification) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: notification.title, message: notification.message, preferredStyle: .alert)
            if let deepLink = notification.deepLink {
                alert.addAction(UIAlertAction(title: "Open", style: .default, handler: { _ in
                    if let url = URL(string: deepLink) {
                        UIApplication.shared.open(url)
                    }
                }))
            }
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
        }
    }
}

// TODO: Example of usage

/*
InAppNotificationAPI.shared.fetchNotifications { notifications in
    if let first = notifications?.first {
        InAppNotificationManager.shared.showNotification(first)
    }
}
*/