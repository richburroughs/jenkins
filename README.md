Testing requires Vagrant. To install it with Homebrew:

```
brew install vagrant
```

Or you can get binaries [from Hashicorp](https://developer.hashicorp.com/vagrant/install).

## Testing

Run these commands to provision the VM and connect:

```
vagrant up
vagrant ssh
```

On the VM run these commands:

```
sudo apt-get update
sudo apt-get install puppet-agent
```

Run the Puppet manifest:
```
cd /vagrant
sudo puppet apply -v jenkins.pp
```
