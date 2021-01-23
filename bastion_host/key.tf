resource "aws_key_pair" "mykeypair" {
  key_name   = "mykey"
  public_key = var.pub-key
}