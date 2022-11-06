output "public_ids" {
  value = tomap({
    for k, subnet in aws_subnet.public_subnets : k => subnet.id
  })
}
