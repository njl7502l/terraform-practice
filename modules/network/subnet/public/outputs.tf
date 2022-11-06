output "public_ids" {
  value = tomap({
    for k, subnet in aws_subnet.public_subnets : k => subnet.id
  })
}

output "set_public_ids" {
  value = toset([for subnet in aws_subnet.public_subnets : subnet.id])
}
