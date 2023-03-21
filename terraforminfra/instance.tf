resource "aws_instance" "jenkin" {
  ami                         = var.ami_id
  associate_public_ip_address = true
  instance_type               = var.instance_type
  key_name                    = data.aws_key_pair.mykey.key_name
  vpc_security_group_ids      = [aws_security_group.myrsgroup.id]
  subnet_id                   = aws_subnet.my_subnet.id
  availability_zone = "ap-south-1a"

  tags = {
    "Name" = "jenkins"
  }
}
   resource "null_resource" "jenkinnull" {
    triggers = {
   cluster_instance_ids = 1.1
  }
    connection {
    type     = "ssh"
    user     = "centos"
    host        = aws_instance.jenkin.public_ip
    private_key = file("~/.ssh/id_rsa")
   }


provisioner "remote-exec" {
    
inline = [
"sudo yum update -y",
"sudo yum install java-11-openjdk -y",
"sudo yum install git -y",
"sudo yum install wget -y",
"sudo yum install curl -y",
"sleep 2m",
"sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key",
"sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo"
"sudo yum install jenkins -y",
"sudo systemctl start jenkins",
"sudo systemctl enable jenkins",
"sudo yum update -y",
  ]
  }
}



resource "aws_instance" "node1" {
  ami                         = var.ami_id
  associate_public_ip_address = true
  instance_type               = var.instance_type
  key_name                    = data.aws_key_pair.mykey.key_name
  vpc_security_group_ids      = [aws_security_group.myrsgroup.id]
  subnet_id                   = aws_subnet.my_subnet.id
  availability_zone           = "ap-south-1a"

  tags = {
    "Name" = "node1"
  }

}
resource "null_resource" "node1null" {
    triggers = {
   cluster_instance_ids = 1.1
  }
    connection {
    type     = "ssh"
    user     = "centos"
    host        = aws_instance.node1.public_ip
    private_key = file("~/.ssh/id_rsa")
   }


provisioner "remote-exec" {
    
inline = [
       "sudo yum update -y",
       "sudo yum install java-1.8.0-openjdk-devel -y",  
       "sudo yum install java-11-openjdk -y", 
       "sudo yum install wget -y",
       "sudo yum install git -y",
       "sudo yum install maven -y",
  ]
  }
}





