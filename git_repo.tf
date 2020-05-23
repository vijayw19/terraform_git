#############varialble###

variable "github_token" {}
variable "github_organization" {}
variable "github_project_name" {}
variable "file_content"  {}

###############provider##########

provider "github" {
  token = var.github_token
  organization = var.github_organization
}

########resources######

###############################creating repos################
resource "github_repository" "JAVA" {
  name         = "${var.github_project_name}"
  description  = "My first java project"
  has_projects = true
  auto_init = true
}

resource "github_repository_project" "project" {
  name       = "A Repository Project"
  repository = "${github_repository.JAVA.name}"
  body       = "This is a repository project."
}

#################### create branches ############
resource "github_branch" "development" {
  repository = "${github_repository.JAVA.name}"
  branch     = "development"
}

resource "github_branch" "release" {
  repository = "${github_repository.JAVA.name}"
  branch     = "release"
}

#################create file#######################

resource "github_repository_file" "gitignore" {
  repository = "${github_repository.JAVA.name}"
  file       = ".gitignore"
  content    = file(var.file_content)
  commit_message       = "new initial commit"
}