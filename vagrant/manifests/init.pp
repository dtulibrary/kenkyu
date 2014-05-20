include vagrant_hosts

class {'apache2':
}
class {'kenkyu':
  rails_env  => 'unstable',
  conf_set   => 'vagrant',
  vhost_name => 'kenkyu.vagrant.vm',
}

