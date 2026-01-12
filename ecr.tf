resource "aws_ecr_repository" "ecr_node" {
  name                 = "node-prod"
  image_tag_mutability = "MUTABLE"
}