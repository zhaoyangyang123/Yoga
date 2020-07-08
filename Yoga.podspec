# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

package = {'version'=>'1.14.0'}
version = package['version']

source = { :git => 'https://github.com/zhaoyangyang123/Yoga.git' }
if version == '1000.0.0'
  # This is an unpublished version, use the latest commit hash of the react-native repo, which we’re presumably in.
  source[:commit] = `git rev-parse HEAD`.strip
else
  source[:tag] = "v#{version}"
end

Pod::Spec.new do |spec|
  spec.name = 'Yoga'
  spec.version = version
  spec.license =  { :type => 'MIT' }
  spec.homepage = 'https://yogalayout.com'
  spec.documentation_url = 'https://yogalayout.com/docs/'

  spec.summary = 'Yoga is a cross-platform layout engine which implements Flexbox.'
  spec.description = 'Yoga is a cross-platform layout engine enabling maximum collaboration within your team by implementing an API many designers are familiar with, and opening it up to developers across different platforms.'

  spec.authors = 'Facebook'
  spec.source = source

  spec.module_name = 'yoga'
  spec.header_dir = 'yoga'
  spec.requires_arc = false
  spec.pod_target_xcconfig = {
      'DEFINES_MODULE' => 'YES'
  }
  spec.compiler_flags = [
      '-fno-omit-frame-pointer',
      '-fexceptions',
      '-Wall',
      '-Werror',
      '-std=c++1y',
      '-fPIC'
  ]

  # Pinning to the same version as React.podspec.
  spec.platforms = { :ios => "9.0", :tvos => "9.2" }

  # Set this environment variable when *not* using the `:path` option to install the pod.
  # E.g. when publishing this spec to a spec repo.
  source_files = 'yoga/**/*.{h,cpp}'
  source_files = File.join('ReactCommon/yoga', source_files) if ENV['INSTALL_YOGA_WITHOUT_PATH_OPTION']
  spec.source_files = source_files

  header_files = 'yoga/{Yoga,YGEnums,YGMacros,YGValue}.h'
  header_files = File.join('ReactCommon/yoga', header_files) if ENV['INSTALL_YOGA_WITHOUT_PATH_OPTION']
  spec.public_header_files = header_files
end
