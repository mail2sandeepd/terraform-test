resource "aws_instance" "server1" {
ami = lookup (var.aws_amis, var.aws_region)
instance_type = lookup (var.aws_type, var.aws_region)
tags = {
    Name = lower("Sandeep-instance")
}
user_data = templatefile("user_data.tftpl", {user = var.aws_user})
key_name = "sandeep-terraform"
}