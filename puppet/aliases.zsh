puppet_scratch=$HOME/puppet-scratch
puppet_scratch_ruby=$puppet_scratch/ruby

puppet_scratch_agent_conf=$puppet_scratch/agent/conf
puppet_scratch_agent_var=$puppet_scratch/agent/var

puppet_scratch_master_conf=$puppet_scratch/master/conf
puppet_scratch_master_var=$puppet_scratch/master/var

host_lower=`echo $HOST | tr '[:upper:]' '[:lower:]'`

alias puppetenv="export RUBYLIB=\"$puppet_scratch_ruby/puppet/lib:$puppet_scratch_ruby/facter/lib:$puppet_scratch_ruby/facter/release/lib:$puppet_scratch_ruby/hiera/lib:$puppet_scratch_ruby/puppetdb/lib:$puppet_scratch_ruby/puppet/acceptance/lib\"; export PATH=$puppet_scratch_ruby/puppet/bin:$puppet_scratch_ruby/facter/bin:\$PATH"

alias puppetrunagent="echo \"puppet agent --no-daemonize --debug --trace --verbose --confdir=$puppet_scratch_agent_conf --vardir=$puppet_scratch_agent_var --server localhost --certname $host_lower --onetime\""

alias puppetrunmaster="echo \"puppet master --no-daemonize --debug --trace --verbose --confdir=$puppet_scratch_master_conf --vardir=$puppet_scratch_master_var --autosign=true --certname localhost\""

alias puppetrunmasterwpuppetdb="echo \"puppet master --no-daemonize --debug --trace --verbose --confdir=$puppet_scratch_master_conf --vardir=$puppet_scratch_master_var --autosign=true --certname localhost --config=$puppet_scratch_master_conf/puppet-with-puppetdb.conf\""

puppet_core=$HOME/repos/puppet
facter_core=$HOME/repos/facter
hiera_core=$HOME/repos/hiera
puppetdb_core=$HOME/repos/puppetdb

alias puppetcoreenv="export RUBYLIB=\"$puppet_core/lib:$facter_core/lib:$facter_core/release/lib:$hiera_core/lib:$puppetdb_core/puppet/lib\"; export PATH=$puppet_core/bin:$facter_core/bin:\$PATH"

alias puppetpurgevardir="rm -fr $puppet_scratch_master_var/reports/*; rm -fr $puppet_scratch_master_var/yaml/facts/*; rm -fr $puppet_scratch_master_var/yaml/node/*"

puppet_scratch_master_var=$puppet_scratch/master/var
