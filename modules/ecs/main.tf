resource "aws_ecs_cluster" "main" {
  name = "production-ecs-cluster"
}
resource "aws_ecs_service" "app_service" {

  name = "app-service"

  cluster = aws_ecs_cluster.main.id

  task_definition = aws_ecs_task_definition.app.arn

  desired_count = 2

  launch_type = "EC2"

  load_balancer {

    target_group_arn = var.target_group_arn

    container_name = "nginx"

    container_port = 80
  }

}
resource "aws_ecs_task_definition" "app" {
  family                   = "production-app"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name  = "nginx"
      image = "nginx:latest"

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}



data "aws_ssm_parameter" "ecs_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

resource "aws_launch_template" "ecs_template" {

  name_prefix   = "ecs-template"

  image_id      = data.aws_ssm_parameter.ecs_ami.value

  instance_type = "t3.micro"

  iam_instance_profile {
    name = var.instance_profile_name
  }

  network_interfaces {

    associate_public_ip_address = false

    security_groups = [
  var.ecs_sg_id
   ]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
EOF
  )
}
resource "aws_autoscaling_group" "ecs_asg" {

  desired_capacity = 2
  max_size         = 4
  min_size         = 2

  vpc_zone_identifier = [
  var.private_subnet_1_id,
  var.private_subnet_2_id
 ]

  launch_template {
    id      = aws_launch_template.ecs_template.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "ecs-instance"
    propagate_at_launch = true
  }
}
resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/production"
  retention_in_days = 7
}
