Apipie.configure do |config|
  config.app_name                = "Counseling API"
  config.api_base_url            = "/api"
  config.copyright               = "&copy; 2023 zewdu erkyhun, Muhammad Aleem, Fitz Gerald, Emeka Emmanuel and Choice Osobor"
  config.doc_base_url            = "/api/docs"
  config.show_all_examples       = true
  config.app_info["1.0"]         = "The Counseling API allows clients to create therapist profiles and schedul appointments with their preferred therapists"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
