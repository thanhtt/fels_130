Rails.application.routes.draw do

  root "staticpages#home"
  get "about" => "staticpages#about"
  get "contact" => "staticpages#contact"
end
