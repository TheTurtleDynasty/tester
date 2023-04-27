
terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "=> 3.0.0"
    }
  }
}

locals {
  # Directories start with "C:..." on Windows; All other OSs use "/" for root.
  is_windows = substr(pathexpand("~"), 0, 1) == "/" ? false : true
}

resource "null_resource" "cli_command" {
  provisioner "local-exec" {
    # Ensure windows always uses PowerShell, linux/mac use their default shell.
    interpreter = local.is_windows ? ["PowerShell", "-Command"] : []

    # TODO: Replace the below with the Windows and Linux command variants
    command = local.is_windows ? "sleep 60" : "sleep 60"
  }
  triggers = {
    # TODO: Replace this psuedocode with one or more triggers that indicate (when changed)
    #       that the command should be re-executed.
    "test_a" = resource.my_resource.sample
  }
}

