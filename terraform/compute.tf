# Création d'un volume EBS (Elastic Block Store) pour les données persistantes
# c'est comme un disque dur virtuel dans le cloud AWS
resource "aws_ebs_volume" "data" {
  availability_zone = "${var.aws_region}a"
  size              = 8
  type              = "gp2"

  tags = {
    Name = "${var.project_name}-data-volume"
  }
}

# Instance EC2
resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.instance.id]
  subnet_id              = aws_subnet.public.id

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }

  tags = {
    Name = "${var.project_name}-web-instance"
  }

  # Assure que Python est installé pour Ansible
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y python3 python3-pip
              EOF
}

# Attacher le volume EBS à l'instance
resource "aws_volume_attachment" "data_attachment" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.data.id
  instance_id = aws_instance.web.id
}

# IP Élastique pour l'instance
resource "aws_eip" "web" {
  vpc      = true
  instance = aws_instance.web.id

  tags = {
    Name = "${var.project_name}-web-eip"
  }
}