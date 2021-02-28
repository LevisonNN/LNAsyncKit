Pod::Spec.new do |s|
  s.name         = "LNAsyncKit"
  s.version      = "0.0.1"
  s.summary      = "An async feed stream framework."
  s.homepage     = "https://github.com/LevisonNN/LNAsyncKit"
  s.author             = { "Levison" => "levisoncn@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/LevisonNN/LNAsyncKit.git", :tag => "#{s.version}" }
  #s.source_files  = "Classes", "LNAsyncKit/LNAsyncKit/**/*.{h,m}"
  s.source_files  = "LNAsyncKit/LNAsyncKit/LNAsyncKit.h"
  s.license      = "MIT"
  s.requires_arc = true

  s.subspec 'Element' do |ss|
    ss.source_files = "LNAsyncKit/LNAsyncKit/Element/**/*.{h,m}"
  end

  s.subspec 'Cache' do |ss|
    ss.source_files = "LNAsyncKit/LNAsyncKit/Cache/**/*.{h,m}"
  end

  s.subspec 'Range' do |ss|
    ss.source_files = "LNAsyncKit/LNAsyncKit/Range/**/*.{h,m}"
  end
  
  s.subspec 'Transaction' do |ss|
    ss.source_files = "LNAsyncKit/LNAsyncKit/Transaction/**/*.{h,m}"
  end

  s.subspec 'Renderer' do |ss|
    ss.source_files = "LNAsyncKit/LNAsyncKit/Renderer/**/*.{h,m}"
    ss.dependency "LNAsyncKit/Element"
  end
end

