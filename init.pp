file { '/etc/apt/keyrings/jenkins-keyring.asc':
    ensure => file,
    source => '/vagrant/files/jenkins-keyring.asc',
}

file { '/etc/apt/sources.list.d/jenkins.list':
    ensure  => file,
    source  => '/vagrant/files/jenkins_apt_sources',
    require => File['/etc/apt/keyrings/jenkins-keyring.asc']
}

package { 'jenkins':
    ensure  => present,
    name    => 'jenkins',
    require => File['/etc/apt/sources.list.d/jenkins.list']
}

file { '/etc/default/jenkins':
    ensure  => file,
    source  => '/vagrant/files/jenkins_conf',
    require => Package['jenkins'],
}

service {'jenkins.service':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/default/jenkins'],
}




# sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
#    https://pkg.jenkins.io/debian/jenkins.io-2023.key
  
# echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
#    https://pkg.jenkins.io/debian binary/ | sudo tee \
#    /etc/apt/sources.list.d/jenkins.list > /dev/null

# sudo apt install openjdk-17-jdk

# sudo apt-get install jenkins

