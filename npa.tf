resource "oci_vn_monitoring_path_analyzer_test" "cms_to_db_subnet_connectivity" {
  compartment_id = oci_identity_compartment.net_compartment.id
  display_name   = "${var.npa_display_name}-cms-to-db"
  protocol       = 6
  freeform_tags  = var.freeform_tags

  source_endpoint {
    type      = "SUBNET"
    subnet_id = oci_core_subnet.cms_worker_sub.id
    address   = var.cms_source_ip
  }

  destination_endpoint {
    type      = "SUBNET"
    subnet_id = oci_core_subnet.db_sub.id
    address   = var.db_destination_ip
  }

  protocol_parameters {
    type             = var.protocol
    destination_port = var.db_destination_port
    source_port      = var.source_port
  }

  query_options {
    is_bi_directional_analysis = var.is_bi_directional_analysis
  }
}

resource "oci_vn_monitoring_path_analyzer_test" "web_to_db_subnet_connectivity" {
  compartment_id = oci_identity_compartment.net_compartment.id
  display_name   = "${var.npa_display_name}-web-to-db"
  protocol       = 6
  freeform_tags  = var.freeform_tags

  source_endpoint {
    type      = "SUBNET"
    subnet_id = oci_core_subnet.web_worker_sub.id
    address   = var.web_source_ip
  }

  destination_endpoint {
    type      = "SUBNET"
    subnet_id = oci_core_subnet.db_sub.id
    address   = var.db_destination_ip
  }

  protocol_parameters {
    type             = var.protocol
    destination_port = var.db_destination_port
    source_port      = var.source_port
  }

  query_options {
    is_bi_directional_analysis = var.is_bi_directional_analysis
  }
}

resource "oci_vn_monitoring_path_analyzer_test" "web_to_cms_subnet_connectivity" {
  compartment_id = oci_identity_compartment.net_compartment.id
  display_name   = "${var.npa_display_name}-web-to-cms"
  protocol       = 6
  freeform_tags  = var.freeform_tags

  source_endpoint {
    type      = "SUBNET"
    subnet_id = oci_core_subnet.web_worker_sub.id
    address   = var.web_source_ip
  }

  destination_endpoint {
    type      = "SUBNET"
    subnet_id = oci_core_subnet.cms_worker_sub.id
    address   = var.cms_destination_ip
  }

  protocol_parameters {
    type             = var.protocol
    destination_port = var.cms_destination_port
    source_port      = var.source_port
  }

  query_options {
    is_bi_directional_analysis = var.is_bi_directional_analysis
  }
}

resource "oci_vn_monitoring_path_analyzer_test" "cms_to_web_subnet_connectivity" {
  compartment_id = oci_identity_compartment.net_compartment.id
  display_name   = "${var.npa_display_name}-cms-to-web"
  protocol       = 6
  freeform_tags  = var.freeform_tags

  source_endpoint {
    type      = "SUBNET"
    subnet_id = oci_core_subnet.cms_worker_sub.id
    address   = var.cms_source_ip
  }

  destination_endpoint {
    type      = "SUBNET"
    subnet_id = oci_core_subnet.web_worker_sub.id
    address   = var.web_destination_ip
  }

  protocol_parameters {
    type             = var.protocol
    destination_port = var.web_destination_port
    source_port      = var.source_port
  }

  query_options {
    is_bi_directional_analysis = var.is_bi_directional_analysis
  }
}


