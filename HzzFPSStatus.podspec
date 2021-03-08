Pod::Spec.new do |s|
    s.name         = "HzzFPSStatus"
    s.version      = "0.0.1"
    s.summary      = "监测FPS"
    s.homepage     = 'https://github.com/hzz2020/HzzFPS'
    s.license      = 'MIT'
    s.authors      = {'大辉郎' => '515042611@qq.com'}
    s.platform     = :ios, '9.0'
    s.source       = {:git => 'https://github.com/hzz2020/HzzFPS.git', :tag => s.version}
    s.source_files = 'HzzFPS/*.{h,m}'
    # s.resource     = 'MJRefresh/MJRefresh.bundle'
    s.requires_arc = true
end