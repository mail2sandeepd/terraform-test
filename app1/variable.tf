variable "aws_amis" {
    type = map
    default = {
        "us-east-1" = "ami-0739f8cdb239fe9ae"
        "us-east-2" = "ami-0ebc8f6f580a04647"
    }
}

variable "aws_type" {
    type = map
    default = {
        "us-east-1" = "t2.micro"
        "us-east-2" = "t2.small"
    }
}

variable "aws_region" {
    type = string
}

variable "aws_user" {
    type = string
    default = "ibm_sandeep"
}