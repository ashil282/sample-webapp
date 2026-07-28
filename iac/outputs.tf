output "app_service_name" {
  value       = azurerm_linux_web_app.app.name
  description = "The name of the Azure Web App Service instance."
}

output "default_hostname" {
  value       = azurerm_linux_web_app.app.default_hostname
  description = "The default public FQDN of the Web App."
}
