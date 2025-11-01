Pod::Spec.new do |s|

  s.name         = "CYKit"
  s.version      = "1.1.9"
  s.platform     = :ios, "11.0"

  s.summary      = "this is a practice project of pod."
  s.homepage     = "https://www.apple.com"
  s.license              = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "xcode" => "xcode@apple.com" }

  s.source       = { :git => "http://182.92.213.80/droog/CYKit.git" }
  s.source_files  = "CYKit/**/*.swift"
  s.resource     = 'CYKit/CYKit.bundle'
  
  s.framework  = "UIKit","Foundation"
  s.swift_version = '5.0'
  s.requires_arc = true

end
