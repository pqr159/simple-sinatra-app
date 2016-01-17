# == Class: rea-test::unicorn

class rea-test::unicorn {
    FILE {
        owner   => 'root',
        group   => 'root',
    }
    package {
        'nginx-core':
            ensure  => latest,
            notify  => Service['nginx'];
        ['git', 'ruby', 'ruby-dev', 'rubygems', 'build-essential']:
            ensure  => latest;
		['sinatra', 'unicorn']:
  			ensure   => 'latest',
  			provider => 'gem';
        'bundle':
            ensure      => latest,
            require     => Package['rubygems'],
            provider    => 'gem';
    }
    service {
        'nginx':
            ensure  => running,
            require => Package['nginx-core'];
    }

}
