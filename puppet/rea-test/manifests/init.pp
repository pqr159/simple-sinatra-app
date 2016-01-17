# == Class: rea-test

# === Notes
# Istalls the test ruby app

class rea-test {
    include rea-test::firewall
	include rea-test::sshd
    include rea-test::unicorn
    include rea-test::simple-sinatra-app
}
