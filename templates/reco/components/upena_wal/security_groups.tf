resource "aws_security_group" "upena_wal_sg" {
  name        = "${var.region}-${var.aws_account_short_name}-upena-wal"
  description = "Allows necessary communication between upena-wal instances"
  vpc_id      = "${var.aws_vpc_main}"

  ingress {
    from_port   = 1175
    to_port     = 1175
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 10000
    to_port     = 11000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name              = "${var.region}-${var.aws_account_short_name}-upena-wal"
    Pipeline_phase    = "${var.env}"
    Jive_service      = "${var.jive_service}"
    Service_component = "upena-wal"
    Region            = "${var.region}"
    SLA               = "${var.sla}"
    Account_name      = "${var.aws_account_short_name}"
  }
}
