class ldap {
  
  package { 'openldap-servers': 
    ensure => 'latest',
  }

  package { 'openldap-clients': 
    ensure => 'latest',
  }
  
  package {'httpd':
    ensure  => 'present',
    require => Package['openldap-servers'],
  }

  file {'/etc/openldap/slapd.d':
    ensure   => absent,
    recurse  => true,
    purge    => true,
    force    => true,
    require  => Package['openldap-servers'],
  }
  
  file { '/etc/openldap/slapd.conf':
    ensure  => file,
    content => template('ldap/slapd.erb'),
    owner   => ldap,
    group   => ldap,
    mode    => '0644',
    backup  => false,
    require => File['/etc/openldap/slapd.d'],
  }

  service { 'slapd':
    ensure  => 'running',
    enable  => 'true',
    require => File['/etc/openldap/slapd.conf'],
  }
  
  package {'phpldapadmin':
    ensure  => 'latest',
    require => Package['httpd'],
  }

  file {'/etc/httpd/conf.d/phpldapadmin.conf':
    ensure  => file,
    content => template('ldap/phpldapadmin.erb'),
    owner   => httpd,
    group   => httpd,
    mode    => '0644',
    backup  => false,
    require => Package['phpldapadmin'],
  }
  
  service { 'httpd':
    ensure  => 'running',
    enable  => 'true',
    require => File['/etc/httpd/conf.d/phpldapadmin.conf']
  }
}
