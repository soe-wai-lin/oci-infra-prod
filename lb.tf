
# resource "oci_load_balancer_load_balancer" "lb" {
#   compartment_id = oci_identity_compartment.app_compartment.id
#   display_name   = var.lb_display_name

#   shape          = var.lb_shape          # flexible or fixed shapes
#   subnet_ids     = [oci_core_subnet.lb_subnet.id]       # usually a PUBLIC subnet
#   is_private     = var.is_private        # false for public LB
#   reserved_ips {
#     id = oci_core_public_ip.lb_reserved_ip.id
#   }

#   dynamic "shape_details" {
#     for_each = var.lb_shape == "flexible" ? [1] : []
#     content {
#       maximum_bandwidth_in_mbps = var.max_bandwidth
#       minimum_bandwidth_in_mbps = var.min_bandwidth
#     }
#   }

#   freeform_tags = var.freeform_tags
# }

# # ─────────────────────────────────────────────
# # Backend Set + Health Check
# # ─────────────────────────────────────────────

# resource "oci_load_balancer_backend_set" "backendset" {
#   name             = var.backendset_name
#   load_balancer_id = oci_load_balancer_load_balancer.lb.id

#   policy = "ROUND_ROBIN"

#   health_checker {
#     protocol = "HTTP"
#     url_path = "/"
#     port     = var.healthcheck_port
#   }
# }

# # ─────────────────────────────────────────────
# # Backends (Attach instances)
# # ─────────────────────────────────────────────

# # resource "oci_load_balancer_backend" "backends" {
# #   for_each = var.backend_ips

# #   load_balancer_id = oci_load_balancer_load_balancer.lb.id
# #   backend_set_name = oci_load_balancer_backend_set.backendset.name

# #   ip_address = each.value
# #   port       = var.backend_port
# #   weight     = 1
# # }

# # ─────────────────────────────────────────────
# # Listener (HTTP)
# # ─────────────────────────────────────────────

# resource "oci_load_balancer_listener" "http_listener" {
#   load_balancer_id = oci_load_balancer_load_balancer.lb.id
#   name             = var.listener_name
#   default_backend_set_name = oci_load_balancer_backend_set.backendset.name

#   port     = var.listener_port
#   protocol = "HTTP"
# }