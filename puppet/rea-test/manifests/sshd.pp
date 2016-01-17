# == Class: rea-test::sshd

class rea-test::sshd {
    $service_name = 'ssh'
    $source_file = 'sshd_config'

    file {
        '/etc/ssh/sshd_config':
            ensure  => present,
            owner   =>  'root',
            group   =>  'root',
            mode    =>  '0644',
            source  =>  "puppet:///modules/rea-test/sshd/${source_file}",
            notify  =>  Service["${service_name}"];
    }
    service {
        "${service_name}" :
            ensure      => running,
            hasrestart  => true;
    }
}
