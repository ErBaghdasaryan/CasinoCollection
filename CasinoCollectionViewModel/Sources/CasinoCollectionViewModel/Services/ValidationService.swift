//
//  ValidationService.swift
//
//
//  Created by Er Baghdasaryan on 16.12.24.
//

import UIKit
import NetworkExtension
import CoreTelephony
import CasinoCollectionModel

public protocol IValidationService {
    func vivisWork() -> Bool
    func gfdokPS() -> String
    func gdpsjPjg() -> String
    func poguaKFP() -> String
    func gpaMFOfa() -> [String]
    func bcpJFs() -> String
    func GOmblx() -> String
    func G0pxum() -> String
    func Fpvbduwm() -> Bool
    func Fpbjcv() -> String
    func StwPp() -> Bool
    func gfpbvjsoM() -> Int
    func bpPjfns() -> String
    func oahgoMAOI() -> Bool
    func getInfo() -> UInt64
    func getWiFiAddress() -> String?
}

final public class ValidationService: IValidationService {

    public init() { }

    public func vivisWork() -> Bool {
        let vpnManager = NEVPNManager.shared()
        return vpnManager.connection.status != .disconnected && vpnManager.connection.status != .invalid
    }

    public func gfdokPS() -> String {
        return UIDevice.current.name
    }

    public func gdpsjPjg() -> String {
        return UIDevice.current.model
    }

    public func poguaKFP() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? "Unknown"
    }

    public func gpaMFOfa() -> [String] {
        if let addr = getWiFiAddress() {
            return [addr]
        } else {
            return ["Unknown"]
        }
    }

    public func bcpJFs() -> String {
        return UIDevice.current.systemVersion
    }

    public func GOmblx() -> String {
        let preferredLanguages = Locale.preferredLanguages
        if let primaryLanguage = preferredLanguages.first {
            return primaryLanguage
        }
        return "en-PL"
    }

    public func G0pxum() -> String {
        return "\(TimeZone.current)"
    }

    public func Fpvbduwm() -> Bool {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return UIDevice.current.batteryState == .charging || UIDevice.current.batteryState == .full
    }

    public func Fpbjcv() -> String {
        let size = getInfo()
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = [.useGB, .useMB, .useKB, .useBytes]
        formatter.countStyle = .file
        return formatter.string(fromByteCount: Int64(size))
    }

    public func StwPp() -> Bool {
        return UIScreen.main.isCaptured
    }

    public func gfpbvjsoM() -> Int {
        return Int(UIDevice.current.batteryLevel)
    }

    public func bpPjfns() -> String {
        let locale = Locale.current
        return locale.regionCode ?? "Unknown"
    }

    public func oahgoMAOI() -> Bool {
        UIDevice.current.isBatteryMonitoringEnabled = true
        return UIDevice.current.batteryLevel == 1.0
    }

    public func getInfo() -> UInt64 {
        var size: UInt64 = 0
        var sizeLength = MemoryLayout<UInt64>.size
        let result = sysctlbyname("hw.memsize", &size, &sizeLength, nil, 0)
        if result == 0 {
            return size
        } else {
            print("Failed to get memory size")
            return 0
        }
    }

    public func getWiFiAddress() -> String? {
        var address : String?

        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }

        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee

            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                let name = String(cString: interface.ifa_name)
                if  name == "en0" {

                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        return address
    }
}
