class ServiceTypes {
  static const List<String> allServices = [
    'Food Delivery',
    'Grocery Shopping',
    'House Cleaning',
    'Laundry Service',
    'Nail Tech/Makeup',
    'Plumbing',
    'Electrical Services',
    'HVAC',
    'Painting',
    'Carpentry',
    'Landscaping',
    'Babysitting/Childcare',
  ];

  static const List<String> diasporaSpecialBundles = [
    'Welcome Home Starter',
    'Wedding Ready',
    'Family Care Weekly',
    'Airport VIP',
  ];

  static const Map<String, List<String>> serviceRequirements = {
    'Food Delivery': [
      'Vehicle/Transport',
      'Food handling knowledge',
      'GPS navigation',
      'Customer service skills'
    ],
    'Grocery Shopping': [
      'Shopping experience',
      'Product selection skills',
      'Time management',
      'Vehicle/Transport'
    ],
    'House Cleaning': [
      'Cleaning supplies',
      'Experience with cleaning products',
      'Attention to detail',
      'Physical fitness'
    ],
    'Laundry Service': [
      'Washing machine access',
      'Ironing skills',
      'Fabric care knowledge',
      'Pickup/delivery service'
    ],
    'Nail Tech/Makeup': [
      'Professional certification',
      'Quality tools and products',
      'Portfolio of work',
      'Hygiene standards'
    ],
    'Plumbing': [
      'Plumbing certification',
      'Professional tools',
      'Emergency response',
      'Insurance coverage'
    ],
    'Electrical Services': [
      'Electrical certification',
      'Safety equipment',
      'Code compliance',
      'Insurance coverage'
    ],
    'HVAC': [
      'HVAC certification',
      'Specialized tools',
      'System diagnostics',
      'Insurance coverage'
    ],
    'Painting': [
      'Painting supplies',
      'Color consultation',
      'Surface preparation',
      'Quality finish'
    ],
    'Carpentry': [
      'Woodworking tools',
      'Measurement precision',
      'Safety equipment',
      'Project planning'
    ],
    'Landscaping': [
      'Gardening tools',
      'Plant knowledge',
      'Design skills',
      'Physical fitness'
    ],
    'Babysitting/Childcare': [
      'Background check',
      'First aid certification',
      'Child development knowledge',
      'References'
    ],
  };

  static const Map<String, String> serviceDescriptions = {
    'Food Delivery': 'Deliver food from restaurants and local vendors to customers across Ghana',
    'Grocery Shopping': 'Shop for groceries and essential items for busy families and diaspora',
    'House Cleaning': 'Professional cleaning services for homes, apartments, and offices',
    'Laundry Service': 'Washing, ironing, and garment care services',
    'Nail Tech/Makeup': 'Beauty services including manicures, pedicures, and makeup application',
    'Plumbing': 'Installation, repair, and maintenance of plumbing systems',
    'Electrical Services': 'Electrical installation, repair, and safety inspections',
    'HVAC': 'Heating, ventilation, and air conditioning services',
    'Painting': 'Interior and exterior painting for residential and commercial properties',
    'Carpentry': 'Woodworking, furniture repair, and custom carpentry projects',
    'Landscaping': 'Garden design, maintenance, and outdoor beautification',
    'Babysitting/Childcare': 'Professional childcare services for working parents',
  };

  static const Map<String, String> serviceIcons = {
    'Food Delivery': '🍽️',
    'Grocery Shopping': '🛒',
    'House Cleaning': '🧹',
    'Laundry Service': '👔',
    'Nail Tech/Makeup': '💅',
    'Plumbing': '🔧',
    'Electrical Services': '⚡',
    'HVAC': '❄️',
    'Painting': '🎨',
    'Carpentry': '🪚',
    'Landscaping': '🌱',
    'Babysitting/Childcare': '👶',
  };

  static List<String> getRequirementsForService(String serviceType) {
    return serviceRequirements[serviceType] ?? [];
  }

  static String getDescriptionForService(String serviceType) {
    return serviceDescriptions[serviceType] ?? 'Professional service';
  }

  static String getIconForService(String serviceType) {
    return serviceIcons[serviceType] ?? '🛠️';
  }
}