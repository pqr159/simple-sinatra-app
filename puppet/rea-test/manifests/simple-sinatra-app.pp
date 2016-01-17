# == Class: rea-test::simple-sinatra-app

class rea-test::simple-sinatra-app {
    FILE {
        owner   => 'root',
        group   => 'root',
    }
    include rea-test::unicorn
    exec {
        'clone_app':
            command     =>  '/usr/bin/git clone https://github.com/tnh/simple-sinatra-app.git /var/www/simple-sinatra-app',
            refreshonly => true,
            require     => Package['git'],
            notify      => Exec['install_app'];
        'install_app':
            command     => '/usr/local/bin/bundle install --gemfile /var/www/simple-sinatra-app/Gemfile',
            refreshonly => true,
            require     => [Package['bundle'],Exec['clone_app']];
		'unicorn_rails':
			command		=> '/usr/local/bin/unicorn_rails -c /var/www/simple-sinatra-app/unicorn.conf.rb -D',
			unless  => "/bin/ps aux | /bin/grep "unicorn_rails" | /bin/grep -v grep"
 			require     => File['/var/www/simple-sinatra-app/unicorn.conf.rb'];
    }
    file {
        ['/var/www', '/var/www/simple-sinatra-app']:
            ensure  => directory,
            mode    => '0755',
            notify  => Exec['clone_app'];
        '/var/log/unicorn':
            ensure  => directory,
            mode    => '0755';
		'/etc/nginx/sites-available/default':
			ensure => absent;
		'/etc/nginx/conf.d/rea-test.conf':  
			ensure => present,
			mode => '0755',
			source => 'puppet:///modules/rea-test/nginx/unicorn.conf',
			notify => Service['nginx'];
		'/var/www/simple-sinatra-app/unicorn.conf.rb':  
			ensure => present,
			mode => '0755',
			source => 'puppet:///modules/rea-test/unicorn/unicorn.conf.rb',
			notify  => Exec['unicorn_rails'];
    }
}