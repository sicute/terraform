####
provider "aws" {
  profile = "dev"
  region     = "ap-southeast-1"
}

#################################################################################

resource "aws_spot_instance_request" "spotstagapp" {

  ami                         = "ami-05c1c1xxxxxx"
  instance_type               = "t3a.micro"
  wait_for_fulfillment = true
  spot_type = "one-time"
  spot_price = "0.003"
  key_name                    = "staging-bc"
  monitoring                  = true
  vpc_security_group_ids      = ["sg-2aa7xx","sg-cf1cexxx"]
  subnet_id                   = "subnet-bccxxx"
  associate_public_ip_address = false
  user_data		      = "./provisioning/userdata.txt"

  tags = {
    Name = "spot-stagging"
    Environtment	= "dev"
    CreateBy    	= "sonjayaterraform"
    }
}

#################################################################################
#################################################################################
#################################################################################


#################################################################################
#################################################################################
#################################################################################
output "public_ip" {
  value       = aws_spot_instance_request.spotstagapp.public_ip
  description = "The public IP of the web server"
}
output "internal_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value = aws_spot_instance_request.spotstagapp.private_ip

}

