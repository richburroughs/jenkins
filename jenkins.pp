# Puppet code to manage Jenkins and its dependencies.
# Tested on Ubuntu 24.04.
# Manual installation instructions: https://pkg.jenkins.io/debian/

file { '/etc/apt/keyrings/jenkins-keyring.asc':
    ensure => file,
    source => '/vagrant/files/jenkins-keyring.asc',
}

file { '/etc/apt/sources.list.d/jenkins.list':
    ensure  => file,
    source  => '/vagrant/files/jenkins_apt_sources',
    require => File['/etc/apt/keyrings/jenkins-keyring.asc']
}

exec {'apt update':
    subscribe   => [File['/etc/apt/keyrings/jenkins-keyring.asc'],File['/etc/apt/sources.list.d/jenkins.list']],
    refreshonly => true,
    user        => 'root',
    command     => '/usr/bin/apt update',
}

package { 'fontconfig':
    ensure  => installed,
    name    => 'fontconfig',
}

package { 'openjdk-17-jdk':
    ensure  => installed,
    name    => 'openjdk-17-jdk',
}

package { 'jenkins':
    ensure  => present,
    name    => 'jenkins',
    require => [File['/etc/apt/sources.list.d/jenkins.list'],Package['fontconfig'],Package['openjdk-17-jdk']],
}

# The HTTP Port that's used is the one in this file, not the one
# in /etc/default/jenkins.

file { '/usr/lib/systemd/system/jenkins.service':
    ensure  => file,
    source  => '/vagrant/files/jenkins.service',
    require => Package['jenkins'],
}

service {'jenkins.service':
    ensure    => running,
    enable    => true,
    subscribe => File['/usr/lib/systemd/system/jenkins.service'],
}
