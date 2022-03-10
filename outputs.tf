output "droplet_limit" {
  description = <<-EOF
    Return the digital ocean account droplet limit
EOF

  value = data.digitalocean_account.account_details.droplet_limit
}

output "server_ipv4_address" {
  description = <<-EOF
    Return all droplet ipv4 address
EOF

  value = digitalocean_droplet.droplet.*.ipv4_address
}