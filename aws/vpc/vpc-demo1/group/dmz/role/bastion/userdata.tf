data "template_file" "cloudconfig" {
  count    = "${length(var.hostname)}"
  template = "${file("${path.module}/userdata_files/cloudconfig.tpl")}"
  vars     = {}
}

data "template_file" "bootscript" {
  count    = "${length(var.hostname)}"
  template = "${file("${path.module}/userdata_files/bootscript.tpl")}"

  vars = {
    hostname       = "${element(var.hostname, count.index)}"
    domainname     = "${var.domainname}" 
  }
}

# Merge cloudconfig and bootstrap scripts to feed userdata
data "template_cloudinit_config" "userdata" {
  count         = "${length(var.hostname)}"
  gzip          = true
  base64_encode = true

  part {
    filename     = "cloudconfig.cfg"
    content      = "${element(data.template_file.cloudconfig.*.rendered, count.index)}"
    content_type = "text/cloud-config"
  }

  part {
    filename     = "bootscript.sh"
    content      = "${element(data.template_file.bootscript.*.rendered, count.index)}"
    content_type = "text/x-shellscript"
  }

}
