puppet_scratch=$HOME/puppet-scratch
puppet_scratch_ruby=$puppet_scratch/ruby

puppet_scratch_agent_conf=$puppet_scratch/agent/conf
puppet_scratch_agent_var=$puppet_scratch/agent/var

puppet_scratch_master_conf=$puppet_scratch/master/conf
puppet_scratch_master_var=$puppet_scratch/master/var

host_lower=`echo $HOST | tr '[:upper:]' '[:lower:]'`

alias puppetenv="export RUBYLIB=\"$puppet_scratch_ruby/puppet/lib:$puppet_scratch_ruby/facter/lib:$puppet_scratch_ruby/puppetdb/lib\"; export PATH=\$PATH:$puppet_scratch_ruby/puppet/bin:$puppet_scratch_ruby/facter/bin"

alias puppetrunagent="echo \"puppet agent --no-daemonize --debug --trace --verbose --confdir=$puppet_scratch_agent_conf --vardir=$puppet_scratch_agent_var --server localhost --certname $host_lower --onetime\""

alias puppetrunmaster="echo \"puppet master --no-daemonize --debug --trace --verbose --confdir=$puppet_scratch_master_conf --vardir=$puppet_scratch_master_var --autosign=true --certname localhost\""
