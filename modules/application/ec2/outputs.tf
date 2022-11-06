output "instance_ids" {
  value = toset([for instance in aws_instance.testEC2 : instance.id])
}
