output "private_ids" {
  value = tomap({
    for k, subnet in aws_subnet.private_subnets : k => subnet.id
  })
}
