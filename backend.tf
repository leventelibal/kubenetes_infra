terraform {
  backend "s3" {
    bucket = "kubeleventstate.com"
    key    = "terrastate"
    region = "us-west-2"
  }
}
