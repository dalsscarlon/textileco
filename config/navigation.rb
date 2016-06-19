# -*- coding: utf-8 -*-
# Configures your navigation

SimpleNavigation::Configuration.run do |navigation|
	
	navigation.renderer = SimpleNavigationRenderers::Bootstrap3
	navigation.items do |primary|

		primary.item :employees, "Employees", employees_path
	end
end
