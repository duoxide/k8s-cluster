output "master_public_ip" {
  description = "IPv4 of the Master instance"
  value       = {
    for instance in aws_instance.master-instance:
    instance.tags["Name"] => instance.public_ip
  }
}

output "master_public_dns" {
  description = "DNSv4 of the Master instance"
  value       = {
    for instance in aws_instance.master-instance:
    instance.tags["Name"] => instance.public_dns
  }
}

output "worker_public_ip" {
  description = "IPv4 of the Worker instances"
  value       = {
    for instance in aws_instance.worker-instance:
    instance.tags["Name"] => instance.public_ip
  }
}

output "worker_public_dns" {
  description = "DNSv4 of the Master instance"
  value       = {
    for instance in aws_instance.worker-instance:
    instance.tags["Name"] => instance.public_dns
  }
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}