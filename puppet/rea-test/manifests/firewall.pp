# == Class: rea-test::firewall

class rea-test::firewall {
    FILE {
        owner   => 'root',
        group   => 'root',
    }
    exec {
        'fix_rule':
            command     => '/bin/sh -x /etc/iptables',
            refreshonly =>  true,
            notify      =>  Exec['save_rules'];
        'save_rules':
            command     => '/bin/sh -c "iptables-save > /etc/iptables.rules"',
            refreshonly =>  true;
    }
    file {
        '/etc/iptables':
            ensure  => present,
            mode    => '0600',
            source  => 'puppet:///modules/rea-test/firewall/iptables',
            notify  => Exec['fix_rule'];
        '/etc/network/if-pre-up.d/iptablesload':
            ensure  => present,
            mode    => '0755',
            source  => 'puppet:///modules/rea-test/firewall/iptablesload';
        '/etc/network/if-post-down.d/iptablessave':
            ensure  => present,
            mode    => '0755',
            source  => 'puppet:///modules/rea-test/firewall/iptablessave';
    }

}
