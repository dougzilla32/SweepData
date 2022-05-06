//
//  DeepDescription.swift
//  WeatherBar
//
//  Mathew Huusko V
//  https://gist.github.com/mhuusko5/81ecab40ebbea035abe8
//
//  Ported to Swift 4.0 by Doug on 2/5/18.
//

import Foundation

public func deepDescription(_ any: Any, omitNilValues: Bool = false) -> String {
    guard let any = deepUnwrap(any) else {
        return "nil"
    }
    
    if any is Void {
        return "Void"
    }
    
    if let int = any as? Int {
        return String(int)
    } else if let double = any as? Double {
        return String(double)
    } else if let float = any as? Float {
        return String(float)
    } else if let bool = any as? Bool {
        return String(bool)
    } else if let string = any as? String {
        return "\"\(string)\""
    }

    let indentedString: (String) -> String = {
        $0.components(separatedBy: CharacterSet.newlines).map { $0.isEmpty ? "" : "\n    \($0)" }.joined(separator: "")
    }
    
    var mirror = Mirror(reflecting: any)
    
    var properties = Array(mirror.children)
    
    guard let displayStyle = mirror.displayStyle else {
        return String(describing: any)
    }
    
    switch displayStyle {
    case .tuple:
        if properties.count == 0 { return "()" }
        
        var string = "("
        
        for (index, property) in properties.enumerated() {
            if property.label!.first! == "." {
                string += deepDescription(property.value, omitNilValues: omitNilValues)
            }
            else {
                string += "\(property.label!): \(deepDescription(property.value, omitNilValues: omitNilValues))"
            }
            
            string += (index < properties.count - 1 ? ", " : "")
        }
        
        return string + ")"
    case .collection, .set:
        if properties.count == 0 { return "[]" }
        
        var string = "["
        
        for (index, property) in properties.enumerated() {
            string += indentedString(deepDescription(property.value, omitNilValues: omitNilValues) + (index < properties.count - 1 ? ",\n" : ""))
        }
        
        return string + "\n]"
    case .dictionary:
        if properties.count == 0 { return "[:]" }
        
        var string = "["
        
        for (index, property) in properties.enumerated() {
            let pair = Array(Mirror(reflecting: property.value).children)
            
            string += indentedString("\(deepDescription(pair[0].value, omitNilValues: omitNilValues)): \(deepDescription(pair[1].value, omitNilValues: omitNilValues))" + (index < properties.count - 1 ? ",\n" : ""))
        }
        
        return string + "\n]"
    case .enum:
        if let any = any as? CustomDebugStringConvertible {
            return any.debugDescription
        }
        
        if properties.count == 0 { return "\(mirror.subjectType)." + String(describing: any) }
        
        var string = "\(mirror.subjectType).\(properties.first!.label!)"
        
        let associatedValueString = deepDescription(properties.first!.value, omitNilValues: omitNilValues)
        
        if associatedValueString.first! == "(" {
            string += associatedValueString
        }
        else {
            string += "(\(associatedValueString))"
        }
        
        return string
    case .struct, .class:
        var string = ""
        while true {
            if let any = any as? CustomDebugStringConvertible {
                return any.debugDescription
            }
            
            if properties.count == 0 {
                string += String(describing: any)
            } else {
                string += "<\(mirror.subjectType)"
                
                if displayStyle == .class {
                    string += ": \(Unmanaged<AnyObject>.passUnretained(any as AnyObject).toOpaque())"
                }
                
                string += "> {"
                
                for (index, property) in properties.enumerated() {
                    if deepUnwrap(property.value) != nil {
                        string += indentedString("\(property.label!): \(deepDescription(property.value, omitNilValues: omitNilValues))" + (index < properties.count - 1 ? ",\n" : ""))
                    }
                }
                
                string += "\n}"
            }
            guard let superclassMirror = mirror.superclassMirror else {
                break
            }
            mirror = superclassMirror
            properties = Array(mirror.children)
            string += "\n"
        }
        return string
    case .optional:
        fatalError("deepUnwrap must have failed...")
    @unknown default:
        fatalError("deepUnwrap must have failed...")
    }
}

func deepUnwrap(_ any: Any) -> Any? {
    let mirror = Mirror(reflecting: any)
    
    if mirror.displayStyle != .optional {
        return any
    }
    
    if let child = mirror.children.first, child.label == "some" {
        return deepUnwrap(child.value)
    }
    
    return nil
}
