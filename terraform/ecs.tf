# ECS cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ecs-cluster_test"
}

resource "aws_ecs_task_definition" "hello_task" {
  family                   = "hello-task"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  execution_role_arn = data.aws_iam_role.task_ecs.arn
  task_role_arn      = data.aws_iam_role.task_ecs.arn

  container_definitions = jsonencode([
    {
      name      = "hello-app"
      image     = "${var.aws_account_id}.dkr.ecr.${var.region}.amazonaws.com/hello-app:latest"
      essential = true
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
          protocol      = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "hello" {
  name            = "hello-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.hello_task.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]
    security_groups  = [aws_security_group.esc_cluster_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.hello_lb_tg.arn
    container_name   = "hello-app"
    container_port   = 5000
  }
}

# Security Group for ESC Cluster
resource "aws_security_group" "esc_cluster_sg" {
  name        = "ecs-cluster-sg"
  description = "Security group for ESC cluster"

  vpc_id = data.aws_vpc.default_vpc.id

  ingress {
    from_port       = 5000
    to_port         = 5000
    protocol        = "tcp"
    security_groups = [data.aws_security_group.hello_lb_sg.id]
  }

  egress {
    cidr_blocks = var.allowed_cidr_blocks
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
}

data "aws_security_group" "hello_lb_sg" {
  name   = "alb-sg"
  vpc_id = data.aws_vpc.default_vpc.id
  // this sg has inbound port 80, tcp, http. and outbound all.
}

# Load Balancer for ECS Service
resource "aws_lb" "hello_lb" {
  name               = "hello-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.hello_lb_sg.id]
  subnets            = [aws_subnet.public_subnet_a.id, aws_subnet.public_subnet_b.id]

  enable_deletion_protection = false
}

resource "aws_lb_listener" "hello_lb_listener" {
  load_balancer_arn = aws_lb.hello_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.hello_lb_tg.arn
  }
}

resource "aws_lb_target_group" "hello_lb_tg" {
  name        = "hello-tg"
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default_vpc.id
  target_type = "ip"
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}
