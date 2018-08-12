# resource "aws_autoscaling_group" "asg" {
#   name                      = "20180811-test-asg-tf"
#   max_size                  = 2
#   min_size                  = 1
#   health_check_grace_period = 300
#   health_check_type         = "EC2"
#   desired_capacity          = 2
#   force_delete              = false
#   launch_configuration      = "${aws_launch_configuration.as_conf.name}"
#   vpc_zone_identifier       = ["<subnet-id>"]

#   tag {
#     key                 = "name"
#     value               = "test-asg"
#     propagate_at_launch = true
#   }

#   timeouts {
#     delete = "15m"
#   }
# }

resource "aws_cloudformation_stack" "asg" {
  name = "test-asg-tf-20180812"

  template_body = "${data.template_file.asg_cloudformation.rendered}"
}

data "template_file" "asg_cloudformation" {
  template = "${file("asg.json")}"

  vars {
    launch_config_name  = "${aws_launch_configuration.as_conf.name}"
    node_max_size       = "5"
    node_min_size       = "1"
    node_desired_size   = "5"
    subnet = "<subnet-id>"
  }
}
