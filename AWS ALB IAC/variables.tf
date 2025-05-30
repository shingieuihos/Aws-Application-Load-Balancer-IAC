variable "vpc_id" {
  description = "VPC ID for the target group"
  type        = string
  default     = "vpc-085ca11b340851223"
}

variable "subnet_ids" {
  description = "Subnets for the ALB"
  type        = list(string)
  default     = ["subnet-02bf6269854a46c62", "subnet-038d2c5fc0a323c69"]
}

variable "ec2_instance_ids" {
  description = "EC2 instance IDs to register in the target group"
  type        = list(string)
  default     = ["i-038228912e3ceff3b", "i-0be65ed59418be096"]
}

variable "alb_security_group_id" {
  description = "Security group ID for the ALB"
  type        = string
  default     = "sg-04435b410a4615c87"
}
