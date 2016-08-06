name             'jenkins'
maintainer       'MBO'
maintainer_email 'mbopartners@mbo.com'
license          'All rights reserved'
description      'Installs/Configures jenkins'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

depends 'nginx', '>= 2.7.4'
depends 'firewall', '>= 2.3.0'
depends 'java'
