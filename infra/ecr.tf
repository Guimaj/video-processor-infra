data "aws_caller_identity" "current" {}

################################################################################
# ECR Repository
################################################################################

module "processor_repository" {
  source  = "terraform-aws-modules/ecr/aws"

  repository_name = "videoprocessor-repository"

  repository_read_write_access_arns = [data.aws_caller_identity.current.arn]
  create_lifecycle_policy           = true
  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last 30 images",
        selection = {
          tagStatus     = "tagged",
          tagPrefixList = ["v"],
          countType     = "imageCountMoreThan",
          countNumber   = 30
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  repository_force_delete = true

  tags = {
    Name = "videoprocessor-repository"
  }
}