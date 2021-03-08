Pod::Spec.new do |spec|
  spec.name         = "HzzFPS"
  spec.version      = "0.0.1"
  spec.summary      = "监测FPS值."
  spec.homepage     = "https://github.com/hzz2020/HzzFPS"
  spec.license      = "MIT"
  spec.platform     = :ios, '9.0'
  spec.author       = { "大辉郎" => "515042611@qq.com" }
  spec.source       = { :git => "https://github.com/hzz2020/HzzFPS.git", :tag => "#{spec.version}" }
  spec.source_files = 'HzzFPS/**/*.{h,m}'
  spec.requires_arc = true
end
