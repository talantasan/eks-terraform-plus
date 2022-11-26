resource "kubernetes_namespace" "common" {
  metadata {
    annotations = {
      name = var.chart_name
    }

    labels = {
     app = var.chart_name
    }

    name = var.chart_name
  }
}

variable chart_name {
  type        = string
  default     = "new"
  description = "define a namespace for the chart"
}
