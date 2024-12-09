Rails.application.routes.draw do
  resources :students, only: [ :create, :destroy ]

  scope "/schools/:school_id" do
    get "school_classes", to: "school_classes#get_class_list"
  end

  scope "/schools/:school_id" do
    resources :school_classes, only: [ :index ] do
      get "students", to: "school_classes#get_class_students_list"
    end
  end

end
