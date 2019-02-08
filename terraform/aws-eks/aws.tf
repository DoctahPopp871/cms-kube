provider "aws" {
    assume_role {
      role_arn     = "${var.aws_role_arn}"
    }
    region = "${var.aws_region}"
    #shared_credentials_file = "${var.shared_credentials_file}"
    #profile                 = "${var.profile}"
}


## Need to Add notification element to Auto-Scaling group
## Consider using K8s provider to inculde Dashboard packages as prereq.
