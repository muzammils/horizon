data "template_file" "cloud_config" {
  template = "${file("${path.module}/cloud-config.yaml.template")}"

  vars {
    KubernetesCluster = "${null_resource.k8s_cluster.triggers.name}"
    MASTER_EIP_ALLOC  = "${aws_eip.k8s_master_eip.id}"
    ELB_NAME          = "${aws_elb.k8s_master.name}"
    COREOS_AUTHKEY    = "${var.coreos_authkey}"
    DOCKER_REGISTRY   = "${var.docker_registry}"
    ANSIBLE_BUCKET    = "${var.ansible_bucket}"
    PHX_PULP          = "${var.phx_pulp}"
  }
}
