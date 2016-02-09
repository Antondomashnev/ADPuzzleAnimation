Pod::Spec.new do |s|
  
  s.name         = 'PuzzleAnimation'
  s.version      = '1.0.0'
  s.summary      = "Custom view animation"

  s.description  = <<-DESC
                    Inspired by Fabric - Answers animation. Allows to "build" given view with pieces. Allows to "destroy" given view into pieces.
                   DESC

  s.license      = { :type => "MIT", :file => "LICENSE" }             
  s.homepage     = 'https://github.com/Antondomashnev/ADPuzzleAnimation'
  s.author       = { 'Anton Domashnev' => 'antondomashnev@gmail.com' }

  s.source       = { :git => "https://github.com/Antondomashnev/ADPuzzleAnimation.git", :tag => s.version.to_s}
  s.platform = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.source_files = 'Source/**/*.swift'
  
end
