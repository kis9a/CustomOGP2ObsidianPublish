provider "aws" {
  region  = "ap-northeast-1"
  profile = "kis9a"

  default_tags {
    tags = {
      Service = "${var.service_name}"
    }
  }
}

provider "aws" {
  alias   = "virginia"
  region  = "us-east-1"
  profile = "kis9a"

  default_tags {
    tags = {
      Service = "${var.service_name}"
    }
  }
}
