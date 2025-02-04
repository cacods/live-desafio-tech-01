variable "aws_region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "sandbox_id" {
  description = "Source id of the sandbox"
  type        = string
  default     = "live-devops-elite"
}

variable "private_subnets" {
  description = "The private subnets"
  type        = set(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  description = "The public subnets"
  type        = set(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "eks_name" {
  description = "The EKS cluster name"
  type        = string
  default     = "live-devops-elite-cluster"
}
