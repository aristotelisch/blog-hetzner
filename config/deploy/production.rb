 server 'marty.happybit.eu', user: 'deploy', roles: %w{web app db}, port: 56

# Use agent forwarding for SSH so you can deploy with the SSH key on your workstation.
set :ssh_options, {
  port: 56,
  forward_agent: true
}
