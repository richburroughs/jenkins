class jenkins {

    file { '/etc/apt/keyrings/jenkins-keyring.asc':
        ensure => file,
        source => '/vagrant/jenkins-keyring.asc'
    }

    file { '/etc/apt/sources.list.d/jenkins.list':
        ensure => file,
        source => '/vagrant/jenkins_apt_sources'
    }









    package { "jenkins":
        ensure => present,
        name: 'jenkins'
    }







# sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
#    https://pkg.jenkins.io/debian/jenkins.io-2023.key
  
# echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
#    https://pkg.jenkins.io/debian binary/ | sudo tee \
#    /etc/apt/sources.list.d/jenkins.list > /dev/null

# sudo apt install openjdk-17-jdk

# sudo apt-get install jenkins

    
}
