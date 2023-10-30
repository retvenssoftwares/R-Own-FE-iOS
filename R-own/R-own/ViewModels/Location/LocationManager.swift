import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    private static var shared: LocationManager?
    private var locationManager: CLLocationManager?
    
    private var completions: [(CLLocationCoordinate2D?) -> Void] = []

    private override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
    }

    static func sharedManager() -> LocationManager {
        if shared == nil {
            shared = LocationManager()
        }
        return shared!
    }

    func requestLocationUpdate(completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        completions.append(completion)
        locationManager?.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last?.coordinate else {
            completions.forEach { completion in
                completion(nil)
            }
            completions.removeAll()
            return
        }

        completions.forEach { completion in
            completion(location)
        }
        completions.removeAll()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completions.forEach { completion in
            completion(nil)
        }
        completions.removeAll()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager?.requestLocation()
        }
    }
}
