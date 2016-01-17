Simple Sinatra + Unicorn + Nginx Deployment

- Expects Ubuntu Hosts
- Accessible via SSH
- Requires Internet Access
- No puppet master required as the script will be validated locally using 'puppet apply'


HOW-TO 

Usage

1. Deploy solution 
	
	chmod +x install.sh
	./install.sh

	Installs puppet agent using the script in this repository.

2. Add 'rea-test' puppet class to puppet module directory.
3. Run the following command to test configuration

	puppet apply -e "include rea-test" --verbose

4. Access the webserver using the machine's IP.


What It Does
1. Setup iptables firewall 
2. SSHD lockdown.
3. Installs Nginx+Unicorn
4. Installs required ruby gems, simple-sinatra-app


Ideas For Improvement
1. Run Unicorn under Supervisord / Daemontools to improve HA
2. Kernel hardening  tuning.
3. Configuration for CentOS  RHEL

Tested on
Ubuntu 15.04 LTS x64