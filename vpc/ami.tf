resource "null_resource" "build_custom_ami" {
  triggers = {
    aws_ami_id      = data.aws_ami.ubuntu.id
    #sha256_userdata = filesha256("deploy/packer-customize.sh")
  }
 
  provisioner "local-exec" {
    environment = {
      VAR_AWS_REGION = var.AWS_REGION
      VAR_AWS_AMI_ID = data.aws_ami.ubuntu.id
    }
 
    command = <<EOF
    set -ex;
    packer validate \
      -var "aws_region=$VAR_AWS_REGION" \
      packer-configs/custom_ami.json
    packer build \
      -var "aws_region=$VAR_AWS_REGION" \
      packer-configs/custom_ami.json
EOF
  }
}
